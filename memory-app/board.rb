require './images_board.rb'
class Board
  attr_accessor :board
  def initialize(parameters)

    @board = parameters[:images_board]
  end
  def change_state_image(parameters)
    row = parameters[:row]
    column = parameters[:column]
    @board[row][column] = "*"
  end
  def is_pair(parameters)
    first_image = parameters[:first_image]
    second_image = parameters[:second_image]

    if image(first_image) == image(second_image)
      change_state_image(first_image)
      change_state_image(second_image)
      return true
    end
    return false
  end
  def image(parameters)
    row = parameters[:row]
    column = parameters[:column]
    @board[row][column]
  end
  def board_dup(board)
    board.map { |row| 
      row.map{ |item|
        item.dup
      }  
    }
  end
  def hide_board()
    
    hidden_board = board_dup(@board)
    # p hidden_board
    hidden_board.length.times do |row|
      hidden_board[0].length.times do |column|
        hidden_board[row][column] = (hidden_board[row][column]["status"] == "show" ? hidden_board[row][column] : "[#{row},#{column}]")
      end
    end
    hidden_board
  end
  def filter_board(board)
    # index = 0
    # p board
    filtered_board = []
    board.length.times do |row|  
      board_row = []
      board[0].length.times do |column|
        board_row << (board[row][column]["name"] || board[row][column])
        # index += 1
      end
      filtered_board << board_row
    end
    filtered_board
  end
  def print_board(board)
    
    board.length.times do |row|
      p board[row]
    end
  end
  def show_board(parameters)
    type = parameters[:type]
    case type
    when "hidden"
      # p hide_board
      print_board(filter_board(hide_board))
    when "normal"
      print_board(filter_board(@board))
    when "raw"
      print_board(board)
    end    
  end


end

# images = [
#   {
#     image_url:"www.image.com",
#     hight: 1,
#     width: 1,
#     name: "a"
#   },
#   {
#     image_url:"www.image.com",
#     hight: 1,
#     width: 1,
#     name: "b"
#   },
#   {
#     image_url:"www.image.com",
#     hight: 1,
#     width: 1,
#     name: "c"
#   },
#   {
#     image_url:"www.image.com",
#     hight: 1,
#     width: 1,
#     name: "d"
#   },
#   {
#     image_url:"www.image.com",
#     hight: 1,
#     width: 1,
#     name: "e"
#   },
#   {
#     image_url:"www.image.com",
#     hight: 1,
#     width: 1,
#     name: "f"
#   },
#   {
#     image_url:"www.image.com",
#     hight: 1,
#     width: 1,
#     name: "g"
#   },
#   {
#     image_url:"www.image.com",
#     hight: 1,
#     width: 1,
#     name: "h"
#   },
#   {
#     image_url:"www.image.com",
#     hight: 1,
#     width: 1,
#     name: "i"
#   },
#   {
#     image_url:"www.image.com",
#     hight: 1,
#     width: 1,
#     name: "j"
#   }

# ]
# parameters_images_board = {}
# parameters_images_board[:rows] = 4
# parameters_images_board[:columns] = 5
# parameters_images_board[:images] = images

# images_board = Images_board.new(parameters_images_board).board
# parameters_board = {}
# parameters_board[:images_board] = images_board


# board = Board.new(parameters_board)

# board.show_board({type:"normal"})
# puts "-" * 25

# board.show_board({type:"hidden"})

# play = board.is_pair(
#                       {
#                         first_image:{
#                           row:1,
#                           column:1
#                         },
#                         second_image:{
#                           row:1,
#                           column:2
#                         }
#                       })

# play = board.is_pair(
#                       {
#                         first_image:{
#                           row:1,
#                           column:1
#                         },
#                         second_image:{
#                           row:1,
#                           column:1
#                         }
#                       })

# puts "-" * 25
# board.show_board({type:"normal"})

# puts "-" * 30
# board.show_board({type:"hidden"})


