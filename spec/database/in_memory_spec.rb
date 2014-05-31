require 'spec_helper'

describe DoubleDog::Database::InMemory do
  let(:db) { described_class.new }

  it "creates a user" do
    user = db.create_user(:username => 'alice', :password => 'pass1')
    expect(user.id).to_not be_nil
    expect(user.username).to eq 'alice'
    expect(user.has_password? 'pass1').to eq true
    expect(user.admin?).to eq false
  end

  it "creates an admin user" do
    user = db.create_user(:username => 'alice', :password => 'pass1', :admin => true)
    expect(user.id).to_not be_nil
    expect(user.username).to eq 'alice'
    expect(user.has_password? 'pass1').to eq true
    expect(user.admin?).to eq true
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

  it "creates an order" do
    item_1 = db.create_item(:name => 'fries', :price => 3)
    item_2 = db.create_item(:name => 'pickle', :price => 4)
    item_3 = db.create_item(:name => 'potato', :price => 8)
    emp = db.create_user(:username => 'mitch', :password => 'pass1')

    order = db.create_order(:employee_id => emp.id, :items => [item_1, item_2, item_3])
    expect(order).to be_a DoubleDog::Order

    expect(order.id).to_not be_nil
    expect(order.employee_id).to eq(emp.id)
  end

  it "retrieves an order" do
    item_1 = db.create_item(:name => 'fries', :price => 3)
    item_2 = db.create_item(:name => 'pickle', :price => 4)
    item_3 = db.create_item(:name => 'potato', :price => 8)
    emp = db.create_user(:username => 'mitch', :password => 'pass1')

    order = db.create_order(:employee_id => emp.id, :items => [item_1, item_2, item_3])
    retrieved_order = db.get_order(order.id)
    expect(retrieved_order).to be_a DoubleDog::Order
    expect(retrieved_order.employee_id).to eq(emp.id)
    expect(retrieved_order.items).to include(item_1, item_2, item_3)
  end

  it "grabs all orders" do
    item_1 = db.create_item(:name => 'fries', :price => 3)
    item_2 = db.create_item(:name => 'pickle', :price => 4)
    item_3 = db.create_item(:name => 'potato', :price => 8)
    emp_1 = db.create_user(:username => 'mitch', :password => 'pass1')
    emp_2 = db.create_user(:username => 'mell', :password => 'pass2')
    emp_3 = db.create_user(:username => 'donald', :password => 'pass3')

    order_1 = db.create_order(:employee_id => emp_1.id, :items => [item_1, item_2, item_3])
    order_2 = db.create_order(:employee_id => emp_2.id, :items => [item_1, item_3])
    order_3 = db.create_order(:employee_id => emp_3.id, :items => [item_2, item_3])

    orders = db.all_orders
    expect(orders.count).to eq(3)
    expect(orders.map &:employee_id).to include(emp_1.id, emp_2.id, emp_3.id)
    expect(orders.first.items.count).to be >= 2
  end
end
