class CreateOshis < ActiveRecord::Migration[8.1]
  def change
    create_table :oshis do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :color, default: "#ff69b4"
      t.string :hashtag
      t.text :note
      t.string :twitter_url
      t.string :instagram_url
      t.string :youtube_url
      t.string :tiktok_url
      t.integer :status, default: 0, null: false
      t.integer :position, default: 0, null: false

      t.timestamps
    end
  end
end
