class CreateESignatures < ActiveRecord::Migration[8.0]
  def change
    create_table :e_signatures do |t|
      t.text :e_signature
      t.references :verifiable_credential, null: false, foreign_key: true

      t.timestamps
    end
  end
end
