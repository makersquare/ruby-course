require 'spec_helper'
describe 'DB' do

  it 'exists' do
    expect(TM::DB).to be_a(Class)
  end

  before do
    @__db = TM::DB.new
  end

  describe '.initialize' do
    it 'creates 4 empty hashes' do
      result = @__db.projects
      expect(result).to eq({ })

      result = @__db.tasks
      expect(result).to eq({ })

      result = @__db.employees
      expect(result).to eq({ })

      result = @__db.memberships
      expect(result).to eq([])

    end
  end
  describe '#create_project' do
    it 'adds a project to the projects hash' do
      new_project_name = 'new project'
      added_project =  @__db.create_project(new_project_name)
      expect(@__db.projects[1].project_name).to eq(new_project_name)
    end
  end
  describe '#get_project' do
    it 'grabs and returns the project by the id' do
     created_project = @__db.create_project('new project')
     created_project2 = @__db.create_project('new project 2')
     result = @__db.get_project(created_project.id)

      expect(result).to eq(created_project)

    end
  end

  describe '#add_task_to_project' do
    it 'adds a task to a project' do
      project = @__db.create_project('a new project')
      created_task = @__db.add_task_to_project('a new task', 1, project.id )

      retrieved_task = @__db.get_task(created_task.id)

      expect(retrieved_task).to_not be_nil
      expect(created_task.id).to eq(retrieved_task.id)
      expect(created_task.description).to eq(retrieved_task.description)
    end
  end

  describe '#create_employee' do
    it 'creates a new employee with a name' do
      employee_name = 'bob'
      created_employee = @__db.create_employee(employee_name)
      retrieved_employee = @__db.get_employee(created_employee.id)

      expect(retrieved_employee).to_not be_nil
      expect(created_employee.name).to eq('bob')

    end
  end

  describe '#assign_task' do
    it 'assigns a task to an employee' do
      project = @__db.create_project('a new project')
      created_task = @__db.add_task_to_project('a new task', 1, project.id )
      created_employee = @__db.create_employee('bob')
      assigned_task = @__db.assign_task(created_task.id, created_employee.id)
      expect(assigned_task.eid).to eq(created_employee.id)
      retrieved_employee = @__db.get_employee(assigned_task.eid)
      expect(retrieved_employee).to_not be_nil


    end
  end

  describe '#mark_task_complete' do
    it 'marks a task complete by TID' do
      project = @__db.create_project('a new project')
      created_task = @__db.add_task_to_project('a new task', 1, project.id )
      retrieved_task = @__db.get_task(created_task.id)
      expect(retrieved_task).to_not be_nil
      completed_task =  @__db.mark_task_complete(retrieved_task.id)
      expect(retrieved_task.complete).to eq(true)

    end
  end

  describe '#assign_employee_to_project' do
    it 'assigns an employee to a project' do
      created_project = @__db.create_project('a new project')
      created_employee = @__db.create_employee('bob')
      created_membership = @__db.assign_employee_to_project(created_project.id, created_employee.id)
      retrieved_project_membership = @__db.get_project_membership(created_project.id)
      retrieved_employee_membership = @__db.get_employee_membership(created_employee.id)


      expect(retrieved_project_membership).to_not be_nil
      expect(retrieved_employee_membership).to_not be_nil
      expect(retrieved_project_membership.first).to eq(created_employee.id)
      # expect(created_employee_membership.first).to eq(created_project.id)



    end
  end

  describe '#get_project_membership' do
    it 'retrieves memberships based on project id' do
      created_project = @__db.create_project('a new project')
      created_employee = @__db.create_employee('bob')
      created_employee2 = @__db.create_employee('joe')
      created_membership = @__db.assign_employee_to_project(created_project.id, created_employee.id)
      created_membership2 = @__db.assign_employee_to_project(created_project.id, created_employee2.id)
      retrieved_project_memberships = @__db.get_project_membership(created_project.id)

      expect(retrieved_project_memberships).to_not be_nil
      expect(retrieved_project_memberships.first).to eq(created_employee.id)
      expect(retrieved_project_memberships.last).to eq(created_employee2.id)

    end
  end

  describe '#get_employee_membership' do
    it 'retrieves memberships based on employee id' do
      created_project = @__db.create_project('a new project')
      created_project2 = @__db.create_project('a new project')
      created_employee = @__db.create_employee('bob')
      created_membership = @__db.assign_employee_to_project(created_project.id, created_employee.id)
      created_membership2 = @__db.assign_employee_to_project(created_project2.id, created_employee.id)

      retrieved_employee_memberships = @__db.get_employee_membership(created_employee.id)

      expect(retrieved_employee_memberships).to_not be_nil
      expect(retrieved_employee_memberships.first).to eq(created_project.id)
      expect(retrieved_employee_memberships.last).to eq(created_project2.id)

      project_check = @__db.get_project(retrieved_employee_memberships.first)
      expect(project_check.project_name).to eq('a new project')

    end
  end

  describe '#show_completed_tasks' do
    it 'shows completed tasks for a given project' do
      project = @__db.create_project('a new project')
      created_task = @__db.add_task_to_project('the new task', 1, project.id )
      created_task2 = @__db.add_task_to_project('the newer task', 2, project.id )
      created_task3 = @__db.add_task_to_project('the newest task', 1, project.id )

      completed_task = @__db.mark_task_complete(created_task.id)
      completed_task2 = @__db.mark_task_complete(created_task2.id)

      completed_tasks = @__db.show_completed_tasks(project.id)

      expect(completed_tasks).to_not be_nil
      expect(completed_tasks.count).to eq(2)
      expect(completed_tasks.first.description).to eq('the new task')
      expect(completed_tasks.last.description).to eq('the newer task')

    end
  end

  describe '#show_remaining_tasks' do
    it 'shows the remaining tasks for a given project by pid' do
      project = @__db.create_project('a new project')
      created_task = @__db.add_task_to_project('the new task', 1, project.id )
      created_task2 = @__db.add_task_to_project('the newer task', 2, project.id )
      created_task3 = @__db.add_task_to_project('the newest task', 1, project.id )
      completed_task = @__db.mark_task_complete(created_task.id)

      remaining_tasks = @__db.show_remaining_tasks(project.id)

      expect(remaining_tasks).to_not be_nil
      expect(remaining_tasks.first.description).to eq('the newer task')
      expect(remaining_tasks.last.description).to eq('the newest task')

    end
  end

  describe '#list_employees' do
    it 'returns a list of all employees' do
      created_employee = @__db.create_employee('bob')
      created_employee2 = @__db.create_employee('joe')
      created_employee2 = @__db.create_employee('greg')
      employees = @__db.list_employees

      expect(employees).to_not be_nil
      expect(employees.first.name).to eq('bob')
      expect(employees.last.name).to eq('greg')
    end
  end

  describe '#get_employee_projects' do
    it 'returns a list of projects the employee is participating in' do
      created_project = @__db.create_project('a new project')
      created_project2 = @__db.create_project('a newer project')
      created_employee = @__db.create_employee('bob')
      created_membership = @__db.assign_employee_to_project(created_project.id, created_employee.id)
      created_membership2 = @__db.assign_employee_to_project(created_project2.id, created_employee.id)

      retrieved_employee_memberships = @__db.get_employee_membership(created_employee.id)

      project_list = @__db.get_employee_projects(created_employee.id)

      expect(project_list.first.project_name).to_not eq('mow the lawn')
      expect(project_list.last.project_name).to eq('a newer project')

    end
  end

  describe '#show_remaining_employee_tasks' do
    it 'Show all remaining tasks assigned to employee EID' do
      created_project = @__db.create_project('a new project')
      created_project2 = @__db.create_project('a newer project')

      created_task = @__db.add_task_to_project('the new task', 1, created_project.id )
      created_task2 = @__db.add_task_to_project('the newer task', 2, created_project.id )
      created_task3 = @__db.add_task_to_project('the newest task', 1, created_project2.id )

      created_employee = @__db.create_employee('bob')

      assigned_task1 = @__db.assign_task(created_task.id, created_employee.id)
      assigned_task2 = @__db.assign_task(created_task3.id, created_employee.id)

      result = @__db.show_remaining_employee_tasks(created_employee.id)
      expect(result.first.description).to eq('the new task')
      expect(result.last.description).to eq('the newest task')
    end
  end

  describe '#show_completed_employee_tasks' do
    it 'shows all completed tasks for an employee' do
      created_project = @__db.create_project('a new project')
      created_project2 = @__db.create_project('a newer project')

      created_task = @__db.add_task_to_project('the new task', 1, created_project.id )
      created_task2 = @__db.add_task_to_project('the newer task', 2, created_project.id )
      created_task3 = @__db.add_task_to_project('the newest task', 1, created_project2.id )

      created_employee = @__db.create_employee('bob')

      assigned_task1 = @__db.assign_task(created_task.id, created_employee.id)
      assigned_task2 = @__db.assign_task(created_task3.id, created_employee.id)

      completed_task1 = @__db.mark_task_complete(created_task.id)
      completed_task2 = @__db.mark_task_complete(created_task3.id)

      result = @__db.show_completed_employee_tasks(created_employee.id)
      expect(result.first.description).to eq('the new task')
      expect(result.last.description).to eq('the newest task')

    end
  end



end
