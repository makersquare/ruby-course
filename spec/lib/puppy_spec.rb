require_relative '../spec_helper.rb'

describe PuppyBreeder::Puppy do
  let(:terrier){ PuppyBreeder::Breed.new({
      name: 'terrier',
      price: 2000
    })
  }
  let(:pup){ PuppyBreeder::Puppy.new({
      name:'Lucky',
      breed: terrier
    })
  }

  describe 'initialize' do
    it 'should create an instance of the class Puppy' do
      expect(pup).to be_a(PuppyBreeder::Puppy)
      expect(pup.name).to eq('Lucky')
      expect(pup.breed).to be_a(PuppyBreeder::Breed)
      expect(pup.breed.name).to eq('terrier')
      expect(pup.breed.price).to eq(2000)
      expect(pup.status).to eq('available')
    end
  end
end