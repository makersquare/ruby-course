require 'ostruct'
require 'require_all'
# Create our module. This is so other files can start using it immediately
module TM
  def self.db
      @db ||= TM::DB.new
  end
end


require_rel 'task-manager/*.rb'
require_rel 'usecase/*.rb'

require 'pry-debugger'



