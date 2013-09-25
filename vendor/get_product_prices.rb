require 'rest_client'
require 'json'


class TrackerApi
  def initialize
    @url = 'https://agile-ridge-9247.herokuapp.com/api/products.json'
  end

  def get_products
    response = RestClient.get(@url)
    return response.body
  end

  def print_products
    hash = JSON.parse(get_products)
    puts "here are some products!"

    hash.each do |p|
      puts "Name: #{p.name} and asin: #{p.asin}"
    end
  end
end

api = TrackerApi.new
api.print_products

#r = RestClient.get(url)

#puts r.body