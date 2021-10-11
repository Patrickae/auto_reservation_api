# Auto Reservation Api

Ruby version - 2.6.3

#### Additional Gems
 - rspec-rails - testing
 - phonelib - [phone number validation and normalization](https://github.com/daddyz/phonelib)
 - factory_bot_rails - testing helper
 - database_cleaner-active_record - clear database after each test
 - active_model_serializers - easy serialization


### Setup for use
 - bundle install
 - rails db:migrate
 - rails s

 Once the server is running, you can utilize [postman](https://www.postman.com/) to make POST requests to the API. make sure to set the header `Content-Type: application/json`. The body is easiest to send as raw json.
ex. 
```
{"name": "Jane", "phone": "1234567890", "email": "jane@gmail.com"}
```

[posman collection](https://www.getpostman.com/collections/80b714ee217e905d02cc)

  The API will allow you to create a customer, vehicle, or appointment individually, or create all three at once through the appointment route


  #### Routes
  - /api/v1/customers
    - query param `phone_eq` to search by phone number
  - /api/v1/vehicles
  - /api/v1/appointments
    - GET - will only show appointments with future start_times
    - also return list of only start_times for use in a calendar widget 

#### Testing
the `rspec` command will run the test suite

