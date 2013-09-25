require 'active_resource'

class Product < ActiveResource::Base

  self.site = 'https://agile-ridge-9247.herokuapp.com/products'

end

prod = Product.find(:all)
#puts prod.errors.full_messages
puts prod.first.asin