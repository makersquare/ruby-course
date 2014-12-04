module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    str == "wishes" ? "nope" : str*3
  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
    array.size
  end

  # Exercise 2
  #  - Returns the second element of an array
  def self.ex2(array)
    array[1]
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    array.inject{|s,e| s+e}
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
     max = array[0]
     array.each do |x| 
      if x > max 
        max = x
      end
    end 
      max 
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  # def self.ex5(array)
  #   array.each do |x|
  #     puts x
  #   end
  # end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    x = array[-1] == 'panda' ? 'GODZILLA' : 'panda' 
    array[0..-2] << x
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    if array.include? str 
     array << str
    end 
    array
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  # def self.ex8(people)
  #   people.each do |name, occupation| 
  #   puts name
  #   puts occupation
  #   end 
  # end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  #A year will be a leap year 
  #if it is divisible by 4 but not by 100. If a year is divisible by 4 and by 100, it is not a leap year unless it is also divisible by 400.


  # def self.ex9(time)
  #   time % 4 == 0  && time % 100 !=0
  # end

  # Exercise 10
  #  - Returns "happy hour" if it is between 4 and 6pm
  #    Otherwise, returns "normal prices"
  # Hint: Read the "Stubbing" documentation on the Learn app.
  def self.ex10
    t = Time.now.hour
    if t >=16 && t <=18
      "happy hour"
    else 
      "normal prices"
    end
  end
  
  # Exercise 11
  #  - Returns the sum of two numbers if they are both integers
  #  - Raises an error if both numbers are not integers
  def self.ex11(n,m)
    if Integer === n && Integer === m
      n + m 
    else raise "Enter Integers! "
    end 
  end
  
  # Exercise 12
  #  - Write a method that takes two characters and returns an
  #    ordered array with all characters need to fill the range
  #    Eg.
  #       Exercises.ex12('c', 'g') => ['c', 'd', 'e', 'f', 'g']
  def self.ex12
    # TODO
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
