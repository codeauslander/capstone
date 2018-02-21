class CreateGameImages < ActiveRecord::Migration[5.1]
  def change
    create_table :game_images do |t|
      t.integer :game_id
      t.integer :image_id
      t.timestamps
    end
  end
end
