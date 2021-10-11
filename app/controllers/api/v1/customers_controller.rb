module Api
  module V1
    class CustomersController < ApplicationController
      before_action :get_customers, only: [:index]
      before_action :get_customer, only: [:destroy, :update]
      def index
        @customers ||= Customer.all
        render json: @customers, each_serializer: CustomerSerializer
      end

      def create
        customer = Customer.new(customer_params)
        if customer.save
          render json: customer, status: :created
        else
          render json: customer.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @customer.destroy!

        head :no_content
      end

      def update
        @customer.update(customer_params)
        render json: @customer
      end

      private

      def get_customer
        @customer = Customer.find(params[:id])
      end

      def customer_params
        params.require(:customer).permit(:name, :phone_number, :email)
      end

      def get_customers
        return unless params[:phone_eq].present?
        @customers = Customer.where(phone_number: Phonelib.parse(params[:phone_eq]).full_e164).all

      end
    end
  end
end