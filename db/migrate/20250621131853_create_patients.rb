class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :gender
      t.string :phone
      t.text :address

      t.timestamps
    end
  end
end
