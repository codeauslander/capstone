class Image < ApplicationRecord
  has_many :game_images
  has_many :image_tags
  has_many :tags, through: :image_tags

  attr_reader :remote_url
  has_attached_file :image_url, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
    
  validates_attachment :image_url,
    content_type: {
      content_type: ["image/jpeg", "image/gif", "image/png"]
    }

  def remote_url=(url_value)
    self.image_url = URI.parse(url_value)
    @remote_url = url_value
    
  end

  def add_tags(tag_ids)
    if tag_ids.is_a?(String)
      tag_ids.split(", ").each{|tag_id| ImageTag.create(image_id: self.id, tag_id: tag_id.to_i)}
    else
      tag_ids.each{|tag_id| ImageTag.create(image_id:self.id,tag_id:tag_id)}
    end
  end

  def add_tag(tag_id)
    puts "*"*50
    puts tag_id
    ImageTag.create(image_id:self.id, tag_id:tag_id)
  end

  # def photos(search)
  #   # http://localhost:3000/photos/?search=m
  #   # search = params[:search]
  #   photos = Unirest.get("https://pixabay.com/api/?key=#{ENV["PHOTOS_API_KEY"]}&q=#{search}&image_type=photo").body
  # end

end
