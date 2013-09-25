require 'rest_client'
require 'json'


class TrackerApi
  def initialize
    @url = 'https://agile-ridge-9247.herokuapp.com/api/products'
    #@product = 'https://agile-ridge-9247.herokuapp.com/api/products'
  end

  def get_products
    response = RestClient.get(@url, { :accept => :json } )
    return response.body
  end

  def get_product(id)
    response = RestClient.get(@url, { :accept => :json, params: { id: id } } )

    return response.body
  end

  def print_products
    hash = JSON.parse(get_products)
    puts "here are some products!"

    hash.each do |p|
      puts "Name: #{p['name']} and asin: #{p['asin']}"
    end
  end
end

api = TrackerApi.new
api.print_products

puts api.get_product(2)

