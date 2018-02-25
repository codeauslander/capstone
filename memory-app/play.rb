require 'unirest'
require_relative "board"
module Play
  include Board
  def show_board(parameters)
    # system 'clear'

    game_id = parameters[:game_id]
    response = Unirest.get("http://localhost:3000/games/#{game_id}")
    data = response.body

    option = parameters[:option] || "game"
    case option
    when "test"
      list = []
      data["game_images"].each do |game_image| 
        list << "-#{game_image["id"]}-#{game_image["image"]["name"]}"
      end
      Board.print_board({array: list})
    when "game"
      list = []
      data["game_images"].each do |game_image|
        if game_image["status"] === "ok"
          list << "---"
        elsif game_image["status"] == "flipped" || game_image["status"] == "viewed"
          list << "#{game_image["image"]["name"]}*"
        elsif game_image["status"] == "normal"
          list << "#{game_image["id"]}"
        end
      end
      Board.print_board({array: list})
    end
    puts "" 
  end
  def winner(parameters)
    game_id = parameters[:game_id]
    response = Unirest.get("http://localhost:3000/games/#{game_id}")
    data = response.body
    data["done"]
  end
  def play(game_hash)

    while true
      show_board({game_id: game_hash["id"], option: "test"})
      show_board({game_id: game_hash["id"]})

      print 'guess: '
      guess_id = gets.chomp
      flip = Unirest.patch("http://localhost:3000/game_images/#{guess_id}", parameters:{status:"flipped"})
      
      exit if gets.chomp == "q" 
      if winner({game_id: game_hash["id"]})
        puts "Winner" 
        exit
      end  
    end
  end
end

