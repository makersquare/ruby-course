require_relative "../spec_helper.rb"

describe Songify::Genre do 
  let(:mumblecore) {Songify::Genre.new("mumblecore")}

  it "will initialize with genre name and an ID of nil" do


    expect(mumblecore.name).to eq("mumblecore")
    expect(mumblecore.id).to be_nil
  end
  
end