require 'rest_client'
require 'json'
require 'amazon/ecs'
require 'yaml'


class TrackerApi
  def initialize
    @url = 'amazontracker.herokuapp.com/api/products' #'https://amazontracker.herokuapp.com/api/products' #'localhost:3000/api/products'
    @conf = YAML::load(File.open('aws.yml'))
  end


  def get_products
    response = RestClient::Request.new(
      :method => :get,
      :url => "https://#{@url}",
      :user => "stupid",
      :password => "changemeforever",
      :content_type => "application/json"
      ).execute

    return response.body
  end


  def get_product(id)
    response = RestClient.get(@url<<"/#{id}", params: { name: "stupid", password: "changemeforever" } )
    return response.body
  end


  def print_products
    hash = JSON.parse(get_products)
    puts "here are some products!"

    hash.each do |p|
      puts "Name: #{p['name']} and asin: #{p['asin']}"
    end
  end



  def update_products
    hash = JSON.parse(get_products)
    puts "Got list of products, grabbing updated prices..."

    Amazon::Ecs.options = {
      :associate_tag => @conf['associate_tag'],
      :AWS_access_key_id => @conf['access_key_id'],
      :AWS_secret_key => @conf['secret_key']
    }

    hash.each do |p|
      puts "Name: #{p['name']} and asin: #{p['asin']}"
      
      item = Amazon::Ecs.item_lookup(p['asin'], { response_group: 'Offers, Small, Images' } )
      if (item.is_valid_request? && !item.has_error? && !item.items.empty? && (item.items[0].get('Offers/Offer/OfferListing/Price/Amount').to_f / 100) != 0  )
        price = item.items[0].get('Offers/Offer/OfferListing/Price/Amount').to_f / 100
        puts price

        thumb_url = item.items[0].get('SmallImage/URL')
        puts thumb_url

        RestClient.put("https://stupid:changemeforever@#{@url}" + "/#{p['id']}", price: price, thumb_url: thumb_url )
      else
        puts "The request wasn't valid or there was an error. Skipping this product..."
      end

    end
  end


end

api = TrackerApi.new
#api.print_products

api.update_products
