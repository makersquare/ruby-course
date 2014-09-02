require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
  it 'Should create puppy with correct attributes.' do
    a = PuppyBreeder::Puppy
    b = a.new('pit')
    c = a.new('mix')

    expect(b.breed).to eq('pit')
    expect(b.id).to eq(1)
    expect(b.status).to eq('available')
    expect(c.breed).to eq('mix')  
    expect(c.id).to eq(2)  
  end
end


describe PuppyBreeder::DogShelter do
  it 'Should initialize an instance of a puppy.' do
    a = PuppyBreeder::DogShelter
    dog1 = PuppyBreeder::DogShelter.create_dog('lab')
    expect(a.doglist.count).to eq(1)
  end
  it 'Shelter should be able to check breed and cost.' do
    a = PuppyBreeder::DogShelter
    dog2 = PuppyBreeder::DogShelter.create_dog('pitbull')
    expect(a.available_by_breed('pitbull').count).to eq(1)
    dog3 = PuppyBreeder::DogShelter.create_dog('pitbull')
    expect(a.available_by_breed('pitbull').count).to eq(2)
    expect(a.cost?(1)).to eq(500)
    expect(a.cost?(2)).to eq(300)
  end

  it 'Should be able to fill do orders. =true' do
    a = PuppyBreeder::DogShelter
    dog4 = PuppyBreeder::DogShelter.create_dog('pitbull')
    dog5 = PuppyBreeder::DogShelter.create_dog('lab')
    r = PuppyBreeder::RequestRepository

    STDOUT.should_receive(:puts).with("Request 40 for mix has been filled. Dog 4, spot has been assigned.")
    allow(r).to receive(:breed_requested).and_return("mix")
    allow(r).to receive(:complete_request).and_return("Request 40 has been filled.")
    expect(a.fill_dog_order(40,4)).to eq('spot')
  end

  it 'Should be able to end orders. =false' do
    a = PuppyBreeder::DogShelter
    r = PuppyBreeder::RequestRepository

    STDOUT.should_receive(:puts).with("Request 41 for lab has been ended. Dog 5, spot has not been assigned.")
    allow(r).to receive(:breed_requested).and_return("lab")
    allow(r).to receive(:end_request).and_return("Request 41 has been denied. Please contact Animal Protective services.")
    expect(a.fill_dog_order(41,5,false)).to eq('spot')
  end

end