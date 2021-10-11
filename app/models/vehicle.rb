class Vehicle < ApplicationRecord
  validates_presence_of :year, :make, :model, :customer_id
  validates_uniqueness_of  :vin, allow_blank: true

  belongs_to :customer
  has_many :appointments
end
