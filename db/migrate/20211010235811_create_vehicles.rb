class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.integer :year, null: false
      t.string :make, null: false
      t.string :model, null: false
      t.string :vin, unique: true, allow_blank: true
      t.integer :customer_id, null: false

      t.timestamps
    end
  end
end
