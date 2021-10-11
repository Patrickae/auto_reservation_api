module Api
  module V1
    class VehiclesController < ApplicationController
      before_action :fetch_vehicle, only: [:update, :destroy]
      def index
        render json: Vehicle.all, each_serializer: VehicleSerializer
      end

      def create
        vehicle = Vehicle.new(vehicle_params)
        if vehicle.save
          render json: vehicle, status: :created
        else
          render json: vehicle.errors, status: :unprocessable_entity
        end
      end

      def update
        @vehicle.update(vehicle_params)
        render json: @vehicle
      end

      def destroy
        Vehicle.find(params[:id]).destroy!

        head :no_content
      end

      private

      def fetch_vehicle
        @vehicle = Vehicle.find(params[:id])
      end

      def vehicle_params
        params.require(:vehicle).permit(:customer_id, :year, :make, :model, :vin)
      end
    end
  end
end
