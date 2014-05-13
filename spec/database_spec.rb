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
    db.create_task(name: 'pancake', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    expect(db.tasks.length).to eq(1)
    p db.tasks
  end

  it 'gets task given task id' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_task(name: 'pancake', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    test_task = db.get_task(0)
    expect(test_task.name).to eq('pancake')
  end

  it 'updates a task given a task' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_task(name: 'pancake', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    test_task = db.get_task(0)
    test_task.status = 'complete'
    p db.tasks
    db.update_task(test_task)
    p db.tasks
    expect(test_task.status).to eq('complete')
  end

  it 'deletes task given task id' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_task(name: 'pancake', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'waffle', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'eggs', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.destroy_task(1)
    p db.tasks
    expect(db.tasks.length).to eq(2)
  end

  it 'gets all tasks associated with a project given project id' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_task(name: 'pancake', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'waffle', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'eggs', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    test_tasks = db.get_all_tasks_for_project(0)
    p test_tasks
    expect(test_tasks.length).to eq(3)
  end

  it 'gets all inconplete tasks associated with a given project id' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_task(name: 'pancake', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'waffle', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'eggs', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    test_task = db.get_task(0)
    test_task.status = 'complete'
    db.update_task(test_task)
    incomp_test_task = db.get_all_incomplete_tasks_for_project(0)
    p incomp_test_task
    expect(incomp_test_task.length).to eq(2)
  end

  it 'gets all completed tasks associated with a given project id' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_task(name: 'pancake', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'waffle', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'eggs', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    test_task = db.get_task(0)
    test_task.status = 'complete'
    db.update_task(test_task)
    comp_task_test = db.get_all_completed_tasks_for_project(0)
    p comp_task_test
    expect(comp_task_test.length).to eq(1)
  end

  it 'creates employee given hash' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_task(name: 'pancake', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'waffle', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'eggs', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    test_task = db.get_task(0)
    test_task.status = 'complete'
    db.update_task(test_task)
    db.create_employee(name: 'john jay')
    expect(db.employees.length).to eq(1)
  end

  it 'gets the employee given the id' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_task(name: 'pancake', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'waffle', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'eggs', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    test_task = db.get_task(0)
    test_task.status = 'complete'
    db.update_task(test_task)
    db.create_employee(name: 'john jay')
    test_employee = db.get_employee(0)
    p test_employee
    expect(test_employee.name).to eq('john jay')
  end

  it 'updates employee given employee' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_task(name: 'pancake', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'waffle', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'eggs', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    test_task = db.get_task(0)
    test_task.status = 'complete'
    db.update_task(test_task)
    db.create_employee(name: 'john jay')
    test_employee = db.get_employee(0)
    p test_employee
    test_employee.name = 'Rich'
    p test_employee
    db.update_employee(test_employee)
    p db.employees
    expect(db.employees[0][:name]).to eq('Rich')
  end

  it 'destroys employee given id' do
    db = TM::DB.new
    db.create_project(name: 'test')
    db.create_task(name: 'pancake', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'waffle', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    db.create_task(name: 'eggs', project_id: 0, description: "learn to pan the cake", status: 'incomplete', priority: 12, due_date: "Oct 1,2014")
    test_task = db.get_task(0)
    test_task.status = 'complete'
    db.update_task(test_task)
    db.create_employee(name: 'john jay')
    test_employee = db.get_employee(0)
    db.destroy_employee(test_employee.id)
    expect(db.employees.length).to eq(0)
  end

end
