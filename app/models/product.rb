class Product < ActiveRecord::Base

  has_many :prices
  has_and_belongs_to_many :users

  #scope :current_price, -> { prices.last }

  def current_price
    prices.last.price
  end

  def lowest_price
    prices.minimum("price")
  end

end
