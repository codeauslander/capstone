json.id tag.id
json.name tag.name
json.images tag.images.each do |image|
  json.id image.id
  json.name image.name
  json.image_url image.image_url
  json.tags image.tags
end
json.image_tags tag.image_tags

