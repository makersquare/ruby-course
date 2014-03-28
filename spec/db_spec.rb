require 'spec_helper'

module TM

  describe "Database" do

    before do
      TM::Project.class_variable_set :@@project_id, 15

      @db = TM.db
      @proj = @db.add_project('project 1')

    end

    it 'exists' do
      expect(TM::Database).to be_a(Class)
    end

    it 'can add a project' do
      proj_id = @proj.project_id
      expect(@db.projects[proj_id].name).to eq(@proj.name)
    end

    it 'can get a project' do

      expect(@db.get_project[new_proj.id].name).to eq(@proj.name)
    end

    it 'can add a task' do
      task = @db.create_task(@proj.project_id, 'just do it')
      expect(@db.tasks(1).task_id).to eq(task.task_id)
    end

    it 'can mark a task completed' do
      task1 = @db.create_task(@proj.project_id, 'just do it')
      task2 = @db.create_task(@proj.project_id, 'just do it2')
      task3 = @db.create_task(@proj.project_id, 'just do it3')

      @db.mark_complete(@proj.project_id, task1.task_id )
      expect(@db.tasks(1).status).to eq('complete')
    end

    it 'can get completed tasks' do
      task1 = @db.create_task(@proj.project_id, 'just do it')
      task2 = @db.create_task(@proj.project_id, 'just do it2')
      task3 = @db.create_task(@proj.project_id, 'just do it3')

      @db.mark_complete(@proj.project_id, task1.task_id )
      @db.mark_complete(@proj.project_id, task2.task_id )

      expect(@db.get_completed(@proj.project_id)).to include(task1)
    end

    it 'it can get incomplete task' do
      task1 = @db.create_task(@proj.project_id, 'just do it')
      task2 = @db.create_task(@proj.project_id, 'just do it2')
      task3 = @db.create_task(@proj.project_id, 'just do it3')

      @db.mark_complete(@proj.project_id, task1.task_id )
      @db.mark_complete(@proj.project_id, task2.task_id )

      expect(@db.get_incompleted(@proj.project_id)).to include(task3)
    end

    it 'can add a employee' do
      emp = @db.add_employee('bob')
      eid = emp.employee_id

      expect(@db.employees[eid].name).to eq('bob')

    end

    it 'can assign a employee to a project' do


    end


  end


end
