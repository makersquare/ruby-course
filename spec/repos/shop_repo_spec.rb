require 'spec_helper'

describe Petshop::ShopRepo do

  def owner_count
    repo.all(db).count
  end

  let(:repo) { Petshop::ShopRepo }
  let(:db) { Petshop.create_db_connection('petshop_test') }

  before(:each) do
    Petshop.clear_db(db)
    @shop_id1 = Petshop::ShopRepo.save(db, { 'title' => "Pup By Pup Best" })['id']
    @shop_id2 = Petshop::ShopRepo.save(db, { 'title' => "U Buy Cat Now" })['id']
  end

  xit "gets all shops" do

    shops = repo.all(db)
    expect(shops).to be_a Array
    expect(shops.count).to eq 2

    titles = shops.map {|u| u['title'] }
    expect(titles).to include "Pup By Pup Best", "U Buy Cat Now"
  end

  xit "creates shops" do
    expect(shop_count).to eq 2

    owner = repo.save(db, { 'title' => "Bitten by Kittens" })
    expect(shop['id']).to_not be_nil
    expect(shop['title']).to eq "Bitten by Kittens"

    # Check for persistence
    expect(shop_count).to eq 3

    shop = repo.all(db).first
    expect(owner['id']).to_not be_nil
    expect(owner['title']).to eq "Pup By Pup Best"

  end

  xit "requires a title" do
    expect { repo.save(db, {}) }.to raise_error {|e|
      expect(e.message).to match /title/
    }
  end

  xit "requires an shop id that exists" do
    expect {
      repo.save(db, { 'id' => 999, 'title' => "Mr Puppy Love" })
    }
    .to raise_error {|e|
      expect(e.message).to match /shop id/
    }
  end

  xit "finds shops" do
    retrieved_shop = repo.find(db, @shop_id1)
    expect(retrieved_owner['name']).to eq "Pup By Pup Best"
  end

  xit "updates shops" do
    shop1 = repo.save(db, { 'id' => @shop_id1, 'title' => "Billy Boy" })
    expect(shop1['id']).to eq(@shop_id1)

    # Check for persistence
    shop2 = repo.find(db, shop1['id'])
    expect(owner3['title']).to eq "Billy Boy"
  end

end
