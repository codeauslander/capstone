class GameImagesController < ApplicationController
  def index
    @game_images = GameImage.all
    render 'index.json.jbuilder'
  end
  def create
    @game_image = GameImages.new(
        game_id: params[:game_id],
        image_id: params[:image_id],
        status: params[:status]
      )
    @game_image.save
    render 'show.json.jbuilder'
  end
  def show
    @game_image = GameImage.find(params[:id])
    render 'show.json.jbuilder'
  end
  def update
    @game_image = GameImage.find(params[:id])
    @game_image.update(status: params[:status])
    render 'show.json.jbuilder'
  end
  def destroy
    game_image = GameImage.find(params[:id])
    game_image.destroy
    render json:{message:"Succesfully destroyed game_image ##{game_image.id}."}
  end
end
