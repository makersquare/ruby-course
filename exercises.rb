
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    if(str == "wishes")
      return "nope"
    else
      return str+str+str
    end
  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
    return array.count
  end

  # Exercise 2
  #  - Returns the second element of an array
  def self.ex2(array)
    return array[1]
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    array.inject{|sum,x| sum + x }
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    max = 0
    array.each do |x|
      if x>max
        max = x
      end
    end
    return max
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    array.each do |x|
      puts x
    end
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    if(array.last == 'panda')
      array[array.length-1]= 'GODZILLA'
    else
      array[array.length-1] = 'panda'
    end
    return array
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    if array.include? str
      array.push(str)
    end
    return array
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    people.each do |x|
      puts "#{x[:name]} is a #{x[:occupation]}"
    end
  end

 # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    y = time.year
    if y%4 == 0
     if (y%100 == 0) && !(y%400 == 0)
      return false
     end
     return true
    else 
      return false
    end               
  end

  # Exercise 10
  #  - Returns "happy hour" if it is between 4 and 6pm
  #    Otherwise, returns "normal prices"
  # Hint: Read the "Stubbing" documentation on the Learn app.
  def self.ex10(time)
    h = time.hour
    if(h > 16 && h < 18)
      return "happy hour"
    else
      return "normal prices"
    end
  end
  
  # Exercise 11
  #  - Returns the sum of two numbers if they are both integers
  #  - Raises an error if both numbers are not integers
  def self.ex11
    # TODO
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
    counts = {}

    array.each do |str|
      counts[str] || counts[str] = 0
      counts[str] += 1
    end
    
    result = {}
    most = []
    least = []
    strings = counts.keys
    strings.sort {|a,b| counts[a] <=> counts[b]}
    strings.each do |str|
      if most.length == 0 || counts[str] == counts[most.first]
        most.push(str)
      end
      if least.length != 0 && counts[least.first] > counts[str]
        least = []
      end
      if least.length == 0 || counts[str] == counts[least.first]
        least.push(str)
      end
    end

    if least.length == 1
      least = least.first
    end
    if most.length == 1
      most = most.first
    end
    result[:most] = most
    result[:least] = least
    return result
  end
end
