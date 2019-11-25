class Converter
  def initialize(path)
    @path = path
    @array = []
    @max_length_width1 = 0
    @max_length_width2 = 0
    @max_length_width3 = 0
  end

  def print_table
    read_CSV
    split
    look_for_max_lenght
    output
  end
  
  private

  def read_CSV 
    file = open @path
    file.each do |line|
      @array.push line
    end
  end

  def split
    @array.each_with_index { |value, index| @array[index] = value.split(";") }
    @array.each_with_index { |value, index| @array[index][1] = value[1].split(" ") }
  end  

  def look_for_max_lenght
    @array.each do |value| 
      if value[0].length > @max_length_width1
        @max_length_width1 = value[0].length
      end
    end
    @array.each do |value| 
      value[1].each do |str|
        if str.length > @max_length_width2
          @max_length_width2 = str.length
        end
      end
      @array.each do |value| 
        if value[2].length > @max_length_width3
          @max_length_width3 = value[2].length
        end
      end
    end
  end

  def output
    puts "+" + "-" * (@max_length_width1 + @max_length_width2 + @max_length_width3 + 2) + "+"
  
    @array.each_with_index do |value, index|
      next if index == 0
      space_left(value[0], @max_length_width1)
      space_right(value[1][0], @max_length_width2)
      space_left(value[2], @max_length_width3, true)
      value[1].each_with_index do |str,index|
        space_left("", @max_length_width1)
        space_right(str, @max_length_width2)
        space_left("", @max_length_width3, true)
      end
      separator
    end
  end
  
  def space_right(str, int)
    print "|" + str + " " * (int - str.length)
  end

  def space_left(str, int, nextLine = false)
    str.delete!("\n");
    print "|" + " " * (int - str.length) + str
    puts "|" if nextLine
  end

  def separator
    puts "+" + "-" * @max_length_width1 + "+" + "-" * @max_length_width2 + "+" + "-" * @max_length_width3 + "+"
  end 
end