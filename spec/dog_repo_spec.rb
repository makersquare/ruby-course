require 'spec_helper'

describe Petshops::DogRepo do

  def dog_count(db)
    db.exec("SELECT COUNT(*) from dogs")[0]["count"].to_i
  end

  let(:db) {Petshops.create_db_connection('pet_test')}
  
  before(:each) do
    Petshops.clear_tables(db)
  end

  it "saves a dog to database" do
    expect(dog_count(db)).to eq(0)
    shop = Petshops::ShopRepo.save(db, 'pet shop')
    dog = Petshops::DogRepo.save(db, {'name' => 'bob barker', 'image_url' => 'www.dogpic.com', 'shop_id' => shop['id']})
    expect(dog['name']).to eq('bob barker')
    expect(dog['id']).to_not be_nil
    expect(dog['image_url']).to eq('www.dogpic.com')
    expect(dog['shop_id']).to eq(shop['id'])
    expect(dog['adopted']).to be_nil
    expect(dog_count(db)).to eq(1)
  end
  
  xit 'changes status to adopted and adds owner to dog' do
    shop = Petshops::ShopRepo.save(db, 'pet shop')
    dog = Petshops::DogRepo.save(db, {'name' => 'bob barker', 'image_url' => 'www.dogpic.com', 'shop_id' => shop['id']})
    owner = Petshops::UserRepo.save(db, {'name' => 'John', 'password' => '123'})
    result = Petshops::DogRepo.save(db, ('id' => dog['id'], 'owner_id' => owner['id'], 'shop_id' => shop['id'])
    expect(result['owner_id']).to eq(owner['id'])
    expect(result['shop_id']).to eq(shop['id'])
    expect(result['adopted']).to eq(true)
  end
  

  it "gets all dogs" do
    shop = Petshops::ShopRepo.save(db, 'super pets')
    shop_2 = Petshops::ShopRepo.save(db, 'my pet shop')
    dog = Petshops::DogRepo.save(db, {'name' => 'rudy', 'image_url' => 'www.dogpic.com', 'shop_id' => shop['id']})
    dog2 = Petshops::DogRepo.save(db, {'name' => 'mr scratch', 'image_url' => 'www.dogpic2.com', 'shop_id' => shop_2['id']})
    result = Petshops::DogRepo.all(db)
    expect(result).to be_a Array
    expect(dog_count(db)).to eq(2)
    expect(result.count).to eq(2)
  end
  
  it 'finds a dog by shop id' do
      shop = Petshops::ShopRepo.save(db, 'super pets')
      dog = Petshops::DogRepo.save(db, {'name' => 'griz', 'image_url' => 'www.dogpic.com', 'shop_id' => shop['id']})
      result = Petshops::DogRepo.find_by_shop_id(db, shop['id'])
      expect(result['name']).to eq('griz')
      expect(result['id']).to eq(dog['id'])
      expect(result['imageUrl']).to eq('www.dogpic.com')
      expect(result['adopted']).to be_nil
  end
  
  it 'finds a dog by name' do
      shop = Petshops::ShopRepo.save(db, 'super pets')
      dog = Petshops::DogRepo.save(db, {'name' => 'bli', 'image_url' => 'www.dogpic.com', 'shop_id' => shop['id']})
      result = Petshops::DogRepo.find_by_name(db, 'bli')
      expect(result['id']).to eq(dog['id'])
    end
end