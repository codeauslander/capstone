json.id game_image.id
json.status game_image.status
json.image_id game_image.image_id
json.image json.partial! game_image.image, partial: "images/image", as: :image

