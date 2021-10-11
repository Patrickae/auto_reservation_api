require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  describe "GET appointments" do
    it "returns all appointments" do
      customer = FactoryBot.create(:customer, name: 'Jim', phone_number: '7045828976', email: 'jim@gmail.com')
      vehicle = FactoryBot.create(:vehicle, customer_id: customer.id, year: 2016, make: 'Lexus', model: 'RX350')
      appointment = FactoryBot.create(:appointment, vehicle_id: vehicle.id, start_time: '2021-12-22 10:30', end_time: '2021-12-22 11:15', notes: 'this is a note')
      get "/api/v1/appointments/"
      expect(response).to have_http_status(:success)
      p JSON.parse(response.body)
      expect(JSON.parse(response.body)["appointments"].count).to eq(1)
    end
  end

  describe "POST appointmets" do
    it "create a new appointment" do
      customer = FactoryBot.create(:customer, name: 'Jim', phone_number: '7045828976', email: 'jim@gmail.com')
      vehicle = FactoryBot.create(:vehicle, customer_id: customer.id, year: 2016, make: 'Lexus', model: 'RX350')
      expect {
        post "/api/v1/appointments", params: {appointment: {start_time: '2021-10-22 10:30', end_time: '2021-10-22 11:15', vehicle_id: vehicle.id, notes: 'This is a note'}}
      }.to change {Appointment.count}.from(0).to(1)
      expect(response).to have_http_status(:created)
    end

    it "creates a customer, vehicle, and appointment" do
      expect {
        post "/api/v1/appointments", params: {
          customer: {
            name: "Billy", phone_number: "6785551234", email: "billy@gmail.com"
          },
          vehicle: {
            year: 2010, make: "Subaru", model: "WRX"
          },
          appointment: {
            start_time: "2021-10-15 14:00", end_time: "2021-10-15 15:00", notes: "replace fuel tank sensor"
          }
        }
      }.to change {Appointment.count}.from(0).to(1)
      expect(Customer.count).to eq(1)
      expect(Vehicle.count).to eq(1) 
    end
  end

  describe 'PUT appointment' do
    it 'updates and returns an appointment' do
      customer = FactoryBot.create(:customer, name: 'Jim', phone_number: '7045828976', email: 'jim@gmail.com')
      vehicle = FactoryBot.create(:vehicle, customer_id: customer.id, year: 2016, make: 'Lexus', model: 'RX350')
      appointment = FactoryBot.create(:appointment, vehicle_id: vehicle.id, start_time: '2021-12-22 10:30', end_time: '2021-12-22 11:15', notes: 'regular scheduled service')
      put "/api/v1/appointments/#{appointment.id}", params: { appointment: { start_time: '2021-12-22 12:30', end_time: '2021-12-22 13:15'} }
      expect(JSON.parse(response.body)['start_time']).to eq("2021-12-22T12:30:00.000Z")
      expect(JSON.parse(response.body)['end_time']).to eq("2021-12-22T13:15:00.000Z")
    end
  end

  describe 'DELETE appointment' do
    it 'deletes an existing appointment' do
      customer = FactoryBot.create(:customer, name: 'Jim', phone_number: '7045828976', email: 'jim@gmail.com')
      vehicle = FactoryBot.create(:vehicle, customer_id: customer.id, year: 2016, make: 'Lexus', model: 'RX350')
      appointment = FactoryBot.create(:appointment, vehicle_id: vehicle.id, start_time: '2021-12-22 10:30', end_time: '2021-12-22 11:15', notes: 'regular scheduled service')
      expect {
        delete "/api/v1/appointments/#{appointment.id}"
      }.to change {Appointment.count}.from(1).to(0)
      expect(response).to have_http_status(:no_content)
    end
  end

end
