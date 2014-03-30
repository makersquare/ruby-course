require 'spec_helper'

describe 'DB' do
  it 'exists' do
    expect(TM::DB).to be_a(Class)
  end

  before do
    @__db = TM::DB.new
  end

  describe 'initialize' do
    it 'has 4 hashes initialized for project, task, id, members' do
      expect(@__db.projects).to eq ({})
      expect(@__db.tasks).to eq ({})
      expect(@__db.employees).to eq ({})
      expect(@__db.memberships).to eq ([])
    end
  end

  describe 'creates a new project and stores in the database' do
    it 'creates a new project' do
      @__db.create_project('project_name')
      expect(@__db.projects[1].name).to eq('project_name')
    end
  end

  describe 'get Project by pid' do
    it 'returns a project object based on the pid' do
      new_project = @__db.create_project('project_name')
      result = @__db.get_project(2)
      expect(result).to eq new_project
    end
  end

# context 'requires a task assigned to a project' do
    # before do
    #   @project = TM::Project.new('project_name')
    # end

  describe 'add_task_to_project' do
    it "adds a task to project" do
      project = TM::Project.new('project_name')
      task = @__db.add_task_to_project('description', 1, project.id)
      task2 = @__db.get_task(task.id)
      expect(task2).to_not be_nil
      expect(task2.description).to eq 'description'
    end
  end

  describe 'create a new employee' do
    it 'creates a new employee with a name' do
      emp = @__db.create_employee('bob')
      emp2 = @__db.get_employee(emp.id)
      expect(emp2).to_not be_nil
      expect(emp2.name).to eq 'bob'
    end
  end

  describe 'assign task' do
    it 'assigns a task to an employee' do
      project = TM::Project.new('project_name')
      emp = @__db.create_employee('bob')
      task = @__db.add_task_to_project('description', 1, project.id)

      assigned_task = @__db.assign_task(task.id, emp.id)

      expect(assigned_task.eid).to eq emp.id

      emp2 = @__db.get_employee(assigned_task.eid)
      expect(emp2).to_not be_nil
    end
  end

  describe 'complete' do
    it 'marks a task complete by id' do
      project = TM::Project.new('project_name')
      task = @__db.add_task_to_project('description', 1, project.id)
      completed_task = @__db.task_complete(task.id)
      expect(task.complete).to eq true

    end
  end

# context 'create project, emp, assigns emp to proj' do
#   before do

#   end
  describe 'gets memberships proj and emp' do
    it 'returns array of eids for pid' do
      project = @__db.create_project('project_name')
      emp = @__db.create_employee('bob')
      mem = @__db.assign_emp_to_project(emp.id, project.id)
      # binding.pry
      retrieved_proj_mem = @__db.get_project_membership(project.id)
      expect(retrieved_proj_mem).to_not be_nil
      expect(retrieved_proj_mem.first).to eq emp.id
    end

    it 'returns array of pids for eid' do
      project = @__db.create_project('project_name')
      emp = @__db.create_employee('bob')
      mem = @__db.assign_emp_to_project(emp.id, project.id)

      retrieved_emp_mem = @__db.get_emp_membership(emp.id)
      expect(retrieved_emp_mem).to_not be_nil
      expect(retrieved_emp_mem.first).to eq project.id
    end
  end

  describe 'assigns employee to project' do
    it 'adds employee to project in memberships' do
      project = @__db.create_project('project_name')
      emp = @__db.create_employee('bob')
      mem = @__db.assign_emp_to_project(emp.id, project.id)

      retrieved_proj_mem = @__db.get_project_membership(project.id)
      retrieved_emp_mem = @__db.get_emp_membership(emp.id)

      expect(retrieved_proj_mem).to_not be_nil
      expect(retrieved_emp_mem).to_not be_nil
      expect(retrieved_proj_mem.first).to eq emp.id
      expect(retrieved_emp_mem.first).to eq project.id
    end
  end

  describe 'shows completed tasks' do
    it 'returns an array of completed task objects given pid' do
      project = @__db.create_project('project_name')
      task = @__db.add_task_to_project('description', 1, project.id)
      task2 = @__db.add_task_to_project('description2', 2, project.id)
      completed_task = @__db.task_complete(task.id)
      completed = @__db.show_completed_tasks(project.id)
      expect(completed.count).to eq 1
      expect(completed.first.priority).to eq 1
    end
  end

  describe 'show projects by eid' do
    it 'lists all projects by eid' do
      project = @__db.create_project('project_name')
      project2 = @__db.create_project('project2_name')
      emp = @__db.create_employee('bob')
      @__db.assign_emp_to_project(emp.id, project.id)
      mem2 = @__db.assign_emp_to_project(emp.id, project2.id)
      projects = @__db.get_employee_project(emp.id)

      expect(projects.first).to eq project
      expect(projects.last).to eq project2
    end
  end

  describe 'remaining tasks by eid' do
    it 'lists all remaining tasks by eid and the project name ' do
      project = @__db.create_project('project_name')
      project2 = @__db.create_project('project2_name')
      task = @__db.add_task_to_project('description', 1, project.id)
      task2 = @__db.add_task_to_project('description2', 2, project.id)
      task3 = @__db.add_task_to_project('description3', 2, project2.id)
      emp = @__db.create_employee('bob')

      assigned_task = @__db.assign_task(task.id, emp.id)
      # completed_task = @__db.task_complete(task.id)
      assigned_task3 = @__db.assign_task(task3.id, emp.id)

      remaining_tasks = @__db.remaining_employee_tasks(emp.id)
      expect(remaining_tasks).to_not be_nil
      expect(remaining_tasks.count).to eq 2
      expect(remaining_tasks.first).to eq([12,13])
      expect(remaining_tasks.last).to eq(['project_name', 'project2_name'])
    end
  end

  describe 'shows remaining tasks' do
    it 'returns an array of remaining task objects given pid' do
      project = @__db.create_project('project_name')
      task = @__db.add_task_to_project('description', 1, project.id)
      task2 = @__db.add_task_to_project('description2', 2, project.id)
      completed_task = @__db.task_complete(task.id)
      remaining_tasks = @__db.show_remaining_tasks(project.id)
      expect(remaining_tasks.count).to eq 1
      expect(remaining_tasks.first.priority).to eq 2
    end
  end
end

# end
