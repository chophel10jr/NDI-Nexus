class CreateMobileNumbers < ActiveRecord::Migration[8.0]
  def change
    create_table :mobile_numbers do |t|
      t.string :mobile_number
      t.string :mobile_number_type
      t.references :verifiable_credential, null: false, foreign_key: true

      t.timestamps
    end
  end
end
