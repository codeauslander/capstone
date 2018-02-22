require 'unirest'
module Play
  def show_board(parameters)
    # system 'clear'

    game_id = parameters[:game_id]
    response = Unirest.get("http://localhost:3000/games/#{game_id}")
    data = response.body

    option = parameters[:option] || "game"
    case option
    when "test"
      data["game_images"].each do |game_image| 
        puts "-#{game_image["id"]}-#{game_image["image"]["name"]}"
      end
    when "game"
      data["game_images"].each do |game_image| 
        if game_image["status"] == "ok"
          puts "---"
        elsif game_image["status"] == "flipped" || game_image["status"] == "viewed"
          puts "#{game_image["image"]["name"]} *"
        else
         puts "-#{game_image["id"]}-"
        end
      end
    end
    puts "" 
  end
  def play(game_hash)

    while true
      show_board({game_id: game_hash["id"], option: "test"})
      show_board({game_id: game_hash["id"]})

      print 'guess: '
      guess_id = gets.chomp
      flip = Unirest.patch("http://localhost:3000/game_images/#{guess_id}", parameters:{status:"flipped"})

      show_board({game_id: game_hash["id"]})

      exit if gets.chomp == "q"
      if game_hash["done"] == "true"
        puts "You are a winner"
        exit
      end
    end
  end
end

