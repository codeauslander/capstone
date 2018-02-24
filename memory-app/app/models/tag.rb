class Tag < ApplicationRecord
  has_many :image_tags
  has_many :images, through: :image_tags

  def add_images(image_ids)
    image_ids.split(", ").each{|image_id| ImageTag.create(tag_id: self.id, image_id: image_id.to_i)}
  end
end
