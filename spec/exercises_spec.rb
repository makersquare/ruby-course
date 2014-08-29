require "./exercises.rb"
require 'pry-byebug'

# describe 'Book' do
#   it "has a title and author, and nil id" do
#     book = Book.new("The Stranger", "Albert Camus")

#     #binding.pry

#     expect(book.title).to eq("The Stranger")
#     expect(book.author).to eq("Albert Camus")
#     expect(book.id).to be_nil
#   end
# end

describe 'Exercises' do
  it "3x original string 'abc' => 'abcabcabc', unless str='wishes', then => 'nope'" do
    expect(Exercises.ex0('abc')).to eq 'abcabcabc'
    expect(Exercises.ex0('wishes')).to eq 'nope'
  end
end

  it "Returns the number of elements in the array" do
    expect(Exercises.ex1([1,2,3,4,5,6,7,8,9]).to eq(9)
    expect(Exercises.ex1([]).to eq(0)
  end