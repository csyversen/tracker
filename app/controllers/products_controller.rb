class ProductsController < ApplicationController

  def index
    @products = Product.paginate(page: params[:page])
  end

  def new
    @product = Product.new
  end


  def create
    @product = Product.create(product_params)
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
  end


#################################################################
  private
#################################################################
  
  def product_params
    params.require(:product).permit(:url)
  end


end
