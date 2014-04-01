require 'spec_helper'

module TM
  describe "GetOngoingTasks" do

    before do
      @project1 = TM::db.create_project("Maim Bob")
      @task1 = TM::db.create_task({project_id: @project1.id,
                                   description: "Buy gun",
                                   priority: 7 })
      @task2 = TM::db.create_task({project_id: @project1.id,
                                   description: "Load gun",
                                   priority: 7})
      @task3 = TM::db.create_task({project_id: @project1.id,
                                     description: "Buy Beer",
                                     priority: 4})
      @task4 = TM::db.create_task({project_id: @project1.id,
                                    desription: "Drink Beer",
                                    priority: 10})
      @task2.finished = true
      @proj2 = TM::db.create_project("Maim Sue")
      @task5 = TM::db.create_task({ priority: 1, description: "buy knife", project_id: @proj2.id })
      @task5.finished = true
      @emp1 = TM::db.create_employee("Billy")
      TM::db.assign({ project_id: @project1.id, employee_id: @emp1.id })
      TM::db.assign({ project_id: @proj2.id, employee_id: @emp1.id })
      TM::db.assign({ task_id: @task1.id, employee_id: @emp1.id })
      TM::db.assign({ task_id: @task3.id, employee_id: @emp1.id })
      TM::db.assign({ task_id: @task4.id, employee_id: @emp1.id })
      TM::db.assign({ task_id: @task5.id, employee_id: @emp1.id })
    end

    it "returns an error if employee not found" do
      result = GetOngoingTasks.run({ employee_id: 99 })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:employee_not_found)
    end

    it "returns an error if project not found" do
      result = GetOngoingTasks.run({ project_id: 99 })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:project_not_found)
    end

    it "can return a completed list for an employee" do
      result = TM::GetOngoingTasks.run({ employee_id: @emp1.id })
      ongoing_tasks = result[:ongoing_tasks]
      expect(ongoing_tasks.size).to eq(3)
    end

    it "can return a completed list for a project" do
      result = TM::GetOngoingTasks.run({ project_id: @project1.id })
      ongoing_tasks = result[:ongoing_tasks]
      expect(ongoing_tasks.size).to eq(3)
    end


  end
end
