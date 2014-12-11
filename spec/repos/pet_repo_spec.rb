require 'spec_helper'

describe Petshop::DogRepo do

  def dog_count
    repo.all(db).count
  end

  let(:repo) { Petshop::DogRepo }
  let(:db) { Petshop.create_db_connection('petshop_test') }

  before(:each) do
    Petshop.clear_db(db)
    @shop_id = Petshop::ShopRepo.save(db, { 'name' => "SuperShop" })['id']
  end

  xit "gets all dogs" do
    dog = repo.save(db, {'name' => "Barnaby", 'shop_id' => @shop_id, 'urlImage' => '', 'adopted_status' => false })
    dog = repo.save(db, {'name' => "Giles", 'shop_id' => @shop_id, 'urlImage' => '', 'adopted_status' => false })
    dog = repo.save(db, {'name' => "Goji", 'shop_id' => @shop_id, 'urlImage' => '', 'adopted_status' => false })
    dog = repo.save(db, {'name' => "Berry", 'shop_id' => @shop_id, 'urlImage' => '', 'adopted_status' => false })

    dogs = repo.all(db)
    expect(songs).to be_a Array
    expect(songs.count).to eq 4

    names = dogs.map {|u| u['name'] }
    expect(names).to include "Barnaby", "Giles", "Goji", "Berry"
  end

  xit "creates dogs" do
    expect(dog_count).to eq 0

    dog = repo.save(db, {'name' => "Barnaby", 'shop_id' => @shop_id, 'urlImage' => '', 'adopted_status' => false })
    expect(dog['id']).to_not be_nil
    expect(dog['shop_id']).to_not be_nil
    expect(song['name']).to eq "Barnaby"

    # Check for persistence
    expect(dog_count).to eq 1

    dog_count_by_store = repo.find_all_by_shop(db)
    dog_count_by_store.each do |dog|
      expect(dog['id'].to_i).to eq 1
    end

    dog = repo.all(db).first
    expect(dog['id']).to_not be_nil
    expect(dog['shop_id']).to_not be_nil
    expect(song['name']).to eq "Barnaby"

  end

  xit "requires a name" do
    expect { repo.save(db, {}) }.to raise_error {|e|
      expect(e.message).to match /name/
    }
  end

  xit "requires an shop id" do
    expect {
      repo.save(db, { 'name' => "Barnaby" })
    }
    .to raise_error {|e|
      expect(e.message).to match /shop_id/
    }
  end

  xit "requires an imageUrl" do
    expect {
      repo.save(db, { 'name' => "Barnaby", 'shop_id' => @shop_id })
    }
    .to raise_error {|e|
      expect(e.message).to match /imageUrl/
    }
  end

  xit "finds dogs" do
    dog = repo.save(db, {'name' => "Barnaby", 'shop_id' => @shop_id, 'urlImage' => '', 'adopted_status' => false })
    retrieved_dog = repo.find(db, dog['id'])
    expect(retrieved_dog['name']).to eq "Barnaby"
  end

  xit "updates dogs" do
    dog = repo.save(db, {'name' => "Barnaby", 'shop_id' => @shop_id, 'urlImage' => '', 'adopted_status' => false })
    dog2 = repo.save(db, { 'id' => dog['id'], 'name' => "Funky" })
    expect(dog2['id']).to eq(dog['id'])
    expect(dog2['name']).to eq "Funky"

    # Check for persistence
    dog3 = repo.find(db, dog['id'])
    expect(dog3['name']).to eq "Funky"
  end

end
