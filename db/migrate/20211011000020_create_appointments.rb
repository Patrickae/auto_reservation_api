class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.integer :vehicle_id, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.text :notes

      t.timestamps
    end
  end
end
