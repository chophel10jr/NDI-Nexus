class CreateCurrentAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :current_addresses do |t|
      t.string :unit
      t.string :building
      t.string :street
      t.string :suburb
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.string :landmark
      t.references :verifiable_credential, null: false, foreign_key: true

      t.timestamps
    end
  end
end
