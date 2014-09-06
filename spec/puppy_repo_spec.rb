require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::Puppies do
  before(:each) {PuppyBreeder.puppy_repo.destroy_and_rebuild}
  before(:each) {PuppyBreeder.breed_repo.destroy_and_rebuild}

  describe '.log' do
    it 'returns an array of puppy objects' do
      puppies = PuppyBreeder.puppy_repo
      result = puppies.log

      expect(result).to eq ([])

      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      puppies.add_puppy(spot)
      result = puppies.log

      expect(result.size).to eq 1
      expect(result.first.class).to eq(PuppyBreeder::Puppy)
    end 
  end

  describe '.add_puppy' do
    it "can add puppies to the database" do
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      fido = PuppyBreeder::Puppy.new("Fido", 2, "Pitbull")
      puppies = PuppyBreeder.puppy_repo
      puppies.add_puppy(spot)
      result = puppies.log

      expect(result.size).to eq 1
      expect(result.first.age.to_i).to eq 1
      expect(result.first.breed).to eq "Golden Retriever"
      expect(result.first.availability).to eq :for_sale

      puppies.add_puppy(fido)
      result = puppies.log

      expect(result.size).to eq 2
      expect(result.last.age.to_i).to eq 2
      expect(result.last.breed).to eq "Pitbull"
      expect(result.last.availability).to eq :for_sale
    end

    context "the breed of the puppy is not listed in the breeds database" do
      it "adds puppy to database with nil price" do
        spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
        puppies = PuppyBreeder.puppy_repo
        puppies.add_puppy(spot)
        result = puppies.log

        expect(result.first.price).to be_nil
      end
    end 

    context "the breed of the puppy is listed in the breeds database" do
      it "adds puppy to database with price from breed database" do
        puppies = PuppyBreeder.puppy_repo
        spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
        breeds = PuppyBreeder.breed_repo
        golden = PuppyBreeder::Breed.new("Golden Retriever", 800)
        breeds.add_breed(golden)
        puppies.add_puppy(spot)
        result = puppies.log

        expect(result.first.price).to eq "$800.00"
      end
    end 

  end

  describe '.update_prices' do
    it "updates the puppies database with prices from the breeds database" do
      breeds = PuppyBreeder.breed_repo
      puppies = PuppyBreeder.puppy_repo
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      fido = PuppyBreeder::Puppy.new("Fido", 2, "Pitbull")
      puppies.add_puppy(spot)
      puppies.add_puppy(fido)

      result = puppies.log

      expect(result.all?{|x| x.price == nil}).to be_true

      golden = PuppyBreeder::Breed.new("Golden Retriever", 800)
      pitbull = PuppyBreeder::Breed.new("Pitbull", 500)
      breeds.add_breed(golden)
      breeds.add_breed(pitbull)

      puppies.update_prices(breeds.log)

      result = puppies.log

      expect(result.all?{|x| x.price}).to be_true
      expect(result.first.price).to eq "$800.00"
    end
  end

  describe '.update_availability' do
    it "updates a puppy availability in the database to sold" do
      
    end
  end

end