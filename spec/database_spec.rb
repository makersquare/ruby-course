require 'spec_helper'
require 'pry-debugger'
require 'date'

describe TM::DB do
  it "creates project given hash" do
    db = TM::DB.new
    db.create_project(name: 'test')
    expect(db.projects.length).to eq(1)
  end

  it 'gets a project from the database given project_id' do
    db = TM::DB.new
    db.create_project(name: 'test')
    test = db.get_project(0)
    expect(test.id).to eq(0)
  end

  it 'updates a project given a project' do
    db = TM::DB.new
    db.create_project(name: 'test')
    test = db.get_project(0)
    test.name = 'pug'
    db.update_project(test)
    p db.projects
    expect(test.name).to eq('pug')
  end

  it 'deletes project given a project id' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_project(name: 'dog')
    db.create_project(name: 'harper')
    db.destroy_project(1)
    p db.projects
    expect(db.projects.length).to eq(2)
  end

  it 'creates task given hash' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_task(name: 'pancake', project_id: 0, descripton: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    expect(db.tasks.length).to eq(1)
    p db.tasks
  end

  it 'gets task given task id' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_task(name: 'pancake', project_id: 0, descripton: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    test_task = db.get_task(0)
    expect(test_task.name).to eq('pancake')
  end

  it 'updates a task given a task' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_task(name: 'pancake', project_id: 0, descripton: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    test_task = db.get_task(0)
    test_task.status = 'complete'
    p db.tasks
    db.update_task(test_task)
    p db.tasks
    expect(test_task.status).to eq('complete')
  end

end
