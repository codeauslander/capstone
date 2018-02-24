class ImagesController < ApplicationController

  def index
    @images = Image.all 
    render 'index.json.jbuilder'
  end
  def create
    @image = Image.new(
        image_url:params[:image_url]
      )
    @image.add_tags(params[:tag_ids]) if params[:tag_ids]
    @image.save
    render 'show.json.jbuilder'
  end
  def show
    @image = Image.find(params[:id])
    render 'show.json.jbuilder'
  end
  def update
    @image = Image.find(params[:id])
    @image.image_url = params[:image_url] || @image.image_url
    @image.name = params[:name] || @image.name
    @image.add_tags(params[:tag_ids]) if params[:tag_ids]
    # add_tags(params[:tag_ids]) if params[:tag_ids]
    @image.save
    render 'show.json.jbuilder'
  end
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    render json:{message:"Image ##{@image.id} succesfully destroyed."}
  end

  # private
  # def add_tags(tag_ids)
  #   tag_ids.split(", ").each{|tag_id| ImageTag.create(image_id: self.id, tag_id: tag_id.to_i)}
  # end
end
