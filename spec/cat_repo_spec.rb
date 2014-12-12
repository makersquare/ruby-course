# require_relative 'repo/shop_repo.rb'
require 'spec_helper'

describe Petshops::CatRepo do

  def cat_count(db)
    db.exec("SELECT COUNT(*) from cats")[0]["count"].to_i
  end

  let(:db) {Petshops.create_db_connection('pet_test')}
  
  before(:each) do
    Petshops.clear_tables(db)
  end

  it "saves a cat to database" do
    expect(shop_count(db)).to eq(0)
    shop = Petshops::ShopRepo.save(db, 'pet shop')
    cat = Petshops::CatRepo.save(db, {'name' => 'squeaks', 'image_url' => 'www.catpic.com', 'shop_id' => shop['id']})
    expect(cat['name']).to eq('squeaks')
    expect(cat['id']).to_not be_nil
    expect(cat['imageUrl']).to eq('www.catpic.com')
    expect(cat['shopId']).to eq(shop['id'])
    expect(cat_count(db)).to eq(1)
  end

  it "gets all cats" do
    shop = Petshops::ShopRepo.save(db, 'super pets')
    shop_2 = Petshops::ShopRepo.save(db, 'my pet shop')
    cat = Petshops::CatRepo.save(db, {'name' => 'squeaks', 'image_url' => 'www.catpic.com', 'shopId' => shop['id']})
    cat2 = Petshops::CatRepo.save(db, {'name' => 'mr mistofolees', 'image_url' => 'www.catpic2.com', 'shop_id' => shop_2['id']})
    result = Petshops::CatRepo.all(db)
    expect(result).to be_a Array
    expect(cat_count(db)).to eq(2)
    expect(result.count).to eq(2)
  end
  
  xit 'finds a cat by shop id' do
      shop = Petshops::ShopRepo.save(db, 'super pets')
      cat = Petshops::CatRepo.save(db, {'name' => 'grizzabella', 'image_url' => 'www.catpic.com', 'shop_id' => shop['id']})
      result = Petshops::CatRepo.find_cat_id_shop_id(db, shop['id'])
      expect(result['name']).to eq('grizzabella')
      expect(result['id']).to eq(cat['id'])
      expect(result['image_url']).to eq('www.catpic.com')
      expect(result['adopted']).to eq(false)
  end
  
  it 'finds a cat by name' do
      shop = Petshops::ShopRepo.save(db, 'super pets')
      cat = Petshops::CatRepo.save(db, {'name' => 'blinksy', 'image_url' => 'www.catpic.com', 'shop_id' => shop['id']})
      result = Petshops::CatRepo.find_by_name(db, 'blinksy')
      expect(result['id']).to eq(cat['id'])
    end
end