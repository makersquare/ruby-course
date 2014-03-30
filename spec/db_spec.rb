require 'spec_helper'

module TM

  describe 'database' do
    before do
        @project1 = TM.db.create_project("Maim Bob")
        @task1 = TM.db.create_task({project_id: @project1.id,
                                   description: "Buy gun",
                                   priority: 7 })
       @task2 = TM.db.create_task({project_id: @project1.id,
                                   description: "Load gun",
                                   priority: 7})
        @task3 = TM.db.create_task({project_id: @project1.id,
                                     description: "Buy Beer",
                                     priority: 4})
        @task4 = TM.db.create_task({project_id: @project1.id,
                                    desription: "Drink Beer",
                                    priority: 10})
    end

    it "can create and get a project" do
      expect(TM.db.get_project(@project1.id)).to eq(@project1)
    end

    it "can create and get a task" do
      expect(TM.db.get_task(@task1.id)).to eq(@task1)
    end

    it "can return a list of all completed tasks sorted by creation_date" do
      @task1.finished = true
      @task4.finished = true
      @task3.finished = true
      completed_tasks = TM.db.completed_tasks(@project1.id)
      expect(completed_tasks.size).to eq(3)
      expect(completed_tasks[0].id).to eq(@task1.id)
      expect(completed_tasks[1].id).to eq(@task3.id)
      expect(completed_tasks[2].id).to eq(@task4.id)
    end

    it "can return a list of all ongoing tasks sorted by priority, then creation date" do
      @task3.finished = true
      ongoing = TM.db.ongoing_tasks(@project1.id)
      expect(ongoing.size).to eq(3)
      expect(ongoing[0].id).to eq(@task4.id)
      expect(ongoing[1].id).to eq(@task2.id)
      expect(ongoing[2].id).to eq(@task1.id)
    end

    before do
      @emp1 = TM.db.create_employee("Bob")
      @emp2 = TM.db.create_employee("Sue")
      @emp3 = TM.db.create_employee("Billy")
    end

    it "can create an employee and store it in the master list" do
      #emp1 = TM.db.create_employee("Bob")
      expect(TM.db.get_employee(@emp1.id).id).to eq(@emp1.id)
    end

    it "can assign multiple employees to a single project" do
      #emp1 = TM.db.create_employee("Bob")
      #emp2 = TM.db.create_employee("Sue")
      #emp3 = TM.db.create_employee("Billy")
      TM.db.assign({ employee_id: @emp1.id, project_id: @project1.id })
      TM.db.assign({ employee_id: @emp3.id, project_id: @project1.id })
      expect(TM.db.assigned?({ project_id: @project1.id, employee_id: @emp1.id })).to eq(true)
      expect(TM.db.assigned?({ project_id: @project1.id, employee_id: @emp3.id })).to eq(true)
      expect(TM.db.assigned?({ project_id: @project1.id, employee_id: @emp2.id })).to eq(false)
    end

    it "can assign a task to an employee only if the emp is assigned to the tasks project" do
      TM.db.assign({employee_id: @emp1.id, project_id: @project1.id})
      assign1 = TM.db.assign({ task_id: @task1.id, employee_id: @emp1.id })
      assign2 = TM.db.assign({ task_id: @task2.id, employee_id: @emp2.id })
      expect(assign1).to eq(true)
      expect(assign2).to eq(false)
      expect(TM::db.assigned?({ task_id: @task1.id, employee_id: @emp1.id })).to eq(true)
      expect(TM::db.assigned?({ task_id: @task2.id, employee_id: @emp2.id })).to eq(false)
    end



  end
end
