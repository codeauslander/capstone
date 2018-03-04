class Image < ApplicationRecord
  has_many :game_images
  has_many :image_tags
  has_many :tags, through: :image_tags

  def add_tags(tag_ids)
    if tag_ids.is_a?(String)
      tag_ids.split(", ").each{|tag_id| ImageTag.create(image_id: self.id, tag_id: tag_id.to_i)}
    else
      tag_ids.each{|tag_id| ImageTag.create(image_id:self.id,tag_id:tag_id)}
    end
  end
end
