class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.boolean :done
      t.integer :rows
      t.integer :columns
      t.integer :score
      t.integer :user_id
      t.timestamps
    end
  end
end
