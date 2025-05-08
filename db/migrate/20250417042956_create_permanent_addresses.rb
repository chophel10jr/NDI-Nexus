class CreatePermanentAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :permanent_addresses do |t|
      t.string :house_number
      t.string :thram_number
      t.string :village
      t.string :gewog
      t.string :dzongkhag
      t.references :verifiable_credential, null: false, foreign_key: true

      t.timestamps
    end
  end
end
