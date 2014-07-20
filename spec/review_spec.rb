require 'spec_helper.rb'

# Note: In these tests we've aliased `you` to the method `it`. This
# is to make the tests easier to read :)

describe "Ruby Review: You" do

  describe "Your knowledge of getters and setters" do

    you "know how to write a setter method" do
      doctor = GettersSetters::Doctor.new
      doctor.skill = "patient management"
      expect(doctor.skill).to eq "patient management"

      expect(@source).to_not include_code(:attr_writer).in(:Doctor).for(:GettersSetters)
    end
  end


  describe "Your knowledge of Hashes" do

    you "know how to change a value in a hash" do
      wardrobe = {
          "top compartment" => {
            :item => "neck tie"
          },
          "lower compartment" => "pants"
      }

      HashProblems.update_top_compartment_item(wardrobe)
      compartment = wardrobe["top compartment"]
      expect(compartment[:item]).to eq "fake beard"

      expect(@source).to include_class_method(:HashProblems, :update_top_compartment_item).with_line_count(1)
    end
  end


  describe "Your knowledge of Arrays" do

    you "know how to add a hash to an array" do
      pets = [{ :dog => 'Lucky'}, { :parrot => 'Polly'}]
      ArrayProblems.add_cat_to_array(pets)
      expect(pets).to eq [{ :dog => 'Lucky'}, { :parrot => 'Polly'}, { :cat => 'Pogo'}]

      pets = [{ :chipmunk => 'Joel'}, { :snake => 'Monty'}]

      ArrayProblems.add_cat_to_array(pets)
      expect(pets).to eq [{ :chipmunk => 'Joel'}, { :snake => 'Monty'}, { :cat => 'Pogo'}]
    end

    you "know how to use the map method part 1" do
      wardrobe_items = [
        { :name => "coat", :size => "medium" },
        { :name => "hat", :size =>  "large" }
      ]

      result = ArrayProblems.list_wardrobe_item_sizes(wardrobe_items)
      expect(result).to eq(["medium", "large"])

      expect(@source).to include_code(:map).in_class_method(:ArrayProblems, :list_wardrobe_item_sizes)
    end

    you "know how to use the map method part 2" do
      weather = [
        "drizzly",
        "cold"
      ]

      result = ArrayProblems.tell_me_the_weather(weather)
      expect(result).to eq(["It is drizzly", "It is cold"])

      expect(@source).to include_code(:map).in_class_method(:ArrayProblems, :tell_me_the_weather)
    end

    you "know how to use the map method part 3" do
      hat_collection = [
        { :size => "medium", :style => "cap"},
        { :size => "small", :style => "fedora"} ]

      result = ArrayProblems.list_my_hats(hat_collection)
      expect(result).to eq(["medium cap", "small fedora"])

      expect(@source).to include_code(:map).in_class_method(:ArrayProblems, :list_my_hats)
    end
  end


  describe "Your knowledge of implicit returns" do

    you "know how to explicitly return a statement" do
      numbers_array = [4,5,2]
      result = MethodReturns.include?(numbers_array, 2)
      expect(result).to eq(true)

      result = MethodReturns.include?(numbers_array, 4)
      expect(result).to eq(true)

      result = MethodReturns.include?(numbers_array, 7)
      expect(result).to eq(false)
    end

    you "know what puts returns" do
      result = MethodReturns.get_name
      expect(result).to eq "Bob"
    end

  end


  describe "Your knowledge of scope in Ruby" do

    you "know about method scope" do
      bob = Scopes::Person.new
      expect(bob.jump(10)).to eq "I can jump 10 inches!"
      expect(bob.last_jump_height).to eq "I last jumped 10 inches."

      expect(bob.jump(2)).to eq "I can jump 2 inches!"
      expect(bob.last_jump_height).to eq "I last jumped 2 inches."
    end

    you "know about block scope" do
      data = [
        { :name => "Joe", :salary => 100 },
        { :name => "Sally", :salary => 1000 }
      ]
      finder = Scopes::Finder.new(data)

      person = finder.find_first(1000)
      expect(person[:name]).to eq "Sally"

      person = finder.find_first(100)
      expect(person[:name]).to eq "Joe"

      person = finder.find_first(999)
      expect(person).to eq nil

      expect(@source).to_not include_code(:return).in(:Finder).for(:Scopes)
    end
  end


  # You can safely ignore this block
  before(:all) do
    @source = RubyParser.new.parse(File.read('review.rb'), './review.rb')
  end

end
