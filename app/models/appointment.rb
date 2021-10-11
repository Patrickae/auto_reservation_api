class Appointment < ApplicationRecord
  validates_presence_of :vehicle_id, :start_time, :end_time
  belongs_to :vehicle
end
