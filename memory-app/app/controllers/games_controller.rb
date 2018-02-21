class GamesController < ApplicationController
  def index
    @games = current_user.games
    render json:@games.as_json
  end
  def create
    @game = Game.create(
        user_id: current_user.id , 
        # done:params[:done], 
        done:false, 
        rows:params[:rows], 
        columns:params[:columns],
        score: params[:score]
      )
    images_by_tag = Tag.find_by(name:"ski_jumping").images
    @deck = create_deck(images_by_tag)
    @deck.length.times do |index|
      GameImage.create(status:"normal",image_id:@deck[index].id,game_id:@game.id)
    end
    @images = @game.images
    @game_images = @game.game_images
    # render json:@game.as_json
    render 'show.json.jbuilder'
  end

  def show
    @game = Game.find(params[:id])
    render json:@game.as_json
  end

  #continue game
  def update
    @game =Game.find(params[:id])
    render json:@game.as_json
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    render json:{message:"Succesfully destroyed game ##{@game.id}."}
  end


  private
  def create_deck(images_by_tag)
    last_index = images_by_tag.length - 1
    deck = []
    indexes = (0..last_index).to_a.shuffle
    10.times do
      index = indexes.pop || 0
      deck << images_by_tag[index]
    end
    deck
  end


end
