class CreateVerifiableCredentials < ActiveRecord::Migration[8.0]
  def change
    create_table :verifiable_credentials do |t|
      t.string :threaded_id
      t.boolean :shared, default: false

      t.timestamps
    end
  end
end
