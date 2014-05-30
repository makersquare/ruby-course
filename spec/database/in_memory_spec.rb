require 'spec_helper'

describe DoubleDog::Database::InMemory do
  let(:db) { described_class.new }

  it "creates a user" do
    user = db.create_user(:username => 'alice', :password => 'pass1')
    expect(user.id).to_not be_nil
    expect(user.username).to eq 'alice'
    expect(user.has_password? 'pass1').to eq true
  end

  it "retrieves a user" do
    user = db.create_user(:username => 'bob', :password => 'pass2')
    retrieved_user = db.get_user(user.id)
    expect(retrieved_user.username).to eq 'bob'
    expect(retrieved_user.has_password? 'pass2').to eq true
  end

  it "creates a session and returns its id" do
    session_id = db.create_session(:user_id => 8)
    expect(session_id).to_not be_a Hash
  end

  it "retrieves a user by username" do
    user = db.create_user(:username => 'pim', :password => 'cookies')
    retrieved_user = db.get_user_by_username(user.username)

    expect(retrieved_user.username).to eq('pim')
    expect(retrieved_user.has_password? 'cookies').to eq true
  end

  it "retrieves a user by session id" do
    user = db.create_user(:username => 'sally', :password => 'seashells')
    session_id = db.create_session(:user_id => user.id)

    retrieved_user = db.get_user_by_session_id(session_id)
    expect(retrieved_user.username).to eq 'sally'
    expect(retrieved_user.has_password? 'seashells').to eq true
  end

  it "creates an item" do
    item = db.create_item(:name => 'hot dog', :price => 5)
    expect(item).to be_a DoubleDog::Item

    expect(item.id).to_not be_nil
    expect(item.name).to eq 'hot dog'
    expect(item.price).to eq 5
  end

  it "retrieves an item" do
    item = db.create_item(:name => 'hot dog', :price => 5)

    retrieved_item = db.get_item(item.id)
    expect(retrieved_item).to be_a DoubleDog::Item
    expect(retrieved_item.name).to eq 'hot dog'
    expect(retrieved_item.price).to eq 5
  end

  it "grabs all items" do
    db.create_item(:name => 'fries', :price => 3)
    db.create_item(:name => 'pickle', :price => 4)
    db.create_item(:name => 'potato', :price => 8)

    items = db.all_items
    expect(items.count).to eq 3
    expect(items.first).to be_a DoubleDog::Item

    expect(items.map &:name).to include('fries', 'pickle', 'potato')
    expect(items.map &:price).to include(3, 4, 8)
  end
end
