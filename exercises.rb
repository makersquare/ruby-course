
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    return "nope" if str == "wishes"
    str + str + str
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
    array.inject { |x, y| x + y }
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    array.max
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    array.each { |x| puts x }
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    if array.last == "panda"
      array.pop
      array.push("GODZILLA")
    else
      array.pop
      array.push("panda")
    end
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    if array.include?(str)
      array.push(str)
    end
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    people.each { |person| print "#{person[:name]} the #{person[:occupation]}" }
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    year = time.year
    return false if year % 4 != 0
    return true if year % 100 != 0
    return false if year % 400 != 0
    return true
  end

  # Exercise 10
  #  - Returns "happy hour" if it is between 4 and 6pm
  #    Otherwise, returns "normal prices"
  # Hint: Read the "Stubbing" documentation on the Learn app.
  def self.ex10
    time = Time.now
    if time.hour >= 16 && time.hour <= 18
      return "happy hour"
    else
      return "normal prices"
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
    hash = Hash.new(0)
    array.each { |str| hash[str] +=1 }
    max = hash.values.max
    min = hash.values.min
    most = hash.select { |k, v| v == max }.keys
    least = hash.select { |k, v| v == min }.keys
    if most.size == 1
      most = most.first
    end

    if least.size == 1
      least = least.first
    end

    return {
      most: most,
      least: least
    }
  end
end
