require 'spec_helper'

describe Petshops::UserRepo do

  def user_count(db)
    db.exec("SELECT COUNT(*) from users")[0]["count"].to_i
  end

  let(:db) {Petshops.create_db_connection('pet_test')}
  
  before(:each) do
    Petshops.clear_tables(db)
  end

  it "saves a user to database" do
    expect(user_count(db)).to eq(0)
    user = Petshops::UserRepo.save(db, {'username' => 'jill', 'password' => '123'})
    expect(user['username']).to eq('jill')
    expect(user['id']).to_not be_nil
    expect(user_count(db)).to eq(1)
  end

  it "gets all users" do
    Petshops::UserRepo.save(db, {'username' => 'jill', 'password' => '123'})
    Petshops::UserRepo.save(db, {'username' => 'jill', 'password' => '123'})
    result = Petshops::UserRepo.all(db)
    expect(result).to be_a Array
    expect(user_count(db)).to eq(2)
    expect(result.count).to eq(2)
  end
  
  it 'finds a user by username' do
      user = Petshops::UserRepo.save(db, {'username' => 'jill', 'password' => '123'})
      result = Petshops::UserRepo.find_by_name(db, user['username'])
      expect(result['id']).to eq(user['id'])
      expect(result['password']).to eq('123')
  end
  
  it 'finds a user by id' do
      user = Petshops::UserRepo.save(db, {'username' => 'jill', 'password' => '123'})
      result = Petshops::UserRepo.find_by_id(db, user['id'])
      expect(result['username']).to eq('jill')
    end
    
    it 'gets all pets user owns' do
    shop = Petshops::ShopRepo.save(db, 'pet shop')
    dog = Petshops::DogRepo.save(db, {'name' => 'bob barker', 'image_url' => 'www.dogpic.com', 'shop_id' => shop['id']})
    cat = Petshops::CatRepo.save(db, {'name' => 'kitty', 'image_url' => 'www.catpic.com', 'shop_id' => shop['id']})
    owner = Petshops::UserRepo.save(db, {'name' => 'John', 'password' => '123'})
    Petshops::DogRepo.save(db, {'id' => dog['id'], 'owner_id' => owner['id'], 'shop_id' => shop['id']})
    Petshops::CatRepo.save(db, {'id' => cat['id'], 'owner_id' => owner['id'], 'shop_id' => shop['id']})
    result = Petshops::UserRepo.grab_all_pets(db, owner['id'])
    expect(result).to be_a Array
    end
end