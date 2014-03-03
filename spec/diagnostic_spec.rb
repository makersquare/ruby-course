require 'spec_helper.rb'

# Note: In these tests we've aliased `you` to the method `it`. This
# is to make the tests easier to read :)

describe "Ruby Diagnostic: You" do

  you "can deduce how to write a method based on a spec" do
    expect( toggle_oven(true) ).to eq "The oven is now on"
    expect( toggle_oven(false) ).to eq "The oven is now off"
  end

  you "know how to call a method within another method" do
    result = give_me_seven
    expect(result).to eq 7
    expect(@source).to include_code(:multiply).in_method(:give_me_seven)
  end


  describe "Your knowledge of Classes and Instances" do

    you "know how to set an instance variable" do
      animal = ClassesAndInstances::Animal.new('bird')
      expect(animal.name).to eq 'bird'
    end

    you "know how to write an instance method" do
      lion = ClassesAndInstances::Animal.new('lion')
      tiger = ClassesAndInstances::Animal.new('tiger')
      liger = ClassesAndInstances::Animal.new('liger')

      zoo = ClassesAndInstances::Zoo.new
      expect(zoo.animals.count).to eq 0

      zoo.adopt(lion)
      zoo.adopt(tiger)
      expect(zoo.animals.count).to eq 2
      expect(zoo.animals.first.name).to eq 'lion'

      zoo.adopt(liger)
      expect(zoo.animals.count).to eq 3
    end

    you "know the difference between local variables and instance variables" do
      plant = ClassesAndInstances::Plant.new(1)

      plant.grow
      expect(plant.size).to eq 2

      plant.grow
      plant.grow
      expect(plant.size).to eq 4
    end
  end

  describe "Your knowledge of getters and setters" do

    you "know how to write a getter method" do
      box = GettersSetters::Box.new
      expect(box.secret).to eq 50

      expect(@source).to_not include_code(:attr_reader).in(:Box).for(:GettersSetters)
      expect(@source).to_not include_code(:attr_accessor).in(:Box).for(:GettersSetters)
    end

    you "know how to write a setter method" do
      box = GettersSetters::Box.new
      box.secret = 99
      expect(box.secret).to eq 99

      expect(@source).to_not include_code(:attr_writer).in(:Box).for(:GettersSetters)
      expect(@source).to_not include_code(:attr_accessor).in(:Box).for(:GettersSetters)
    end

    xyou "can properly refactor getters/setters to their attr_ shortcut equivalents" do
      bob = GettersSetters::Person.new('Bob', 38)
      expect(bob.name).to eq 'Bob'
      expect(bob.age).to eq 38
      expect { bob.secret = 200 }.to_not raise_error

      expect(@source).to_not include_method(:age).in(:Person).for(:GettersSetters)
      expect(@source).to_not include_method_call(:attr_accessor, :age).in(:Person).for(:GettersSetters)
      expect(@source).to_not include_method_call(:attr_accessor, :secret).in(:Person).for(:GettersSetters)
      expect(@source).to_not include_method_call(:attr_reader, :name).in(:Person).for(:GettersSetters)
    end
  end

  describe "Your knowledge of Arrays" do

    you "know how to add an element to an array" do
      desserts = ['apple', 'ice cream']
      ArrayProblems.add_cake_to_array(desserts)
      expect(desserts).to eq ['apple', 'ice cream', 'cake']

      desserts = ['orange', 'froyo']
      ArrayProblems.add_cake_to_array(desserts)
      expect(desserts).to eq ['orange', 'froyo', 'cake']
    end

    you "know how to manipulate an element in an array" do
      fruits = ['radish', 'rutabaga', 'orange', 'apple']
      ArrayProblems.uppercase_third_element(fruits)
      expect(fruits).to eq ['radish', 'rutabaga', 'ORANGE', 'apple']

      fruits = ['pear', 'banana', 'grape']
      ArrayProblems.uppercase_third_element(fruits)
      expect(fruits).to eq ['pear', 'banana', 'GRAPE']
    end

    you "know how to iterate over an array" do
      # Take 1
      expect(ArrayProblems).to receive(:puts).with('top')
      expect(ArrayProblems).to receive(:puts).with('bowler')
      expect(ArrayProblems).to receive(:puts).with('baseball')

      hats = ['top', 'bowler', 'baseball']
      ArrayProblems.iterate_and_print(hats)

      # Take 2
      expect(ArrayProblems).to receive(:puts).with('beret')
      expect(ArrayProblems).to receive(:puts).with('cowboy')

      hats = ['beret', 'cowboy']
      ArrayProblems.iterate_and_print(hats)

      expect(@source).to include_code(:each).in_class_method(:ArrayProblems, :iterate_and_print)
    end

    you "know how to use the select method" do
      numbers = [33, 11, 5, 55, 67, 8, 95, 0, 110]

      result = ArrayProblems.select_higher(numbers, 55)
      expect(result).to include(67, 95, 110)
    end

    you "know how to use the map method" do
      people = ['Alice', 'Bob']

      result = ArrayProblems.greet_everyone(people)
      expect(result).to include("Hello, Alice", "Hello, Bob")

      expect(@source).to include_code(:map).in_class_method(:ArrayProblems, :greet_everyone)
    end
  end


  describe "Your knowledge of Hashes" do

    you "know how to create an empty hash" do
      result = HashProblems.create_empty_hash
      expect(result.length).to eq 0
    end

    you "know how to create a hash with keys and values" do
      result = HashProblems.create_veggie_color_hash
      expect(result[:tomato]).to eq 'red'
      expect(result[:kale]).to eq 'green'
    end

    you "know how to access a nested hash" do
      james = {
          "name" => {
              :first => "King",
              :last => "James XXXI"
          },
          "father" => {
              "name" => {
                  :first => "King",
                  :last => nil
              }
          }
      }

      HashProblems.update_father_last_name(james)
      father = james["father"]
      name = father["name"]
      expect(name[:last]).to eq "James XXX"

      expect(@source).to include_class_method(:HashProblems, :update_father_last_name).with_line_count(1)
    end
  end

  describe "Your handle on using Hashes with Arrays" do

    you "know how to iterate through an array of hashes and output its contents" do
      expect(ArraysAndHashes).to receive(:puts).with("oranges: 5")
      expect(ArraysAndHashes).to receive(:puts).with("eggplants: 8")
      expect(ArraysAndHashes).to receive(:puts).with("apples: 14")

      grocery_list = [{ oranges: 5 }, { eggplants: 8, apples: 14 }]
      ArraysAndHashes.iterate_and_print(grocery_list)

      expect(@source).to include_code(:each).in_class_method(:ArraysAndHashes, :iterate_and_print)
    end
  end

  # You can safely ignore this block
  before(:all) do
    @source = RubyParser.new.parse(File.read('diagnostic.rb'), './diagnostic.rb')
  end

end
