require 'spec_helper'

module TM

  describe 'database' do
    before do
        @db1 = TM::DB.new
        @project1 = @db1.create_project("Maim Bob")
        @task1 = @db1.create_task({project_id: @project1.id,
                                   description: "Buy gun",
                                   priority: 7 })
        @task2 = @db1.create_task({project_id: @project1.id,
                                   description: "Load gun",
                                   priority: 7})
        @task3 = @db1.create_task({project_id: @project1.id,
                                     description: "Buy Beer",
                                     priority: 4})
        @task4 = @db1.create_task({project_id: @project1.id,
                                    desription: "Drink Beer",
                                    priority: 10})
    end

    it "can create and get a project" do
      expect(@db1.get_project(@project1.id)).to eq(@project1)
    end

    it "can create and get a task" do
      expect(@db1.get_task(@task1.id)).to eq(@task1)
    end

    it "can return a list of all completed tasks on a project sorted by creation_date" do
      @task1.finished = true
      @task4.finished = true
      @task3.finished = true
      completed_tasks = @db1.completed_tasks({ project_id: @project1.id })
      expect(completed_tasks.size).to eq(3)
      expect(completed_tasks[0].id).to eq(@task1.id)
      expect(completed_tasks[1].id).to eq(@task3.id)
      expect(completed_tasks[2].id).to eq(@task4.id)
    end

    it "can return a list of all completed tasks for an employee" do
      @task1.finished = true
      @task4.finished = true
      @task3.finished = true
      proj2 = @db1.create_project("Maim Sue")
      task5 = @db1.create_task({ priority: 1, description: "buy knife", project_id: proj2.id })
      emp1 = @db1.create_employee("Billy")
      task5.finished = true
      @db1.assign({ project_id: @project1.id, employee_id: emp1.id })
      @db1.assign({ project_id: proj2.id, employee_id: emp1.id })
      @db1.assign({ task_id: @task1.id, employee_id: emp1.id })
      @db1.assign({ task_id: @task3.id, employee_id: emp1.id })
      @db1.assign({ task_id: @task4.id, employee_id: emp1.id })
      @db1.assign({ task_id: task5.id, employee_id: emp1.id })
      completed_tasks = @db1.completed_tasks({ employee_id: emp1.id })

      expect(completed_tasks.size).to eq(4)
      expect(completed_tasks[0].id).to eq(@task1.id)
      expect(completed_tasks[1].id).to eq(@task3.id)
      expect(completed_tasks[2].id).to eq(@task4.id)
      expect(completed_tasks[3].id).to eq(task5.id)
    end

    it "can return a list of all ongoing tasks sorted by priority, then creation date" do
      @task3.finished = true
      ongoing = @db1.ongoing_tasks(@project1.id)
      expect(ongoing.size).to eq(3)
      expect(ongoing[0].id).to eq(@task4.id)
      expect(ongoing[1].id).to eq(@task2.id)
      expect(ongoing[2].id).to eq(@task1.id)
    end

    before do
      @emp1 = @db1.create_employee("Bob")
      @emp2 = @db1.create_employee("Sue")
      @emp3 = @db1.create_employee("Billy")
    end

    it "can create an employee and store it in the master list" do
      #emp1 = @db1.create_employee("Bob")
      expect(@db1.get_employee(@emp1.id).id).to eq(@emp1.id)
    end

    it "can assign multiple employees to a single project" do
      #emp1 = @db1.create_employee("Bob")
      #emp2 = @db1.create_employee("Sue")
      #emp3 = @db1.create_employee("Billy")
      @db1.assign({ employee_id: @emp1.id, project_id: @project1.id })
      @db1.assign({ employee_id: @emp3.id, project_id: @project1.id })
      expect(@db1.assigned?({ project_id: @project1.id, employee_id: @emp1.id })).to eq(true)
      expect(@db1.assigned?({ project_id: @project1.id, employee_id: @emp3.id })).to eq(true)
      expect(@db1.assigned?({ project_id: @project1.id, employee_id: @emp2.id })).to eq(false)
    end

    it "can assign a task to an employee only if the emp is assigned to the tasks project" do
      @db1.assign({employee_id: @emp1.id, project_id: @project1.id})
      assign1 = @db1.assign({ task_id: @task1.id, employee_id: @emp1.id })
      assign2 = @db1.assign({ task_id: @task2.id, employee_id: @emp2.id })
      expect(assign1).to eq(true)
      expect(assign2).to eq(false)
      expect(@db1.assigned?({ task_id: @task1.id, employee_id: @emp1.id })).to eq(true)
      expect(@db1.assigned?({ task_id: @task2.id, employee_id: @emp2.id })).to eq(false)
    end

    it "can return a list of projects in order by id" do
      project2 = @db1.create_project("Maim Sue")
      project3 = @db1.create_project("Maim Billy")
      project4 = @db1.create_project("Injure Sam")
      expect(@db1.list_projects.length).to eq(4)
      expect(@db1.list_projects[0][0]).to eq(@project1.id)
      expect(@db1.list_projects[3][0]).to eq(project4.id)
    end

  end
end
