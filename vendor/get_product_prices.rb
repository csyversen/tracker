require 'rest_client'
require 'json'
require 'amazon/ecs'


class TrackerApi
  def initialize
    #@url = 'https://agile-ridge-9247.herokuapp.com/api/products'
    @url = 'http://localhost:3000/api/products'
  end

  def get_products
    response = RestClient::Request.new(
      :method => :get,
      :url => @url,
      :user => "stupid",
      :password => "changemeforever",
      :content_type => "application/json"
      ).execute

    #RestClient.get(@url, params: { name: "stupid", password: "changemeforever" } )
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
      :associate_tag => '9767-7881-5383',
      :AWS_access_key_id => 'AKIAI4QUG3ULU7WGGVXA',
      :AWS_secret_key => '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'
    }

    hash.each do |p|
      puts "Name: #{p['name']} and asin: #{p['asin']}"

      
      item = Amazon::Ecs.item_lookup(p['asin'], { response_group: 'Offers, Small' } )
      if (item.is_valid_request? && !item.has_error? && !item.items.empty?)
        price = item.items[0].get('Offers/Offer/OfferListing/Price/Amount').to_f / 100
        puts price

        #RestClient.patch(@url<<"/#{p['id']}", params: { name: "stupid", password: "changemeforever", price: price } )

        RestClient.put("http://stupid:changemeforever@localhost:3000/api/products" + "/#{p['id']}", price: price, content_type: "application/json")        

        #response = RestClient::Request.new(
        #  :method => :put,
        #  :url => @url + "/#{p['id']}",
        #  :user => "stupid",
        #  :password => "changemeforever",
        #  :content_type => "application/json",
        #  :price => price
        #).execute



      else
        puts "The request wasn't valid or there was an error. Skipping this product..."
      end

      #p = Price.new

    end
  end


end

api = TrackerApi.new
#api.print_products

api.update_products
