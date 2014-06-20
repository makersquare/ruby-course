require 'pry-debugger'
# Require our project, which in turns requires everything else
require './lib/task-manager.rb'

RSpec.configure do |config|
  TM.orm.instance_variable_set(:@db_adaptor, PG.connect(host: 'localhost', dbname: 'task-manager-test') )
end
