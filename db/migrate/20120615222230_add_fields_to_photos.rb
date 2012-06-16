class AddFieldsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :user_id, :integer
    add_column :photos, :approved_at, :datetime
  end
end
