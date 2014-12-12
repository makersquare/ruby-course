require 'spec_helper'

describe PetShop::ShopRepo do

  def shop_count
    repo.all(db).count
  end

  let(:repo) { PetShop::ShopRepo }
  let(:db) { PetShop.create_db_connection('petshop_test') }

  before(:each) do
    PetShop.clear_db(db)
    @shop_id1 = PetShop::ShopRepo.save(db, { 'title' => "Pup By Pup Best" })['id']
    @shop_id2 = PetShop::ShopRepo.save(db, { 'title' => "U Buy Cat Now" })['id']
  end

  it "gets all shops" do

    shops = repo.all(db)
    expect(shops).to be_a Array
    expect(shops.count).to eq 2

    titles = shops.map {|u| u['title'] }
    expect(titles).to include "Pup By Pup Best", "U Buy Cat Now"
  end

  it "creates shops" do
    expect(shop_count).to eq 2

    shop = repo.save(db, { 'title' => "Bitten by Kittens" })
    expect(shop['id']).to_not be_nil
    expect(shop['title']).to eq "Bitten by Kittens"

    # Check for persistence
    expect(shop_count).to eq 3

    shop = repo.all(db).first
    expect(shop['id']).to_not be_nil
    expect(shop['title']).to eq "Pup By Pup Best"

  end

  it "requires a title" do
    expect { repo.save(db, {}) }.to raise_error {|e|
      expect(e.message).to match /title/
    }
  end

  it "requires an shop id that exists" do
    expect {
      repo.save(db, { 'id' => 999, 'title' => "Mr Puppy Love" })
    }
    .to raise_error {|e|
      expect(e.message).to match /shop id/
    }
  end

  it "finds shops" do
    retrieved_shop = repo.find(db, @shop_id1)
    expect(retrieved_shop['title']).to eq "Pup By Pup Best"
  end

  it "updates shops" do
    shop1 = repo.save(db, { 'id' => @shop_id1, 'title' => "Billy Boy" })
    expect(shop1['id']).to eq(@shop_id1)

    # Check for persistence
    shop2 = repo.find(db, shop1['id'])
    expect(shop2['title']).to eq "Billy Boy"
  end

end
