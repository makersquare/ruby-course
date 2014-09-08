puts "Including double dog..."
require File.join(Rails.root, '../lib/double_dog.rb')

### Stub authentication
# Create a user
user = DoubleDog.db.create_user(:username => 'alice', :password => 'pass1', :admin => true)

# Sign in that user
result = DoubleDog::SignIn.new.run(:username => 'alice', password: 'pass1')

# Store the session id in a global variable
$session_id = result[:session_id]

### Seed database
# Create some items
item_1 = DoubleDog.db.create_item(:name => 'hot dog', :price => 5)
item_2 = DoubleDog.db.create_item(:name => 'burger', :price => 7)
# Create some orders
DoubleDog::CreateOrder.new.run(:session_id => $session_id, :items => [item_1, item_1, item_2])
DoubleDog::CreateOrder.new.run(:session_id => $session_id, :items => [item_2, item_2, item_2])
