require 'spec_helper'
require 'pry'

describe 'TerminalClient' do
 before(:each) do
    TM::Project.reset_class_variables
    TM::Task.reset_class_variables
    @project_1 = TM::Project.new("Complete this task manager")
    @project_2 = TM::Project.new("Complete this task manager NOW")
    @projects_manager = TM::ProjectsManager.new
    @terminal = TM::TerminalClient.new
  end

  it "exists" do
    expect(TM::TerminalClient).to be_a(Class)
  end
end
