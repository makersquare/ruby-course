#command line interface not part of the module--client/server relationship
require_relative 'lib/puppy_breeder.rb'
require_relative 'lib/puppy_breeder/breedfixer.rb'
require_relative 'lib/puppy_breeder/puppy.rb'
require_relative 'lib/puppy_breeder/puppy_container.rb'
require_relative 'lib/puppy_breeder/purchase_request.rb'
require_relative 'lib/puppy_breeder/purchase_request_container.rb'

class TerminalClient

  def self.help_menu
    puts "Help Menu"
    puts "-- add_breed adds a breed with breed, price (optional) (breed, price)"
    puts "-- add_puppy: adds puppy (breed, name, age)"
    puts "-- check_price: for breed (breed)"
    puts "-- market_correction: allows puppy price to be updated (breed, price)"
    puts "-- view: shows all puppies of a certain breed (breed)"
    puts "-- purchase: enters purchase request (breed)"
    puts "-- check_pending: shows all purchase requests pending"
    puts "-- check_completed: shows all purchase requests completed"
    puts "-- next_hold: checks for next hold for particular breed (breed)"
    puts "-- next_pending: checks for next pending for particular breed (breed)"
    puts "-- check_request: check request against inventory (breed)"
    puts "-- check_puppy: check inventory against filed requests (breed,name,age)"
  end

  def self.start
    print "command> "
    input = gets.chomp
    command = input.split.first

    case command
    when "Help"
      help_menu
    when "add_breed"
      create_new_breed(input)
    when "add_puppy"
      add_puppy_to_inventory(input)
    when "check_price"
      get_breed_price(input)
    when "market_correction"
      market_correction(input)
    when "view"
      view_puppies(input)
    when "purchase"
      purchase_request(input)
    when "check_pending"
      check_pending
    when "check_completed"
      check_completed
    when "next_hold"
      next_hold(input)
    when "next_pending"
      next_pending(input)
    when "check_request: check request against inventory (request)"
      check_request(request)
    when "check_puppy: check inventory against filed requests (puppy)"
      check_puppy(puppy)
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

  def self.add_puppy_to_inventory(input)
    input = input.split
    name = input[1]
    breed = input[2]
    age = input[3].to_i
    x = PuppyBreeder::Puppy.new(breed,name,age)
    PuppyBreeder::PuppyContainer.add_puppy(x)
  end

  def self.get_breed_price(input)
    price = PuppyBreeder::PuppyContainer.check_price(input.split[1])
    puts "The breed #{input.split[1]} costs #{price}!"
  end

  def self.market_correction(input)
    breed = input.split[1]
    price = input.split[2]
    PuppyBreeder::PuppyContainer.market_correction(breed,price)
  end

  def self.view_puppies(input)
    breed = input.split[1]
    puppies = PuppyBreeder::PuppyContainer.puppy_info(breed)
    puppies.each do |pup|
      "#{pup.name} is #{pup.age} days old!"
    end
  end

  def self.purchase_request(input)
    breed = input.split[1]
    PuppyBreeder::PurchaseRequest.new(breed)
  end

  def self.check_pending
    pending = PuppyBreeder::PurchaseRequestContainer.show_pending
    pending.each do |pend|
      put pend
    end
  end

  def self.check_completed
    pending = PuppyBreeder::PurchaseRequestContainer.show_completed
    completed.each do |order|
      put order
    end
  end

  def self.next_hold(input)
    breed = input.split[1]
    PuppyBreeder::PurchaseRequestContainer.next_hold(breed)
  end

  def self.next_pending(input)
    breed = input.split[1]
    PuppyBreeder::PurchaseRequestContainer.next_pending(breed)
  end

  def self.check_request(input)
    breed = input.split[1]
    PuppyBreeder::PuppyDelivery.match_request_to_puppy(PuppyBreeder::PurchaseRequest.new(breed))
  end

  def self.check_puppy(input)
    input = input.split
    name = input[1]
    breed = input[2]
    age = input[3].to_i
    x = PuppyBreeder::Puppy.new(breed,name,age)
    PuppyBreeder::PuppyDelivery.match_puppy_to_request(x)
  end
end