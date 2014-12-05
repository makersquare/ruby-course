require_relative '../spec_helper.rb'

describe PuppyBreeder::List do
  let(:puppies){ PuppyBreeder::List.new({
      name: 'puppies'
    })
  }
  let(:requests){ PuppyBreeder::List.new({
      name: 'purchase requests'
    })
  }
  let(:poodle){ PuppyBreeder::Breed.new({
      name: 'poodle'
    })
  }
  let(:lucky){ PuppyBreeder::Puppy.new({
      name: 'Lucky',
      breed: poodle
    })
  }
  let(:sprinkles){ PuppyBreeder::Puppy.new({
      name: 'Sprinkles',
      breed: poodle
    })
  }

  describe 'initialize' do
    it 'creates an empty list' do
      expect(requests).to be_a(PuppyBreeder::List)
      expect(requests.name).to eq('purchase requests')
      expect(requests.length).to eq(0)
    end
  end

  describe 'add' do
    it 'pushes an object to the end of the list' do
      puppies.add(lucky)
      expect(puppies.length).to eq(1)

      puppies.add(sprinkles)
      expect(puppies.list.last.name).to eq('Sprinkles')
    end
  end
end