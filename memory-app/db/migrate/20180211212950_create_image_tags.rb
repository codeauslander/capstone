class CreateImageTags < ActiveRecord::Migration[5.1]
  def change
    create_table :image_tags do |t|
      t.integer :tag_id
      t.integer :image_id

      t.timestamps
    end
  end
end
