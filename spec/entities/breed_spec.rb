require_relative '../spec_helper.rb'

describe PuppyBreeder::Breed do
  let(:terrier){ PuppyBreeder::Breed.new({
      name: 'terrier'
    })
  }
  let(:poodle){ PuppyBreeder::Breed.new({
      name: 'poodle',
      price: 2000
    })
  }

  describe 'initialize' do
    it 'creates a new instance of Breed' do
      expect(terrier).to be_a(PuppyBreeder::Breed)
      expect(terrier.name).to eq('terrier')
    end

    it 'sets a breed price if given and nil if not' do
      expect(terrier.price).to eq(0)
      expect(poodle.price).to eq(2000)
    end
  end

  describe 'price' do
    it "changes the breed's price" do
      poodle.price = 1500
      expect(poodle.price).to eq(1500)
    end
  end
end