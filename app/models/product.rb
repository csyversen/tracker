require 'uri/http'
require 'open-uri'
require 'amazon/ecs'

class Product < ActiveRecord::Base

  has_many :prices
  has_and_belongs_to_many :users

  before_create :get_asin
  before_create :check_amazon
  before_create :check_if_tracking_product

  validates_uniqueness_of :asin

  #scope :current_price, -> { prices.last }

  attr_accessor :url

  def current_price
    prices.last.price
  end

  def lowest_price
    prices.minimum("price")
  end

##########################################################
  private
##########################################################

  def get_asin
    unless self.url.scan(/http:\/\/(?:www\.|)amazon\.com\/(?:gp\/product|[^\/]+\/dp|dp)\/([^\/]+)/).flatten[0].empty?
      self.asin = self.url.scan(/http:\/\/(?:www\.|)amazon\.com\/(?:gp\/product|[^\/]+\/dp|dp)\/([^\/]+)/).flatten[0]
      puts "ASIN!!!: #{self.asin}"
    else
      false
    end
  end


  def check_amazon

    Amazon::Ecs.options = {
      :associate_tag => ENV['ASSOCIATE_TAG'],
      :AWS_access_key_id => ENV['ACCESS_KEY_ID'],
      :AWS_secret_key => ENV['SECRET_KEY']
    }

    item = Amazon::Ecs.item_lookup(self.asin, { response_group: 'Offers, Small' } )
    if (item.is_valid_request? && !item.has_error? && !item.items.empty?)
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
    if(p = Product.find_by(asin: self.asin))
      p.users << self.current_user
    end
  end


end
