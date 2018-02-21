class Image < ApplicationRecord
  has_many :game_images
  has_many :image_tags
  has_many :tags, through: :image_tags

  
end
