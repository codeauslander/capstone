module Board 
  def print_board(parameters)
    array = parameters[:array]
    dimensions = multiples(array.length)
    dimensions[0].times do |row|
      array_row = []
      dimensions[1].times do |column|
        array_row << array.pop
      end
      p array_row
    end
  end
  def multiples(number)
    # number += 1 if number % 2 != 0
    return nil if number % 2 != 0
    return [1,2] if number == 2
    list = (2..(number / 2)).to_a.delete_if { |n| n unless number % n == 0}
    middle_index = list.length/2
    [list[middle_index - 1],list[middle_index]]
  end
end

include Board
Board.print_board({array:["a","b","c","d","e","f","g","h","i","j","k","l"]})



