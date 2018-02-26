class GamesController < ApplicationController
  before_action :authenticate_user, only: [:create]

  def index
    @games = current_user.games.last(11)
    render 'index.json.jbuilder'
  end
  def create

    amount_images = (params[:amount_images] == nil) || (params[:amount_images] == "") ? 2 : params[:amount_images].to_i
    rows = multiples(amount_images)[:rows]
    columns = multiples(amount_images)[:columns]

    @game = Game.create(
        user_id: current_user.id , 
        done:false, 
        rows:rows, 
        columns:columns,
        score: 0
      )

    tag_name = (params[:tag] == nil || "") ? "ski_jumping" : params[:tag]
    tag = Tag.find_by(name: tag_name)
    
    images = tag.images
    random_images_ids = images.map{|image|image.id}.shuffle!

    game_images_hashes = []
    2.times do 
      amount_images.times do |index|
        game_images_hashes << {status: "normal", image_id: random_images_ids[index], game_id: @game.id}
      end
    end

    game_images_hashes.shuffle!
    game_images_hashes.each do |game_image_hash|
      GameImage.create(game_image_hash)
    end
    
    render 'show.json.jbuilder'
  end
  def show
    @game = Game.find(params[:id])
    @game.update_flipped
    render 'show.json.jbuilder'
  end
  #continue game
  def update
    @game = Game.find(params[:id])
    
    render 'show.json.jbuilder'
  end
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    render json:{message:"Succesfully destroyed game ##{@game.id}."}
  end

  private
  def multiples(number)
    # number += 1 if number % 2 != 0
    return nil if number % 2 != 0
    return {rows: 1, columns: 2} if number == 2
    list = (2..(number / 2)).to_a.delete_if { |n| n unless number % n == 0}
    middle_index = list.length/2
    {rows: list[middle_index - 1], columns: list[middle_index]}
  end
end
  