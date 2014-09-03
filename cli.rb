#command line interface not part of the module--client/server relationship
require_relative 'lib/puppy_breeder.rb'

class TerminalClient

  def help_menu
    puts "Help Menu"
    puts "add: name, breed, age"
    puts "view: this shows all puppies"
  end

  def self.start
    print "command> "
    input = gets.chomp
    command = input.split.first

    case command
    when "breed"
      create_new_breed(input)
    when "add"
      add_puppy_to_inventory(input)
    when "exit"
      puts "OKTHXBYE"
      return
    else
      puts "I don't know that command"
    end

    start 
  end

  def self.create_new_breed(input)
    breed = input.split[1]
    price = input.split[2]
    PuppyBreeder::PuppyContainer.add_breed(breed, price)
  end

  def self.get_breed_price(input)
    price - PuppyBreeder::PuppyContainer.get_breed_price(input.split[1])
    puts "The breed #{input.split[1]} costs #{price}!"
  end

  def self.add_puppy_to_inventory(input)
    input = input.split
    name = input[1]
    breed = input[2]
    age = input[3].to_i
    x = PuppyBreeder::Puppy.new(name,breed,age)
    PuppyBreeder::PuppyContainer.add_puppy(x)
  end

  def self.show_pups_by_breed(input)
    breed = input.split[1]
    puppies = PuppyBreeder::PuppyContainer.puppy_info
    puppies[breed].each do |pup|
      "#{pup.name} is #{pup.age} days old!"
    end
  end
end