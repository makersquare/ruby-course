require 'pry-debugger'
require 'spec_helper'

describe 'Task' do

  before(:each) do
    TM.orm.instance_variable_set(:@db_adaptor, PG.connect(host: 'localhost', dbname: 'task-manager-test') )
    TM.orm.delete_tables
    TM.orm.add_tables
  end

  before(:each) do
    TM.orm.delete_tables
    TM.orm.add_tables
  end

  after(:all) do
    TM.orm.delete_tables
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "creates a new task with a project id, description, and priority number" do
    proj1 = TM.orm.add_project('proj1')
    emp1 = TM.orm.add_employee('name1')
    task = TM.orm.add_task(1,'something to do', 1)

    expect(task.description).to eq('something to do')
    expect(task.priority).to eq('1')
    expect(task.eid).to eq('1')
    expect(task.status).to eq('incomplete')
  end

  it "can be marked as complete, specified by id" do
    proj1 = TM.orm.add_project('proj1')
    emp1 = TM.orm.add_employee('name1')
    task = TM.orm.add_task(1,'something to do', 1)

    task.update_complete

    expect(task.status).to eq('complete')
  end
end
