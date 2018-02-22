class Game < ApplicationRecord
  belongs_to :user
  has_many :game_images
  has_many :images, through: :game_images

  def update_flipped
    game_images.where(status:"viewed").update_all(status:"normal")
    flip_images = game_images.where(status:"flipped")
    if flip_images.length == 2
      if flip_images[0].image_id == flip_images[1].image_id
        flip_images.update_all(status:"ok")   
      else
        flip_images.update_all(status:"viewed")
      end
    end
    done = is_winner
  end

  def is_winner
    game_images.length == game_images.where(status:"ok").length ? true : false
  end
end

