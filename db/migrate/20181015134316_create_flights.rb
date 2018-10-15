class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :direction_type
      t.datetime :exact_time
      t.datetime :expected_time
      t.text :destination
      t.string :airline
      t.string :status

      t.timestamps
    end
  end
end
