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
        db.create_project( {:name => "Project", :id => project_id} )
        expect(db.projects).not_to be_empty
      end

      it 'increments the project_count by 1 each time' do
        project_id = db.project_count
        db.create_project( {:name => "Project", :id => project_id} )
        expect(db.project_count).to eq 1
      end
    end

    context 'finding a project by id' do

      it 'finds the project' do
        project_id = db.project_count
        db.create_project( {:name => "Project", :id => project_id} )
        db.create_project( {:name => "Project", :id => project_id+1} )
        project = db.projects.select {|key,value| key == 1}
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
        db.create_task(:project_id => 0, :desc => "Description", :priority => 10, :due_date => "2014-05-09")

        expect(db.tasks.length).to eq 1
        expect(db.task_count).to eq 1
      end
    end

  end
end
