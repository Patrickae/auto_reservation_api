require 'rails_helper'

RSpec.describe "Vehicles", type: :request do
  describe "GET /index" do
    it "returns all vehicles" do
      customer = FactoryBot.create(:customer, name: 'Jim', phone_number: '7045828976', email: 'jim@gmail.com')
      vehicle = FactoryBot.create(:vehicle, customer_id: customer.id, year: 2016, make: 'Lexus', model: 'RX350')
      get "/api/v1/vehicles"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).count).to eq(1)
    end
  end

  describe 'POST vehicle' do
    it 'creates a new vehicle' do
      customer = FactoryBot.create(:customer, name: 'Jim', phone_number: '7045828976', email: 'jim@gmail.com')
      expect {
        post '/api/v1/vehicles', params: { vehicle: { customer_id: customer.id, year: 2016, make: 'Lexus', model: 'RX350' } }
      }.to change { Vehicle.count }.from(0).to(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT vehicle' do
    it 'updates and returns a vehicle' do
      customer = FactoryBot.create(:customer, name: 'Jim', phone_number: '7045828976', email: 'jim@gmail.com')
      vehicle = FactoryBot.create(:vehicle, customer_id: customer.id, year: 2016, make: 'Hona', model: 'Civic')
      put "/api/v1/vehicles/#{vehicle.id}", params: { vehicle: { model: "Accord" } }
      expect(JSON.parse(response.body)['model']).to eq('Accord')
    end
  end

  describe 'DELETE vehicle' do
    it 'deletes an existing customer' do
      customer = FactoryBot.create(:customer, name: 'Jim', phone_number: '7045828976', email: 'jim@gmail.com')
      vehicle = FactoryBot.create(:vehicle, customer_id: customer.id, year: 2016, make: 'Lexus', model: 'RX350')
      expect {
        delete "/api/v1/vehicles/#{vehicle.id}"
      }.to change {Vehicle.count}.from(1).to(0)
      expect(response).to have_http_status(:no_content)
    end
  end
end
