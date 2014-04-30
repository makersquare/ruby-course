require 'spec_helper'
require 'pry-debugger'

describe 'TerminalClient' do
  # before(:each) do
  #   @x = TM::TerminalClient.new
  # end

  it "exists" do
    expect(TM::TerminalClient).to be_a(Class)
  end

  it "lists all projects" do
    TM::Project.reset_class_variables
    @project1 = TM::Project.new("Grades")
    @project2 = TM::Project.new("Tests")
    x = TM::TerminalClient.new
  end
end
