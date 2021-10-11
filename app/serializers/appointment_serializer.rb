class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time, :notes, :complete, :vehicle

  def complete
    object.end_time.past?
  end

  def vehicle
    VehicleSerializer.new(object.vehicle)
  end
end
