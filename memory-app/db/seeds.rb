User.create!([
  {name: "a", email: "a@gmail.com", password_digest: "$2a$10$/hcXYA.r01NHaHJQqpr9lu25LR/FSUByp1xiZQ0hqWoiQQN9ni5zO", age: 21, gender: true}
])

Tag.create!([
  {name: "ski_jumping"},
  {name: "rock_and_roll"},
  {name: "ultra-instict"}
])

Image.create!([

  {image_url: "images/rock_and_roll/icons8-progressive-rock-filled.png", name: "rock"},
  {image_url: "images/rock_and_roll/icons8-rock-star.png", name: "star"},
  {image_url: "images/rock_and_roll/icons8-wallpaper-roll-filled.png", name: "roll"},

  {image_url: "images/ski_jumping/icons8-alpine-skiing.png", name: "la"},
  {image_url: "images/ski_jumping/icons8-bobsleight.png", name: "ob"},
  {image_url: "images/ski_jumping/icons8-curling.png", name: "uc"},
  {image_url: "images/ski_jumping/icons8-ice-hockey.png", name: "ci"},
  {image_url: "images/ski_jumping/icons8-nordic-combined.png", name: "on"},
  {image_url: "images/ski_jumping/icons8-short-track-speed-skating.png", name: "hs"},
  {image_url: "images/ski_jumping/icons8-snowboard.png", name: "ns"},
  {image_url: "images/ski_jumping/icons8-speed-skating.png", name: "ps"},
  {image_url: "images/ski_jumping/icons8-biathlon.png", name: "ib"},
  {image_url: "images/ski_jumping/icons8-cross-country-skiing.png", name: "rc"},
  {image_url: "images/ski_jumping/icons8-figure-skating.png", name: "if"},
  {image_url: "images/ski_jumping/icons8-freestyle-skiing.png", name: "rf"},
  {image_url: "images/ski_jumping/icons8-ski-jumping.png", name: "ks"},

])

ImageTag.create!([
  {tag_id: 2, image_id: 1},
  {tag_id: 2, image_id: 2},
  {tag_id: 2, image_id: 3},

  {tag_id: 1, image_id: 4},
  {tag_id: 1, image_id: 5},
  {tag_id: 1, image_id: 6},
  {tag_id: 1, image_id: 7},
  {tag_id: 1, image_id: 8},
  {tag_id: 1, image_id: 9},
  {tag_id: 1, image_id: 10},
  {tag_id: 1, image_id: 11},
  {tag_id: 1, image_id: 12},
  {tag_id: 1, image_id: 13},
  {tag_id: 1, image_id: 14},
  {tag_id: 1, image_id: 15},
  {tag_id: 1, image_id: 16}
])

Game.create!([
  
])
GameImage.create!([
  
])




