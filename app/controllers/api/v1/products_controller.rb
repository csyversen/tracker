module Api
  module V1
    class ProductsController < ApplicationController
      http_basic_authenticate_with name: "stupid", password: "changemeforever"
      skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

      respond_to :json

      def index
        respond_with Product.all
      end

      def show
        respond_with Product.find(params[:id])
      end

      def create
        respond_with Product.create(params[:product])
      end

      def update
        @product = Product.find(params[:id])
        p = Price.new
        p.price = params[:price]
        @product.prices << p
        respond_with @product
      end

    end
  end
end