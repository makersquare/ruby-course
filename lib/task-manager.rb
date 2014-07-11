# Create our module. This is so other files can start using it immediately
module TM
  def self.db
    @__db_instance ||= TM::DB.new
  end
end

# Require all gems
require 'pg'
require 'pry-debugger'

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/term_emulator.rb'
require_relative 'task-manager/db.rb'

TM::Terminal.call
