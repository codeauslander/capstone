class GameImage < ApplicationRecord
  belongs_to :game 
  belongs_to :image
end
