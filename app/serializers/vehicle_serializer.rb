class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :year, :make, :model, :vin
  has_one :customer
end
