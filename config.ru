require './server'

# set up db tables
db = PetShop.create_db_connection 'petshop_dev'
PetShop.create_tables db

# run web app
run PetShop::Server
