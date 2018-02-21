class Game < ApplicationRecord
  belongs_to :user
  has_many :game_images
  has_many :images, through: :game_images

end
