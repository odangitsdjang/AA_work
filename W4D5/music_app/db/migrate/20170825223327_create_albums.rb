class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :year, null: false
      t.boolean :studio, default: true
      t.integer :band_id, null: false
      t.timestamps
    end
    add_index :albums, :band_id
  end
end
