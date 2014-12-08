require 'spec_helper'

describe Library::BookRepo do

  def book_count(db)
    db.exec("SELECT COUNT(*) FROM books")[0]["count"].to_i
  end
#creates a variable to use //
#is lazy the code will never run till we use it//
#let defines the instance variable :db that we will use
#inside our code

  let(:db) { Library.create_db_connection('library_test') }

#before each => we are clearing our db
  before(:each) do
    Library.clear_db(db)
  end

  it "gets all books" do
    db.exec("INSERT INTO books (title) VALUES ($1)", ["Alice in Wonderland"])
    db.exec("INSERT INTO books (title) VALUES ($1)", ["Bob"])

    users = Library::UserRepo.all(db)
    expect(users).to be_a Array
    expect(users.count).to eq 2

    names = users.map {|u| u['name'] }
    expect(names).to include "Alice", "Bob"
  end

  it "creates users" do
    users = Library::UserRepo.all(db)
    expect(users.count(db)).to eq 0

    user = Library::UserRepo.save(db, {'name' => 'Alice'})
    expect(user['id']).to_not be_nil
    expect(user['name']).to eq 'Alice'

    # Check for persistence
    expect(user_count(db)).to eq 1

    user = db.exec("SELECT * FROM users")[0]
    expect(user['name']).to eq "Alice"
  end

  it "finds users" do
    user = Library::UserRepo.save(db, {'name' => 'Alice'})
    retrieved_user = Library::UserRepo.find(db, user['id'])
    expect(retrieved_user['name']).to eq "Alice"
  end

  it "updates users" do
    user1 = Library::UserRepo.save(db, {'name' => "Alice"})

    user2 = Library::UserRepo.save(db, {'id' => user1['id'], 'name' => "Alicia"})
    expect(user2['id']).to eq(user1['id'])
    expect(user2['name']).to eq "Alicia"

    # Check for persistence
     user3 = Library::UserRepo.find(db, user1['id'])
     expect(user3['name']).to eq "Alicia"
  end

  it "destroys users" do
    user = Library::UserRepo.save(db, 'name' => "Alice")
    expect(user_count(db)).to eq 1

    Library::UserRepo.destroy(db, user['id'])
    expect(user_count(db)).to eq 0
  end
end
