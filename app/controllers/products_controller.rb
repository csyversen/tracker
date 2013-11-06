class ProductsController < ApplicationController

  def index
    @products = Product.paginate(page: params[:page])
  end

  def new
    @product = Product.new
  end


  def create
    if(logged_in?)
      @product = current_user.products.create(product_params)
    else
      @product = Product.create(product_params)
    end

    if @product.save
      flash[:success] = "Successfully added a product!"
      redirect_to @product
    else
      flash[:error] = @product.errors.full_messages
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
    gon.prices = @product.prices
    gon.max_price = @product.prices.maximum('price')
    gon.min_price = @product.prices.minimum('price')
  end



#################################################################
  private
#################################################################
  
  def product_params
    params.require(:product).permit(:url)
  end


end
