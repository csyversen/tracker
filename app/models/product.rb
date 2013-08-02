class Product < ActiveRecord::Base

  has_many :prices
  has_and_belongs_to_many :users

end
