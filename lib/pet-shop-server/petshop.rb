require 'pg'

require_relative 'repos/pets_repo.rb'
require_relative 'repos/shops_repo.rb'
require_relative 'repos/users_repo.rb'
#pet-shop-server

module PetShopServer
  def self.create_db_connection(dbname)
    PG::Connection.new(dbname: dbname)
  end
end