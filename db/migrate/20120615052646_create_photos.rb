class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image, :null => false
      t.string :source_url

      t.timestamps
    end
  end
end
