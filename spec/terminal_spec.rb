require 'spec_helper'
require 'pry'

describe 'TerminalClient' do
 before(:each) do
    TM::Project.reset_class_variables
    TM::Task.reset_class_variables
    @t = TM::TerminalClient.new
    @t.create_project("Complete this task manager!")
    @t.create_project("Complete this task manager now!")
    @t.add_task(1, 2, "Complete the terminal client")
    allow(Time).to receive(:now).and_return(Time.at(0))
    @t.add_task(1, 1, "Complete the terminal client, NOW")
    allow(Time).to receive(:now).and_return(Time.new)
  end

  it "exists" do
    expect(TM::TerminalClient).to be_a(Class)
  end

  it 'puts projects to the console' do
    @t.list_all_projects
  end

  it 'puts incompleted task to the console' do
    @t.incompleted_task(1)
  end

  it 'shows completed task' do
    @t.complete_task(2)
    @t.history(1)
  end

  it 'shows instructions' do
    @t.run_program
  end

end
