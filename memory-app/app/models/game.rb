class Game < ApplicationRecord
  belongs_to :user, optional: true
  has_many :game_images
  has_many :images, through: :game_images

  def update_flipped
    flip_images = game_images.where(status:"flipped")
    if flip_images.length == 1
      game_images.where(status:"viewed").update_all(status:"normal")
    end
    if flip_images.length == 2
      if flip_images[0].image_id == flip_images[1].image_id
        flip_images.update_all(status:"ok")   
      else
        flip_images.update_all(status:"viewed")
      end
    end
    self.done = is_winner
    self.score = game_images.where(status:"ok").count
    return true
  end

  def is_winner
    game_images.length == game_images.where(status:"ok").length ? true : false
  end

  def board
    board = []
    index = 0
    sort_game_images = game_images.sort
    self.rows.times do |row|
      board_row = []
      self.columns.times do |column|
        game_image = sort_game_images[index]
        board_row << {row: row, column: column,status: game_image.status,image_url: game_image.image.image_url, name: game_image.image.name, game_image_id: game_image.id, image_id: game_image.image_id}
        index += 1
      end
      board << board_row
    end
    board
  end
end

