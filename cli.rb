#Creating a Terminal Client / Command Line Interface

#TCs present information to you

require_relative 'lib/puppy_breeder.rb'

class TerminalClient
    def self.help_menu
      puts "Help Menu"
      puts "add - name, breed, age"
      puts "view: this shows all puppies"
    end

    def self.start
      print "command>  "
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
        puts "i don't know that command."
      end

      start
    end

    def self.create_new_breed(input)
      breed = input.split[1]
      price = input.split[2]
      PuppyBreeder.add_breed(breed, price)
    end

    def self.add_puppy_to_inventory(input)
      input = input.split
      name = input[1]
      breed = input[2]
      age = input[3].to_i
      x = PuppyBreeder::Puppy.new(name, breed, age)
    end
end