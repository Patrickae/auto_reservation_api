require 'rails_helper'

RSpec.describe 'Customers', type: :request do
  describe 'GET customers' do
    before do
      FactoryBot.create(:customer, name: 'Jim', phone_number: '7045828976', email: 'jim@gmail.com')
      FactoryBot.create(:customer, name: 'Bob', phone_number: '4047891234', email: 'bob@hotmail.biz')
    end

    it 'returns all customers' do
      get '/api/v1/customers'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).count).to eq(2)
    end

    it 'searches for customer by phone' do
      get '/api/v1/customers?phone_eq=7045828976'
      expect(JSON.parse(response.body).count).to eq(1)
    end
  end

  describe 'POST customer' do
    it 'creates a new customer' do
      expect {
        post '/api/v1/customers', params: { customer: { name: 'John Doe', phone_number: '7701234321', email: ''} }
      }.to change { Customer.count }.from(0).to(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT customer' do
    it 'updates and returns a customer' do
      customer = FactoryBot.create(:customer, name: 'Jim', phone_number: '7045828976', email: 'jim@gmail.com')
      put "/api/v1/customers/#{customer.id}", params: { customer: { email: "jim@aol.com" } }
      expect(JSON.parse(response.body)['email']).to eq('jim@aol.com')
    end
  end

  describe 'DELETE customer' do
    it 'deletes an existing customer' do
      customer = FactoryBot.create(:customer, name: 'Jim', phone_number: '7045828976', email: 'jim@gmail.com')
      expect {
        delete "/api/v1/customers/#{customer.id}"
      }.to change {Customer.count}.from(1).to(0)
      expect(response).to have_http_status(:no_content)
    end
  end

end
