require 'uri/http'
require 'nokogiri'
require 'open-uri'

class Product < ActiveRecord::Base

  has_many :prices
  has_and_belongs_to_many :users

  before_create :check_amazon
  before_create :check_if_product_exists

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

    #self.users << current_user
    self.sale_site = domain.domain

    doc = Nokogiri::HTML(open("#{self.url}"))
    price = doc.css("span#actualPriceValue")[0].text[1..-1]
    self.name = doc.css("span#btAsinTitle")[0].text

    p = Price.new

    p.price = price
    self.prices << p

  end

  def check_if_product_exists
    # if the product already exists, we can just add this user as a 'subscriber' to the product. We don't need a new entry
    if(p = Product.find_by(url: self.url))
      p.users << self.current_user 
    else

    end
  end


end
