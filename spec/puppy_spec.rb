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
    b = PuppyBreeder::DogShelter.add_dog('mix')
    expect(a.doglist.count).to eq(1)
  end
  it 'Shelter should be able to check breed and cost.' do
    a = PuppyBreeder::DogShelter
    b = PuppyBreeder::DogShelter.add_dog('pitbull')
    expect(a.available_by_breed('pitbull').count).to eq(1)
    c = PuppyBreeder::DogShelter.add_dog('pitbull')
    expect(a.available_by_breed('pitbull').count).to eq(2)
    expect(a.cost?(1)).to eq(200)
    expect(a.cost?(2)).to eq(300)

  end
end