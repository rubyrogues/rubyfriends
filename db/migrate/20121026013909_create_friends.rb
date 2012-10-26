class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :tweet_id
      t.string :tweet_text
      t.string :username
      t.string :media_url
      t.string :media_display_url
      t.string :thumb_file_name
      t.integer :retweet_count
      t.datetime :published_at
      t.boolean :published

      t.timestamps
    end
  end
end
