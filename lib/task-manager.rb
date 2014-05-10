# # # Create our module. This is so other files can start using it immediately
module TM
  ### Getter ###
  def self.database
    @__db_instance ||= TM::DB.new
  end
end

require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/db.rb'
# require_relative 'task-manager/terminalclient.rb'

# TM::TerminalClient.new
