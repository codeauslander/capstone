class GameImagesController < ApplicationController
  # def create
  #   game_id = Game.all.each{|game| game.id if game.done == false}
  #   image_id = Image.all.each{|img| image.tag == "rock"}
  #   @game_image = GameImages.new(
  #       game_id:game_id,
  #       image_id:image_id
  #     )
  # end
  def index
    @game_images = GameImage.all
    # search = params[:search].to_i
    # p search

    # if search
    #   @game_images = @game_images.where("game_id = ?",search)
    #   images_ids = @game_images.map{|game_image| game_image.image_id}
    #   @images = Image.all.where("id in ?",images_ids)
    #   render json:@game_images.as_json
    # end
    render json:@game_images.as_json
  end
  def show
    @game_image = GameImage.find(params[:id])
    render json:@game_image
  end
end
