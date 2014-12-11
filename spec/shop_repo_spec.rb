# require_relative 'repo/shop_repo.rb'
require 'spec_helper'

describe Petshops::ShopRepo do

  def shop_count(db)
    db.exec("SELECT COUNT(*) from shops")[0]["count"].to_i
  end

  let(:db) {Petshops.create_db_connection('pet_test')}
  
  before(:each) do
    Petshops.clear_db(db)
  end

  it "saves a shop to database" do
    expect(shop_count(db)).to eq(0)
    shop = Petshops::ShopRepo.save(db, 'super pets')
    expect(shop['name']).to eq('super pets')
    expect(shop['id']).to_not be_nil
    expect(shop_count(db)).to eq(1)
  end

  it "gets all shops" do
    shop = Petshops::ShopRepo.save(db, 'super pets')
    shop_2 = Petshops::ShopRepo.save(db, 'my pet shop')
    result = Petshops::ShopRepo.all(db)
    expect(result).to be_a Array
    expect(shop_count(db)).to eq(2)
    expect(result.count).to eq(2)
  end

end
