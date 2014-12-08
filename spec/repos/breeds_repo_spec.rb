require_relative '../spec_helper.rb'

describe PuppyBreeder::Repos::Breeds do
  let(:breeds){ PuppyBreeder.breeds_repo }

  before(:each){ 
    PuppyBreeder.drop_tables
    PuppyBreeder.create_tables
  }

  describe 'create and find_by' do
    it 'adds a new breed to the breeds list' do
      breed = breeds.create({name: 'terrier', price: 2000})
      expect(breed).to be_a(PuppyBreeder::Breed)
      expect(breed.name).to eq('terrier')
    end

    it 'retrieves an existing breed' do
      breeds.create({name: 'poodle', price: 2000})
      breed = breeds.find_by({name: 'poodle'}).first
      expect(breed).to be_a(PuppyBreeder::Breed)
      expect(breed.price).to eq(2000)
    end
  end

  describe 'update' do
    it 'changes the price of the breed' do
      breed = breeds.create({name: 'poodle'})
      expect(breed.price).to eq(0)
      result = breeds.update({name: 'poodle', price: 1500})
      expect(result).to be_a(PuppyBreeder::Breed)
      expect(result.price).to eq(1500)
    end
  end
end