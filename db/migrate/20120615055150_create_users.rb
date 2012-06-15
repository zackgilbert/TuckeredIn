class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitter_uid
      t.string :name
      t.string :username
      t.datetime :last_seen_at

      t.timestamps
    end
  end
end
