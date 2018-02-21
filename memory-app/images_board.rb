
class Images_board
  attr_accessor :rows, :columns, :images, :game_images, :board
  def initialize(parameters)
    @rows = parameters[:rows]
    @columns = parameters[:columns]
    @images = parameters[:images]
    @game_images = parameters[:game_images]

    
    @board = []
    create_board
  end
  def board_dup(board)
    # board_hash = {}
    board.each { |row| 
      row.each{ |item|
        item.dup
        # board_hash << item.dup
      }  
    }
    # board_hash
  end
  def shuffle_images
    images_a = board_dup(@images)
    images_b = board_dup(@images)
    @images = (images_a + images_b).shuffle
    # p @images
    # @images = board_dup(@images)
    # p @images
  end
  def add_status_to_images
    @images.length.times do |index|
       @images[index]["status"] = (@game_images[index]["status"])
       @images[index]["game_image_id"] = (@game_images[index]["id"])
    end
    shuffle_images
  end
  def create_board
    add_status_to_images
    index = 0
    @rows.times do |row|  
       board_row = []
      @columns.times do |column|
        board_row << @images[index]
        index += 1
      end

      @board << board_row
    end
    @board
  end
  def print_board
   @board.length.times do |row|
      p @board[row]
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
# parameters = {}
# parameters[:rows] = 4
# parameters[:columns] = 5
# parameters[:images] = images

# Images_board.new(parameters).print_board

# class Board 
#   def initialize(rows, columns, empty_symbol, line_symbol)
    
#     @empty_symbol = empty_symbol
#     @board =initialize_board(rows, columns, empty_symbol)
#     @line_symbol = line_symbol 
#   end 
#   def initialize_board(rows, columns, empty_symbol)
    
#     board = []
    
#     rows.times do 
#       row = []
#       columns.times do 
        
#         row << empty_symbol
#       end 
      
#       board << row
      
      
#     end 
   
#     return board

#   end 
  
#   def get_board
#     return @board
#   end 
  
#   def set_board= (board)
#     @board = board
#   end 
  
#   def print_board
    
   
#     rows = (@board.length * 2) + 1
#     columns = (@board[0].length * 2) + 1
    
   
#     board_lines = []
    
#     rows.times do 
#       board_lines_row = []
#       columns.times do
#         board_lines_row << @line_symbol

#       end 
#       board_lines << board_lines_row
#     end

#     index_row = 0
#     row_board = 0
    
#     rows.times do 
      
#       index_column = 0
#       column_board = 0
#       columns.times do
        
#         if !(index_row % 2 == 0) && !(index_column % 2 == 0)
          
#           board_lines[index_row][index_column] = " #{@board[row_board][column_board]}"
#           !(index_column % 2 == 0) ? column_board += 1 : column_board = column_board
#         end 
        
#         index_column += 1
#       end 
      
#       !(index_row % 2 == 0) ? row_board += 1 : row_board = row_board
#       index_row += 1
#     end 
    
#     count = 1
#     index_row = 0
    
#     board_lines.length.times do 
#       index_column = 0
#       board_lines[0].length.times do 
#         if board_lines[index_row][index_column] == " #{@empty_symbol}"
#           # p count
#           place = count < 10 ? " #{count}" : count
#           board_lines[index_row][index_column] = " #{place}"
          
#         end 
        
#         if board_lines[index_row][index_column] != @line_symbol 
#           count += 1 
#         end 
#         index_column += 1
#       end 
#        index_row += 1
#     end 
    
#     board_lines.each do |row|
#       puts row.join("")
#     end
#   end 
# end

# Board.new(6,6,"  ",".").print_board