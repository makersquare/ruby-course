describe TM::ShowRemainingEmployeeTasks do
  it 'returns all incomplete tasks assigned to an employee' do
      created_project = TM.db.create_project('a new project')
      created_project2 = TM.db.create_project('a newer project')

      created_task = TM.db.add_task_to_project('the new task', 1, created_project.id )
      created_task2 = TM.db.add_task_to_project('the newer task', 2, created_project.id )
      created_task3 = TM.db.add_task_to_project('the newest task', 1, created_project2.id )

      created_employee = TM.db.create_employee('bob')

      assigned_task1 = TM.db.assign_task(created_task.id, created_employee.id)
      assigned_task2 = TM.db.assign_task(created_task3.id, created_employee.id)

      results = subject.run(eid: created_employee.id)

      expect(results.remaining_tasks.last.description).to eq('the newest task')
      expect(results.associated_projects.last.project_name).to eq('a newer project')

  end
end
