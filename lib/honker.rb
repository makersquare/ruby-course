
module Honker
  def self.db
    @__db_instance ||= Databases::InMemory.new
  end
end

require_relative './honker/databases/in_memory.rb'

require_relative './honker/entities/user.rb'
require_relative './honker/entities/honk.rb'

require_relative './honker/scripts/create_honk.rb'
require_relative './honker/scripts/sign_in.rb'
