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
end