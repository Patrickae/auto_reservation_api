module Api
  module V1
    class AppointmentsController < ApplicationController
      before_action :get_active_appointments, only: [:index]
      before_action :get_appointment, only: [:destroy, :update]
      def index
        render json: @appointments
      end

      def create
        begin
          appointment = create_appointment
          return unless appointment.present?
          if appointment.save
            render json: appointment, status: :created
          else
          render json: appointment.errors, status: :unprocessable_entity
          end
        rescue ActiveModel::ValidationError => invalid
          render json: invalid.model.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @appointment.destroy!

        head :no_content
      end

      def update
        @appointment.update(appointment_params)

        render json: @appointment
      end

      private

      def get_appointment
        @appointment = Appointment.find(params[:id])
      end

      def get_active_appointments
        apts = Appointment.where('start_time > ?', Date.today)
        @appointments = {
          appointments: apts.map{|apt|  AppointmentSerializer.new(apt)},
          times: apts.pluck(:start_time)
        } 
      end

      def create_appointment
        ActiveRecord::Base.transaction do
          customer = new_item(Customer, customer_params)
          customer.save! if customer
          vehicle = new_item(Vehicle, vehicle_params(customer.try(:[], :id)))
          vehicle.save! if vehicle 
          Appointment.new(appointment_params(vehicle.try(:[], :id)))
        end
      end

      def new_item(klass, params)
        return unless params.present?
        klass.new(params)
      end

      def appointment_params(vehicle_id = nil)
        apt_params = params.require(:appointment).permit(:vehicle_id, :start_time, :end_time, :notes)
        vehicle_id.present? ? apt_params.merge(vehicle_id: vehicle_id) : apt_params
      end

      def customer_params
        return unless params[:customer]
        params.require(:customer)&.permit(:name, :phone_number, :email)
      end

      def vehicle_params(customer_id = nil)
        return unless params[:vehicle]
        v_params = params.require(:vehicle)&.permit(:customer_id, :year, :make, :model, :vin)
        customer_id.present? ? v_params.merge(customer_id: customer_id) : v_params
      end
    end
  end
end 
