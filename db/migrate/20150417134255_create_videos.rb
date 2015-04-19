class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :file
      t.string :uid

      t.timestamps null: false
    end
    add_index :videos, :uid
  end
end
