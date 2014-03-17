require 'spec_helper'

describe "Puzzle Exercises" do

  describe "Puzzle #1" do

    def get_wash_color(fruit)
      fruit
    end

    it "returns a color for 'washington'" do
      apples = { 'washington' => 'red' }
      # TODO: Uncomment and complete
      result = get_wash_color(apples['washington'])
      expect(result).to eq 'red'

      apples = { 'washington' => 'not orange' }
      # TODO: Uncomment and complete
      result = get_wash_color(apples['washington'])
      expect(result).to eq 'not orange'
    end

  end

  describe "Puzzle #2" do

    # TODO: Uncomment and complete this method
    def get_fruit_color(fruit_hash, fruit)
      fruit_hash[fruit]
    end

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

  describe "Puzzle #3", :pending => false do
    class ArtMuseum
      def initialize
        @collection  = ['The Last Supper', 'Mona Lisa']
      end
      def collection
        @collection
      end
    end

    it "counts correctly" do
      # TODO:
      @museum = ArtMuseum.new
      result = @museum.collection.length
      expect(result).to eq(2)
    end
  end

  describe "Puzzle #4", :pending => false do
    def greet(x)
      if x
        'Hello'
      end.concat(' there, ' + x)
    end

    it "greets correctly" do
      # TODO: Uncomment and complete
      result = greet('World')
      expect(result).to eq 'Hello there, World'
    end
  end

  describe "Puzzle #5", :pending => false do
    def collection
      array = ['cap', 'box']
      array.each do |item|
        puts item
      end.push('footrest', 'sea otter')
    end

    it "outputs 'sea otter'" do
      # TODO: Uncomment and complete
      result = collection.last
      expect(result).to eq 'sea otter'
    end
  end

  describe "Puzzle #6", :pending => false do
    def puzzle_5(x)
      if x  # TODO: Change this ONE LINE
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

  describe "Puzzle #7", :pending => false do
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
      message = "Nope, these inputs don't evaluate to true"
      expect( check(2,3) ).to eq(message)
      # TODO: Uncomment and complete
      result = check(2, 2)
      expect(result).to eq "Yep, these inputs evalute to true"
    end
  end

end
