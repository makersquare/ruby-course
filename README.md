## Setup

Run the following commands to clone down the exercise and get your Gems installed.
```console
$ git clone https://github.com/makersquare/ruby-course migrations
$ cd migrations
$ git checkout migrations

--- now in your VM navigate to the migrations directory

$ bundle install
```

One call Gems are installed you need to use some Rake tasks to create your database (just the DB, not tables yet). You can do this by running `bundle exec rake db:create`. If successful there will be no feedback (isn't that nice?). You can double check that it worked by running `psql -l` in your terminal and looking for databases called `migrations_dev` and `migrations_test`.


# Exercise 1

In this exercise you will will write migrations (and run them!) to build out a database for a fictional wholesale business. You will use user stories to determine what attributes each item needs which should inform on how to structure your database.

## User Stories

1. As a customer I want to place orders for products
2. As a customer I'd like to see the total cost of my order
3. As a seller I'd like to add new products to inventory (description, price)
4. As a seller I'd like to view all orders by date

Design your schema in any way you'd like. Once complete begin writing your migrations to build the schema you imagined. Remember: we want to build our schema very incrementally so if two changes have absolutely nothing to do with one another then maybe they can go into separate migrations.

## Updates

After entering only a few products into inventory we discovered that we had many products with very similar descriptions. For instance two different pairs of brown gloves simply have descriptions from the manufacturer as "BROWN GLOVES" even though one is leather and one is wool. The warehouse team has come up with a product numbering system. You now need to add this new attribute to the products table.



# Exercise 2

You are creating a simple blogging platform so users can create simple posts and view other posts by other users. There are some rules on this service and so an administrator 


## User Stories

1. As a user I'd like to sign up
2. As a user I'd like to create posts
3. As a user I'd like to organize posts by their title
4. As a user I'd like to create posts with very long bodies
5. As an admin I'd like to view all users over a given age

## Updates

Your customer has come back again to make change to the application. Now he tells you that he will no longer ask users for their age. He also says that he wants to be able to find users by their zipcode.

The senior dev leading your team is worried about people signing up with duplicate email addresses. ActiveRecord provides a way for you to validate uniqueness but he wants to be extra sure by adding a constraint to your the `users` table.

In the past when a post was deemed to be inappropriate it was simply deleted from the database. The owners of Blogtastic do not like losing this data and have come up with a way to not show inappropriate posts without permanently removing them from the database: flags. When an admin sees an inappropriate post he can flag it. Then anywhere in the application, when retrieving all posts, ones that have been flagged will not be returned.

There's more... 

## Resources

You can ask me questions!
You can also refer to [this](http://learn.makersquare.com/courses/ruby/documentation/active_record_configuration.mdx) tutorial.
