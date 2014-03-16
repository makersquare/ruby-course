require 'spec_helper'

describe "Puzzle Exercises" do

  describe "Puzzle #1" do

    def get_wash_color(fruit)
      fruit
    end

    it "returns a color for 'washington'" do
      apples = { 'washington' => 'red' }
      # TODO: Uncomment and complete
      # result = get_wash_color(???)???
      expect(result).to eq 'red'

      apples = { 'washington' => 'not orange' }
      # TODO: Uncomment and complete
      # result = get_wash_color(apples)???
      expect(result).to eq 'not orange'
    end

  end

  describe "Puzzle #2" do

    # TODO: Uncomment and complete this method
    # def get_fruit_color(???)
    #   ???
    # end

    it "returns the correct color for a specified fruit" do
      apples = {
        'granny smith' => 'green',
        'washington' => 'red',
        'pink lady' => 'pink'
      }

      result = get_fruit_color(apples, 'granny smith')
      expect(result).to eq 'green'
    end

  end

  describe "Puzzle #3", :pending => true do
    class ArtMuseum
      def initialize
        @collection  = ['The Last Supper', 'Mona Lisa']
      end
      def collection
        @collection
      end
    end

    @museum = ArtMuseum.new

    it "counts correctly" do
      # TODO:
      # result = @museum.???
      expect(result).to eq(2)
    end
  end

  describe "Puzzle #4", :pending => true do
    def greet(x)
      if x
        'Hello'
      end.concat(' there, ')
    end

    it "greets correctly" do
      # TODO: Uncomment and complete
      # result = greet(???)???
      expect(result).to eq 'Hello there, World'
    end
  end

  describe "Puzzle #5", :pending => true do
    def collection
      array = ['cap', 'box']
      array.each do |item|
        puts item
      end.push('footrest', 'sea otter')
    end

    it "outputs 'sea otter'" do
      # TODO: Uncomment and complete
      # result = collection.???
      expect(result).to eq 'sea otter'
    end
  end

  describe "Puzzle #6", :pending => true do
    def puzzle_5(x)
      if x == true # TODO: Change this ONE LINE
        "It's true!"
      end
    end

    it "uses truthy/falsey values correctly" do
      expect( puzzle_5(nil) ).to be_nil
      expect( puzzle_5(false) ).to be_nil
      expect( puzzle_5('truthy') ).to eq "It's true!"
      expect( puzzle_5(rand 198344) ).to eq "It's true!"
    end
  end

  describe "Puzzle #7", :pending => true do
    def compare(x, y)
      x == y
    end

    def check(a, b)
      if compare(a, b)
        "Yep, these inputs evalute to true"
      else
        "Nope, these inputs don't evaluate to true"
      end
    end

    it "compares" do
      # TODO: Uncomment and complete
      # message = ???
      expect( check(2,3) ).to eq(message)
      # TODO: Uncomment and complete
      # result = compare(???)
      expect(result).to eq "Yep, these inputs evalute to true"
    end
  end

  describe "Puzzle #8", :pending => true do
    def match_item(array, item)
      array.each do |elem|
        if elem == item
          return elem
        # TODO: Change the code below this section
        # some code needs to be removed here
        else
          return nil
        end
      end
      # Some code needs to be added here
    end

    item_ary = ["pigeon", "fox", "turtle"]

    expect(match_item(item_ary, "fox")).to eq("fox")
    expect(match_item(item_ary, "cat")).to be_nil

  end

  describe "Puzzle #9", :pending => true do

    class Book
      def initialize(
        title)
        @title = title
      end
    end

    class Library
      attr_reader :books
      def initialize
        x = Book.new("Eating Healthy")
        y = Book.new("Beautiful People")
        z = Book.new("Unintented Secrets")
        @books = [x, y, z]
      end
    end

    # TODO: fix this line of code
    # DO NOT write `book_count = 3`
    book_count = Library.new.count

    expect(book_count).to eq(3)
  end

end
