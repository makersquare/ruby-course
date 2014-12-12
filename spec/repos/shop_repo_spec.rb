require 'spec_helper'

describe PetShop::ShopRepo do

  def shop_count
    repo.all(db).count
  end

  let(:repo) { PetShop::ShopRepo }
  let(:db) { PetShop.create_db_connection('petshop_test') }

  before(:each) do
    PetShop.clear_db(db)
    @shopid1 = PetShop::ShopRepo.save(db, { 'name' => "Pup By Pup Best" })['id']
    @shopid2 = PetShop::ShopRepo.save(db, { 'name' => "U Buy Cat Now" })['id']
  end

  it "gets all shops" do

    shops = repo.all(db)
    expect(shops).to be_a Array
    expect(shops.count).to eq 2

    names = shops.map {|u| u['name'] }
    expect(names).to include "Pup By Pup Best", "U Buy Cat Now"
  end

  it "creates shops" do
    expect(shop_count).to eq 2

    shop = repo.save(db, { 'name' => "Bitten by Kittens" })
    expect(shop['id']).to_not be_nil
    expect(shop['name']).to eq "Bitten by Kittens"

    # Check for persistence
    expect(shop_count).to eq 3

    shop = repo.all(db).first
    expect(shop['id']).to_not be_nil
    expect(shop['name']).to eq "Pup By Pup Best"

  end

  it "requires a name" do
    expect { repo.save(db, {}) }.to raise_error {|e|
      expect(e.message).to match /name/
    }
  end

  it "requires an shop id that exists" do
    expect {
      repo.save(db, { 'id' => 999, 'name' => "Mr Puppy Love" })
    }
    .to raise_error {|e|
      expect(e.message).to match /shop id/
    }
  end

  it "finds shops" do
    retrieved_shop = repo.find(db, @shopid1)
    expect(retrieved_shop['name']).to eq "Pup By Pup Best"
  end

  it "updates shops" do
    shop1 = repo.save(db, { 'id' => @shopid1, 'name' => "Billy Boy" })
    expect(shop1['id']).to eq(@shopid1)

    # Check for persistence
    shop2 = repo.find(db, shop1['id'])
    expect(shop2['name']).to eq "Billy Boy"
  end

end
