require_relative 'spec_helper.rb'

describe 'PuppyBreeder' do
  it "adds a new breed" do
    PuppyBreeder.add_breed("lab", 300)
    (PuppyBreeder::Data.cost).should include("lab" => 300)
  end
end