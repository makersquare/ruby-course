README.md

Four Classes built: 

1) Puppy
	- Puppy Class initializes with breed, name, age, status, and id, and has a requested method and sold method to update status.

2) PuppyContainer
	- Puppy Container initializes with a puppies hash and has methods of add breed, add puppy, remove puppy, and breed availability. 

3) PurchaseRequest
	- Purchase Request Class initializes with breed, status, and id and has approve request and deny request methods to update the status. 
	
4) PurchaseRequestContainer.  
	- The PurchaseRequestContainer Class initializes with a requests array and has methods of add request, completed requests, pending requests, approved requests, denied requests, and requests of a breed. All tests pass for every method in every class.

** - As a customer, I want to be able to make a purchase request for a puppy.

** - As a breeder, I want to be able to manually input a purchase request (e.g. if a customer sent in their order via fax, letter or had a verbal agreement).

** - As a breeder, I want to be able to add new puppies for sale.

** - As a breeder, I want to be able to review and accept new purchase requests before they go through.

** - As a breeder, I want to be able to view all completed purchase orders.

What it should be able to do:
** - Customer submits purchase request. 
** - Breeder must acknowledge and accept request.
** - Breeder submits purchase request.
** - Breeder can review purchase orders.
** - Breeder adds puppies for sale.


****************************
Making a terminal client.

Make a class. It doesn't need to exist within the module.

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
		when "show"
			show_pups_by_breed(input)
		when "exit"
			puts "OKTHXBYE"
			return
		else
			puts "I don't know that commange"
		end

		start

	end

	def self.add_breed_to_inventory(input)
		breed = input.split[1]
		PuppyBreeder::PuppyContainer.add_breed(breed)
	end

	def self.get_breed_price(input)
		price = PuppyBreeder::PuppyContainer.get_breed_price(input.split[1])
		puts "The breed #{input.split[1]} costs #{cost}."
	end

	def self.add_puppy_to_inventory(input)
		input = input.split
		name = input[1]
		breed = input[2]
		age = input[3].to_i

		x = PuppyBreeder::Puppy.new(name, breed, age)
		PuppyBreeder::PuppyContainer.add_puppy(x)
	end

	def self.show_pups_by_breed
		puppies = PuppyBreeder::PuppyContainer.puppy_info
	end
end

Run by irb

load TerminalClient file.

