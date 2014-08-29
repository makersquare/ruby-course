
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    str == 'wishes' ? 'nope' : str * 3
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
    array.inject(:+)
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    max = 0
    array.each do |x|
      if x > max
        max = x
      end
    end
    max
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
    last = array[-1]
    last == 'panda' ? array[-1] = 'GODZILLA' : array[-1] = 'panda'
    array
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    array.include?(str) ? array.push(str) : nil
    array
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    people.each do |x|
      puts "#{x[:name]} #{x[:occupation]}"
    end
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    year = time.year
    if (year%4 == 0)
      if (year%100 == 0 && year%400 == 0)
        return true
      end
      return true
    end
    false
  end

  # Exercise 10
  #  - Returns "happy hour" if it is between 4 and 6pm
  #    Otherwise, returns "normal prices"
  # Hint: Read the "Stubbing" documentation on the Learn app.
  def self.ex10(time)

    four = Time.new(2014, 8, 29, 13, 0, 0).hour
    six= Time.new(2014, 8, 29, 15, 0, 0).hour
    cur_hour = time.hour
    (cur_hour >= four && cur_hour < six) ? "happy hour" : "normal prices"

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
