require 'spec_helper'

module TM
  describe "GetCompletedTasks" do

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
      @task1.finished = true
      @task4.finished = true
      @task3.finished = true
      @proj2 = TM::db.create_project("Maim Sue")
      @task5 = TM::db.create_task({ priority: 1, description: "buy knife", project_id: @proj2.id })
      @emp1 = TM::db.create_employee("Billy")
      @task5.finished = true
      TM::db.assign({ project_id: @project1.id, employee_id: @emp1.id })
      TM::db.assign({ project_id: @proj2.id, employee_id: @emp1.id })
      TM::db.assign({ task_id: @task1.id, employee_id: @emp1.id })
      TM::db.assign({ task_id: @task3.id, employee_id: @emp1.id })
      TM::db.assign({ task_id: @task4.id, employee_id: @emp1.id })
      TM::db.assign({ task_id: @task5.id, employee_id: @emp1.id })
    end


    it "returns an error if employee not found" do
      result = GetCompletedTasks.run({ employee_id: 99 })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:employee_not_found)
    end

    it "returns an error if project not found" do
    end

    it "can return a completed list" do
      result = TM::GetCompletedTasks.run({ employee_id: @emp1.id })
      completed_tasks = result[:completed_tasks]

      expect(completed_tasks.size).to eq(4)
      expect(completed_tasks[0].id).to eq(@task1.id)
      expect(completed_tasks[1].id).to eq(@task3.id)
      expect(completed_tasks[2].id).to eq(@task4.id)
      expect(completed_tasks[3].id).to eq(@task5.id)
    end
  end
end
