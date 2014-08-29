
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    return "nope" if str == "wishes"
    str * 3
  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
    array.length
  end

  # Exercise 2
  #  - Returns the second element of an array
  def self.ex2(array)
    array[1]
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    return array.inject(:+)
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    max = array[0]
    array.each {|ele| max = ele if max < ele }
    max
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    array.each {|ele| puts ele}
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    if array.empty?
      array[0] = 'panda'
    elsif array.last == 'panda'
      array[-1] = 'GODZILLA'
    else
      array[-1] = 'panda'
    end
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    if array.find {|ele| ele == str }
      array << str
    end
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    people.each {|hash| puts "#{hash[:name]} is a #{hash[:occupation]}" } 
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    time % 4 == 0 && !(time % 100 == 0 || time % 400 == 0)
  end

  # Exercise 10
  #  - Returns "happy hour" if it is between 4 and 6pm
  #    Otherwise, returns "normal prices"
  # Hint: Read the "Stubbing" documentation on the Learn app.
  def self.ex10(time)
    time_test = time.to_s.split[1].split(":")[0].to_i 
    if time_test >= 16 && time_test <= 18
      puts "happy hour"
    else
      puts "normal prices"
    end
  end
end

module Extensions
  # Extension Exercise
  #  - Takes an `array` of strings. Returns a hash with two keys:
  #    :most => the string(s) that occures the most # of times as its value.
  #    :least => the string(s) that occures the least # of times as its value.
  #  - If any tie for most or least, return an array of the tying strings.
  #
  # Example:
  #   result = Extensions.extremes(['x', 'x', 'y', 'z'])
  #   expect(result).to eq({ :most => 'x', :least => ['y', 'z'] })
  #
  def self.extremes(array)
    # TODO
  end
end