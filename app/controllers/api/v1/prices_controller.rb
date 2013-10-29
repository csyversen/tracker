module Api
  module V1
    class PricesController < ApplicationController
      http_basic_authenticate_with name: "stupid", password: "changemeforever", except: :show
      skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

      respond_to :json

      def show
        respond_with Product.find(params[:id]).prices
      end

    end
  end
end