# Require our project, which in turns requires everything else
require './lib/task-manager.rb'
require 'pry-debugger'
require 'rspec/expectations'

RSpec::Matchers.define :be_sorted_by do |expected|
  match do |actual|
    actual % expected == 0
  end
end