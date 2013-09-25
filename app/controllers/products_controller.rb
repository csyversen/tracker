class ProductsController < ApplicationController

  def index
    @products = Product.paginate(page: params[:page])

    respond_to do |format|
      format.html 
      format.json { render json: @products }
    end
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

    respond_to do |format|
      format.html 
      format.json { render json: @product }
    end
  end


#################################################################
  private
#################################################################
  
  def product_params
    params.require(:product).permit(:url)
  end


end
