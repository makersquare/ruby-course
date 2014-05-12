require 'spec_helper'
require 'pry-debugger'

describe 'DB' do
  let(:db) { TM.database }
  describe 'Projects' do
    context 'creating a new database' do
      it 'initializes with an empty projects hash' do
        expect(db.projects).to eq ({})
      end

      it 'initializes with 0 projects' do
        expect(db.project_count).to eq (0)
      end
    end

    context 'adding a new project to the database' do

      it 'adds the project data to the projects hash' do
        project_id = db.project_count
        db.create_project( {:name => "Project", :id => project_id, :tasks => []} )
        expect(db.projects).not_to be_empty
      end

      it 'increments the project_count by 1 each time' do
        project_id = db.project_count
        db.create_project( {:name => "Project", :id => project_id, :tasks => []} )
        expect(db.project_count).to eq 1
      end
    end

    context 'finding a project by id' do

      it 'finds the project' do
        project_id = db.project_count
        db.create_project( {:name => "Project", :id => project_id} )
        db.create_project( {:name => "Project", :id => project_id+1} )
        expect(db.show_project(1).name).to eq db.projects[1][:name]
      end
    end

    context 'updating an existing project' do

      it 'updates the existing project name' do
        project_id = db.project_count
        db.create_project( {:name => "Project", :id => project_id} )
        db.update_project(project_id, {:name => "New Project"} )
        expect(db.projects[project_id][:name]).to eq "New Project"
      end
    end

    context 'deleting an existing project' do
      it 'removes a project from the database and returns the project information' do
        project_id = db.project_count
        db.create_project( {:name => "Project", :id => project_id} )
        db.destroy_project(project_id)
        expect(db.projects.length).to eq 0
      end
    end
  end

  describe 'Tasks' do

    context 'when creating a new database' do
      it 'initializes with an empty tasks hash' do
        expect(db.tasks).to eq ({})
      end
      it 'initializes with 0 tasks' do
        expect(db.task_count).to eq 0
      end
    end

    context 'when adding a new task to the database' do
      it 'adds the task to the tasks hash and increments task_count by 1' do
        db.create_task(:task_id => db.task_count, :project_id => 0, :desc => "Description", :priority => 10, :due_date => "2014-05-09")

        expect(db.tasks.length).to eq 1
        expect(db.task_count).to eq 1
      end
    end

    context 'when retrieving a task from the database' do
      it 'retrieves all task information from a task id' do
        db.create_task(:task_id => db.task_count, :project_id => 0, :desc => "Description", :priority => 10, :due_date => "2014-05-09")
        db.create_task(:task_id => db.task_count, :project_id => 0, :desc => "Description 2", :priority => 10, :due_date => "2014-05-10")

        # both tasks should be in the tasks database hash
        expect(db.tasks.length).to eq 2

        # look up both tasks, descriptions should match
        expect(db.show_task(0).description).to eq (db.tasks[0][:desc])
        expect(db.show_task(1).description).to eq (db.tasks[1][:desc])
      end
    end

    context 'when updating an existing task' do
      it 'retrieves the correct task and updates the correct fields' do
        db.create_task(:task_id => db.task_count, :project_id => 0, :desc => "Description", :priority => 10, :due_date => "2014-05-09")
        db.create_task(:task_id => db.task_count, :project_id => 0, :desc => "Description 2", :priority => 10, :due_date => "2014-05-09")

        updated_task = db.update_task(1, {:desc => "New Description", :priority => 4} )

        # Changes the selected tasks
        expect(db.tasks[1][:desc]).to eq ("New Description")
        expect(db.tasks[1][:priority]).to eq (4)

        # Doesn't change other tasks
        expect(db.tasks[0][:desc]).to eq ("Description")

        # Returns a Task object with the correct id
        expect(updated_task).to be_a(TM::Task)
        expect(updated_task.task_id).to eq (1)
      end
    end

    context 'when deleting an existing task' do
      it 'deletes the correct from the task from the database' do
        db.create_task(:task_id => db.task_count, :project_id => 0, :desc => "Description 2", :priority => 10, :due_date => "2014-05-09")
        expect(db.tasks.length).to eq 1
        db.delete_task(0)

        expect(db.tasks.length).to eq 0
      end

      it 'returns the deleted task to the client' do
        db.create_task(:task_id => db.task_count, :project_id => 0, :desc => "Description 2", :priority => 10, :due_date => "2014-05-09")
        deleted_task = db.delete_task(0)

        expect(deleted_task.description).to eq ("Description 2")
      end
    end

  end
end
