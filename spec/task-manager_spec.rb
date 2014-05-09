require 'spec_helper'
require 'pry'

describe "TaskManager::Database" do

  before(:each) do
    @database = TM::Database.new
    @db = TM.db
  end

  it 'exist' do
    expect(TM::Database).to be_a(Class)
  end

  context 'it is initialized' do

    it 'creates an empty projects hash' do

      expect(@db.projects).to eq({})
    end

    it 'creates an empty task hash' do
      expect(@db.task).to eq({})
    end

    it 'has a projects counter' do
      expect(@db.projects_counter).to eq(0)
    end

    it 'has a task counter' do
      expect(@db.task_counter).to eq(0)
    end

  end

  context 'a new project is added to the datebase' do
    let(:new_project) { @db.create_project({:name => "Pizza Party Planning"}) }

    it 'can add new projects' do
      new_project
      expect(@db.projects).to eq({1 => {:name => "Pizza Party Planning", :id => 1}})
      expect(@db.projects_counter).to eq(1)
    end

    it 'can return a hash of a created project' do
      new_project
      expect(@db.get_project(1)).to eq({:name => "Pizza Party Planning", :id => 1})
    end

  end

end
