class AddStatusToGameImages < ActiveRecord::Migration[5.1]
  def change
    add_column :game_images, :status, :string
  end
end
