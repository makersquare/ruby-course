require 'pg'

require_relative 'pet-shop-server/repos/pets_repo.rb'
require_relative 'pet-shop-server/repos/shops_repo.rb'
require_relative 'pet-shop-server/repos/users_repo.rb'
#pet-shop-server

module PetShopServer
  def self.create_db_connection(dbname)
    PG.connect(dbname: dbname)
  end
end