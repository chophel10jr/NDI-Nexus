class CreatePassportSizePhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :passport_size_photos do |t|
      t.text :passport_size_photo
      t.references :verifiable_credential, null: false, foreign_key: true

      t.timestamps
    end
  end
end
