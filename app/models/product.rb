require 'uri/http'
#require 'nokogiri'
require 'open-uri'
require 'amazon/ecs'

class Product < ActiveRecord::Base

  has_many :prices
  has_and_belongs_to_many :users

  before_create :check_amazon
  before_create :check_if_tracking_product

  validates_uniqueness_of :url

  #scope :current_price, -> { prices.last }

  def current_price
    prices.last.price
  end

  def lowest_price
    prices.minimum("price")
  end

##########################################################
  private
##########################################################

  def check_amazon
    uri = URI.parse(self.url)
    domain = PublicSuffix.parse(uri.host) 

    stripped_url = uri.path
    asin = "" 

    self.sale_site = domain.domain

    #doc = Nokogiri::HTML(open("#{self.url}"))
    #price = doc.css("span#actualPriceValue")[0].text[1..-1]
    #self.name = doc.css("span#btAsinTitle")[0].text

    Amazon::Ecs.options = {
      :associate_tag => '',
      :AWS_access_key_id => '',
      :AWS_secret_key => ''
    }

    item = Amazon::Ecs.item_lookup(asin, { response_group: 'Offers, Small' } )
    if (item.is_valid_request? && !item.has_error? && !item.items.empty)
      self.name = item.items[0].get('ItemAttributes/Title')
      price = item.items[0].get('Offers/Offer/OfferListing/Price/Amount').to_f / 100
    else
      return false #"The request wasn't valid or there was an error"
    end

    p = Price.new

    p.price = price
    self.prices << p

  end

  def check_if_tracking_product
    # if the product already exists, we can just add this user as a 'subscriber' to the product. We don't need a new entry
    if(p = Product.find_by(url: self.url))
      p.users << self.current_user 
    else

    end
  end


end
