require 'spec_helper'
require_relative "lib/users_repo/users_repo.rb"

describe PetShop::UsersRepo do

  def user_count(db)
    db.exec("SELECT COUNT(*) FROM users")[0]["count"].to_i
  end

  let(:db) { PetShop.create_db_connection('library_test') }

  before(:each) do
    PetShop.drop_tables(db)
    PetShop.create_tables(db)
  end

  it "creates users" do
    expect(user_count(db)).to eq 0
    user = PetShop::UserRepo.save(db, {'username' => "alice", 'password' => '123' })
    expect(user['id']).to_not be_nil
    expect(user['username']).to eq "alice"


    # Check for persistence
    expect(user_count(db)).to eq 1

    user = db.exec("SELECT * FROM users")[0]
    expect(user['username']).to eq "alice"
  end

  it "finds users" do
    user = PetShop::UserRepo.save(db, {'username' => "alice", 'password' => '123' })
    retrieved_user = PetShop::UserRepo.find(db, user['id'])
    expect(retrieved_user['username']).to eq "Alice"
  end

  it "adopts pets" do
    user1 = PetShop::UserRepo.save(db, {'username' => "alice", 'password' => '123' })
    r = db.exec <<-SQL
      INSERT INTO petshops (name) values ('My Pet Shop') RETURNING id
    SQL
    caturl = "http://nextranks.com/data_images/main/cats/cats-04.jpg"
    shopid = r[0]['id']
    q = "INSERT INTO cats (shopid, imageurl, name, adopted) values ($1, $2,  'cat1', 'false')"
    cat = db.exec(q,[shopid, caturl])
    user1["type"]="cat"
    user1["pet_id"] = cat['id']
    PetShop::UserRepo.adopt(db, user1)
    cat = db.exec("SELECT * FROM cats").to_a[0]
    expect(cat['adopted']).to be_true
  end
end