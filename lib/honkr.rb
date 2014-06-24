
module Honkr
  def self.db
    @__db_instance ||= Databases::InMemory.new
  end
end

require_relative './honkr/databases/in_memory.rb'

require_relative './honkr/entities/user.rb'
require_relative './honkr/entities/honk.rb'

require_relative './honkr/scripts/create_honk.rb'
require_relative './honkr/scripts/sign_in.rb'
