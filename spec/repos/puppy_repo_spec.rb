require_relative '../spec_helper.rb'

describe PuppyBreeder::Repos::Puppies do
  let(:puppies){ PuppyBreeder.puppies_repo }
  let(:poodle){ PuppyBreeder::Breed.new({
      name: 'poodle'
    })
  }

  describe 'create' do
    context 'stores a new puppy object in the puppy list' do
      it 'works with a breed object' do
        puppy = puppies.create({name: 'sprinkles', breed: poodle})
        expect(puppy).to be_a(PuppyBreeder::Puppy)
        expect(puppy.name).to eq('sprinkles')
      end

      it 'works with a breed string' do
        puppy = puppies.create({name: 'sprinkles', breed: 'poodle'})
        expect(puppy).to be_a(PuppyBreeder::Puppy)
        expect(puppy.breed.name).to eq('poodle')
      end
    end
  end

  describe 'find_by' do
    before(:each){ puppies.create({name: 'sprinkles', breed: poodle})}

    it 'finds a puppy by its name' do
      puppy = puppies.find_by({name: 'sprinkles'}).first
      expect(puppy).to be_a(PuppyBreeder::Puppy)
      expect(puppy.name).to eq('sprinkles')
      expect(puppy.breed.name).to eq('poodle')
    end

    it 'finds all puppies with the same breed' do
      puppies.create({name: 'lucky', breed: poodle})
      poodles = puppies.find_by({breed: poodle})
      expect(poodles.length).to eq(2)
      expect(poodles.last).to be_a(PuppyBreeder::Puppy)
    end
  end

  describe 'update' do
    before(:each){ puppies.create({name: 'sprinkles', breed: poodle})}

    it 'changes the status of the puppy' do
      puppy = puppies.find_by({name: 'sprinkles'}).first
      expect(puppy.status).to eq('available')
      puppy = puppies.update({name: 'sprinkles', status: 'sold'})
      expect(puppy.status).to eq('sold')
    end
  end
end