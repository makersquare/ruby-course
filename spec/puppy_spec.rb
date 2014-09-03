require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
  describe 'puppy initialize' do 
  it "should initialize all the attributes for the pup" do
    sam = PuppyBreeder::Puppy.new("sam", "pitbull", 12)

    expect(sam.name).to eq("sam")
    expect(sam.age).to eq(12)
    expect(sam.breed).to eq("pitbull")
  end
end
describe 'container hash' do 
  it "should initialize with container and add pup" do
    sam = PuppyBreeder::Puppy.new("sam", "pitbull", 12)
    PuppyBreeder::Puppycontainer.add_breed("pitbull", 235)
    PuppyBreeder::Puppycontainer.add_pup_pound(sam)
    
    


    expect(PuppyBreeder::Puppycontainer.pound).to be_a(Hash)
    expect(PuppyBreeder::Puppycontainer.pound["pitbull"][:available].length).to eq(1)
    
  
end
end

end