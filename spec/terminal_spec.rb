require 'spec_helper'
require 'pry-debugger'

describe 'TM::TerminalClient' do

  before(:each) do
    # $stdout = StringIO.new
    # TM::Project.reset_class_variables
    # TM::Task.reset_class_variables
    # project = TM::Project.new('Project 1')
    # project2 = TM::Project.new('Project 2')
    # project3 = TM::Project.new('Project 3')
  end

  describe 'list' do
    it "should list all of the projects" do
    end
  end

  after(:all) do
    $stdout = STDOUT
  end
end
