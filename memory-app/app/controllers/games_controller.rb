class GamesController < ApplicationController
  def index
    @games = current_user.games
    render json:@games.as_json
  end

  def create
    @game = Game.create(
        user_id: current_user.id , 
        # user_id: 0 , 
        # done:params[:done], 
        done:false, 
        rows:params[:rows], 
        columns:params[:columns],
        score: 0
      )
    images_by_tag = Tag.find_by(name:"ski_jumping").images
    deck = create_deck(images_by_tag)
    puts "deck #{deck}"
    2.times do 
      deck.each do |image|
        p GameImage.create(status: "normal", image_id: image.id, game_id: @game.id)

      end
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
    # last_index = images_by_tag.length - 1
    # last_index = 9 if last_index > 9
    last_index = 2
    deck = []
    indexes = (0..last_index).to_a.shuffle
    (last_index + 1).times do
      index = indexes.pop || 0
      deck << images_by_tag[index]
    end
    deck
  end


end
  