class ImageTagsController < ApplicationController
  def index
    @image_tags = ImageTag.all
    render 'index.json.jbuilder'
  end
  def create
    @image_tag = ImageTags.new(
        tag_id: params[:tag_id],
        image_id: params[:image_id]
      )
    @image_tag.save
    render 'show.json.jbuilder'
  end
  def show
    @image_tag = ImageTag.find(params[:id])
    render 'show.json.jbuilder'
  end
  def update
    @image_tag = ImageTag.find(params[:id])
    render 'show.json.jbuilder'
  end
  def destroy
    image_tag = ImageTag.find(params[:id])
    image_tag.destroy
    render json:{message:"Succesfully destroyed image_tag ##{image_tag.id}."}
  end
end
