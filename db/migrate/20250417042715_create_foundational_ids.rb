class CreateFoundationalIds < ActiveRecord::Migration[8.0]
  def change
    create_table :foundational_ids do |t|
      t.string :full_name
      t.string :gender
      t.date :date_of_birth
      t.string :id_type
      t.string :id_number
      t.string :citizenship
      t.string :household_number
      t.string :blood_type
      t.references :verifiable_credential, null: false, foreign_key: true

      t.timestamps
    end
  end
end
