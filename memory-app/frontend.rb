require 'unirest'
require 'paint'
require_relative 'play'
require_relative 'board'
# require 'catpix'

class Frontend
  # include Board
  include Play
  def run
    puts "Login in"
    auth = {}
    print "Email: "
    auth[:email] = "a@gmail.com"
    print "Password: "
    auth[:password] = "password"
    response = Unirest.post("http://localhost:3000/user_token",parameters:{
        auth:auth
      })
    data = response.body
    puts JSON.pretty_generate(data)
    jwt = data["jwt"]
    Unirest.default_header("Authorization","Bearer #{jwt}")
    user_email = "Welcome user: #{auth[:email]}"

    # system 'clear'
    running = true
    user_email = 'Welcome visitor'
    while running == true
      # system 'clear'
      puts "Test
        [0] catpix test"

      puts "#{user_email}
      Select an option
        [1] Sing Up
        [2] Login
        [3] Logout
        [4] Play"

      puts "Game options
      Select an option
      [g1] Show all"

      puts "Image options
      Select an option
        [i1] Show all
        [i2] Create
        [i3] Show one
        [i4] Update
        [i5] Destroy"

      puts "Tag options
      Select an option
        [t1] Show all
        [t2] Create
        [t3] Show one
        [t4] Update
        [t5] Destroy"

      option = gets.chomp
      case option
      when "0"
        Catpix::print_image "/public/icons8-cross-country-skiing.png",
        :limit_x => 1.0,
        :limit_y => 0,
        :center_x => true,
        :center_y => true,
        :bg => "white",
        :bg_fill => true,
        :resolution => "low"
      when "1"
        puts "New user account"
        parameters = {}
        print "Name: "
        parameters[:name] = gets.chomp
        print "Email: "
        parameters[:email] = gets.chomp
        print "Age: "
        parameters[:age] = gets.chomp
        print "Gender: "
        parameters[:gender] = gets.chomp
        print "Password: "
        parameters[:password] = gets.chomp
        print "Password confirmation: "
        parameters[:password_confirmation] = gets.chomp
        response = Unirest.post("http://localhost:3000/users",parameters:parameters)
        data = response.body
        puts JSON.pretty_generate(data)
      when "2"
        puts "Login in"
        auth = {}
        print "Email: "
        auth[:email] = gets.chomp
        print "Password: "
        auth[:password] = gets.chomp
        response = Unirest.post("http://localhost:3000/user_token",parameters:{
            auth:auth
          })
        data = response.body
        puts JSON.pretty_generate(data)
        jwt = data["jwt"]
        Unirest.default_header("Authorization","Bearer #{jwt}")
        user_email = "Welcome user: #{auth[:email]}"
      when "3"
        jwt = ""
        Unirest.clear_default_headers
        user_email = "Welcome user"
      when "4"
        puts "Playing"
        parameters = {}
        parameters[:rows] = 2
        parameters[:columns] = 2
        game = Unirest.post("http://localhost:3000/games",parameters:parameters)
        game_hash = game.body
        puts JSON.pretty_generate(game_hash)
       
        play(game_hash)  

      when "g1"
        response = Unirest.get("http://localhost:3000/games")
        data = response.body
        puts JSON.pretty_generate(data)         
      when "i1"
        response = Unirest.get("http://localhost:3000/images")
        data = response.body
        puts JSON.pretty_generate(data)
      when "i2"
        parameters = {}
        print "image_url: "
        parameters[:image_url]=gets.chomp
        response = Unirest.post("http://localhost:3000/images",parameters:parameters)
        data = response.body
        puts JSON.pretty_generate(data)
      when "i3"
        print "id: "
        id = gets.chomp
        response = Unirest.get("http://localhost:3000/images/#{id}")
        data = response.body
        puts JSON.pretty_generate(data)
      when "i4"
        parameters = {}
        print "id: "
        id = gets.chomp
        image = Unirest.get("http://localhost:3000/images/#{id}").body
        print "image_url (#{image["image_url"]}): "
        parameters[:image_url] = gets.chomp
        print "name (#{image["name"]}): "
        parameters[:name] = gets.chomp

        tags = Unirest.get("http://localhost:3000/tags")
        tags_data = tags.body
        puts JSON.pretty_generate(tags_data)

        print "Add tags by id: "
        parameters[:tag_ids] = gets.chomp
        parameters.delete_if { |key, value| value.empty? }

        response = Unirest.patch("http://localhost:3000/images/#{id}",parameters:parameters)

        data = response.body
        puts JSON.pretty_generate(data) 

      when "i5"
        print "id: "
        id = gets.chomp
        response = Unirest.delete("http://localhost:3000/images/#{id}")
        data = response.body
        puts JSON.pretty_generate(data)
      when "t1"
        response = Unirest.get("http://localhost:3000/tags")
        data = response.body
        puts JSON.pretty_generate(data)
      when "t2"
        parameters = {}
        print "name: "
        parameters[:name] = gets.chomp
        response = Unirest.post("http://localhost:3000/tags",parameters:parameters)
        data = response.body
        puts JSON.pretty_generate(data)
      when "t3"
        print "id: "
        id = gets.chomp
        response = Unirest.get("http://localhost:3000/tags/#{id}")
        data = response.body
        puts JSON.pretty_generate(data)
      when "t4"
        parameters = {}
        print "id: "
        id = gets.chomp
        tag = Unirest.get("http://localhost:3000/tags/#{id}").body
        print "name (#{tag["name"]}): "
        parameters[:name] = gets.chomp

        images_response = Unirest.get("http://localhost:3000/images")
        images_data = images_response.body
        puts JSON.pretty_generate(images_data)

        print "Add images by id: "
        parameters[:image_ids] = gets.chomp
        parameters.delete_if { |key, value| value.empty? }

        response = Unirest.patch("http://localhost:3000/tags/#{id}",parameters:parameters)

        data = response.body
        puts JSON.pretty_generate(data)
      when "t5"
        print "id: "
        id = gets.chomp
        response = Unirest.delete("http://localhost:3000/tags/#{id}")
        data = response.body
        puts JSON.pretty_generate(data)
      else
        # system 'clear'
        exit
      end
      print "Enter q to Quit or hit enter to continue"
      option = gets.chomp
      if option == "q"
        # system 'clear'
        running false
      end
    end
  end
end

Frontend.new.run
