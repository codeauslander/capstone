json.id game.id
json.rows game.rows
json.columns game.columns
json.score game.score
json.done game.done

# adding the game_images of the game to the output
json.game_images game.game_images.order(:id).each do |game_image|
  json.id game_image.id
  json.status game_image.status
  json.image_id game_image.image_id 

  # adding the image of every game_image to the output
  json.image do 
    json.id game_image.image.id
    json.image_url game_image.image.image_url
    json.name game_image.image.name
  end
end