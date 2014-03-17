require "./exercises.rb"

describe "Exercises" do

  it "can return triples of a given string" do
    result=Exercises.ex0("ha")
    expect(result).to eq("hahaha")
  end

  it "returns 'nope' if the stirng is 'wishes'" do
    result=Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end

end
