require 'spec_helper'

describe 'Database class' do

  # get this to work eventually! takes place of before each for this case
  # let(:db) {TM.db}

  describe 'initialize method' do
    # db = TM::DB.new
    # puts TM::DB.projects.inspect
    it "should have empty projects hash" do 
      expect(TM.db.projects.size).to eq(0)
      expect(TM.db.projects.class).to eq(Hash)
    end
    
    it "project_count_should be zero" do 
      expect(TM.db.project_count).to eq(0)
    end

    it "can't create more than 1 instance" do
      # puts db.object_id
      # db2 = TM::DB.new
      # puts db2.object_id
      expect(TM.db.object_id == TM.db.object_id).to eq(true)
    end

  end

  describe 'build_project method' do
    it "return a Project object" do 
      db = TM::DB.new
      data = { name: "Twitter", id: 1}
      project1 = db.build_project(data)

      expect(project1.class).to eq(TM::Project)
      expect(project1.name).to eq("Twitter")
      expect(project1.id).to eq(1)
    end
  end

  describe 'create_project method' do
    it "increments @project_count" do 
      db = TM::DB.new
      data = { name: "test", id: 1}
      db.create_project(data)
      expect(db.projects.size).to eq(1)
      # puts db.projects.inspect
      expect(db.project_count).to eq(1)
      expect(db.projects[1][:id]).to eq(1)
      expect(db.projects[1][:name]).to eq("test")
    end

    ## add test to see if create project from data with just name, no id
    
    it "can create more than 1 project correctly" do 
      db = TM::DB.new

      data = { name: "test", id: 1}
      project1 = db.create_project(data)
      expect(project1.class).to eq(TM::Project)
      expect(db.projects.size).to eq(1)
      expect(db.project_count).to eq(1)

      data = { name: "hello", id: 2 }
      project2 = db.create_project(data)
      expect(project2.class).to eq(TM::Project)
      expect(db.projects.size).to eq(2)
      expect(db.project_count).to eq(2)

      expect(db.projects[1][:id]).to eq(1)
      expect(db.projects[1][:name]).to eq("test")

      expect(db.projects[2][:id]).to eq(2)
      expect(db.projects[2][:name]).to eq("hello")
    end

    it "returns nil and doesn't affect @projects if id already exists" do 
      db = TM::DB.new

      data = { name: "test", id: 1}
      project1 = db.create_project(data)
      expect(project1.class).to eq(TM::Project)
      expect(db.projects.size).to eq(1)
      expect(db.project_count).to eq(1)

      data = { name: "hello", id: 1 }
      project2 = db.create_project(data)
      expect(project2).to eq(nil)

      expect(db.projects.size).to eq(1)
      expect(db.project_count).to eq(1)

      expect(db.projects[1][:id]).to eq(1)
      expect(db.projects[1][:name]).to eq("test")
    end

  end
  
  describe 'get_project method' do
    it "return nil if no projects" do 
      db = TM::DB.new
      project1 = db.get_project(1)
      expect(project1).to eq(nil)
    end

    it "return the correct project as a Project object" do 
      db = TM::DB.new
      data = { name: "Twitter", id: 1}
      db.create_project(data)

      data = { name: "Facebook", id: 2}
      db.create_project(data)
      expect(db.projects.size).to eq(2)

      project1 = db.get_project(1)
      project2 = db.get_project(2)
      expect(project1.class).to eq(TM::Project)
      expect(project1.name).to eq("Twitter")
      expect(project1.id).to eq(1)
      expect(project2.class).to eq(TM::Project)
      expect(project2.name).to eq("Facebook")
      expect(project2.id).to eq(2)
    end

  end
  
  describe 'destroy_project method' do
    it "return nil if no projects exist" do 
      db = TM::DB.new
      project1 = db.destroy_project(1)
      expect(project1).to eq(nil)
      expect(db.projects.size).to eq(0)      
    end

    it "delete the correct object and reduce size" do 
      db = TM::DB.new
      data = { name: "Twitter", id: 1}
      db.create_project(data)

      data = { name: "Facebook", id: 2}
      db.create_project(data)

      expect(db.projects.size).to eq(2)

      db.destroy_project(1)

      expect(db.projects.size).to eq(1)
      expect(db.projects[1]).to eq(nil)
      expect(db.projects[2][:name]).to eq("Facebook")

      db.destroy_project(2)

      expect(db.projects.size).to eq(0)
      expect(db.projects[1]).to eq(nil)
      expect(db.projects[2]).to eq(nil)
    end
  end

  ### Tasks

  describe 'build_task method' do
    it "return a Task object" do 
      db = TM::DB.new
      data = { name: "Buy Eggs", id: 1, description: "One Dozen"}
      task1 = db.build_task(data)

      expect(task1.class).to eq(TM::Task)
      expect(task1.name).to eq("Buy Eggs")
      expect(task1.description).to eq("One Dozen")
      expect(task1.priority).to eq(1)
      expect(task1.date_created.mday).to eq(Time.now.mday)
      expect(task1.date_completed).to eq(nil)
      expect(task1.date_due.class).to eq(Time)
      expect(task1.completed).to eq(false)
      expect(task1.project_id).to eq(nil)

      data = { name: "Exercise", id: 1, description: "Bike 12 miles", priority: 4, date_created: Time.now - 3, date_completed: Time.now + 3, date_due: Time.now, completed: true, project_id: 12 }
      task2 = db.build_task(data)

      expect(task2.class).to eq(TM::Task)
      expect(task2.name).to eq("Exercise")
      expect(task2.description).to eq("Bike 12 miles")
      expect(task2.priority).to eq(4)
      expect(task2.date_created.class).to eq(Time)
      expect(task2.date_completed.class).to eq(Time)
      expect(task2.date_due.class).to eq(Time)
      expect(task2.completed).to eq(true)
      expect(task2.project_id).to eq(12)
    end
  end

  describe 'create_task method' do
    it "increments @task_count" do 
      db = TM::DB.new
      data = { name: "Buy Eggs", id: 1, description: "One Dozen"}
      task1 = db.create_task(data)
      expect(db.tasks.size).to eq(1)
      expect(db.task_count).to eq(1)
      expect(db.tasks[1][:name]).to eq("Buy Eggs")
      expect(db.tasks[1][:id]).to eq(1)
      expect(db.tasks[1][:description]).to eq("One Dozen")
    end

    ## add test to see if create project from data with just name, no id
    
    it "can create more than 1 task correctly" do 
      db = TM::DB.new

      data = { name: "Buy Eggs", id: 1, description: "One Dozen"}
      task1 = db.create_task(data)
      expect(task1.class).to eq(TM::Task)

      expect(db.tasks.size).to eq(1)
      expect(db.task_count).to eq(1)

      data = { name: "Exercise", id: 2, description: "Bike 12 miles", priority: 4, date_created: Time.now - 3, date_completed: Time.now + 3, date_due: Time.now, completed: true, project_id: 12 }
      task2 = db.create_task(data)
      expect(task2.class).to eq(TM::Task)

      expect(db.tasks.size).to eq(2)
      expect(db.task_count).to eq(2)

      expect(db.tasks[1][:id]).to eq(1)
      expect(db.tasks[1][:name]).to eq("Buy Eggs")
      expect(db.tasks[1][:description]).to eq("One Dozen")

      expect(db.tasks[2][:id]).to eq(2)
      expect(db.tasks[2][:name]).to eq("Exercise")
      expect(db.tasks[2][:description]).to eq("Bike 12 miles")
    end

    it "returns nil and doesn't affect @tasks if id already exists" do 
      db = TM::DB.new

      data = { name: "Buy Eggs", id: 1, description: "One Dozen"}
      task1 = db.create_task(data)
      expect(task1.class).to eq(TM::Task)
      expect(db.tasks.size).to eq(1)
      expect(db.task_count).to eq(1)

      data = { name: "Exercise", id: 1, description: "Bike 12 miles", priority: 4, date_created: Time.now - 3, date_completed: Time.now + 3, date_due: Time.now, completed: true, task_id: 12 }
      task2 = db.create_task(data)
      expect(task2).to eq(nil)

      expect(db.tasks.size).to eq(1)
      expect(db.task_count).to eq(1)

      expect(db.tasks[1][:id]).to eq(1)
      expect(db.tasks[1][:name]).to eq("Buy Eggs")
    end
  end

  describe 'get_task method' do
    it "returns nil if no tasks" do 
      db = TM::DB.new
      task1 = db.get_task(1)
      expect(task1).to eq(nil)
    end

    it "returns nil if id not found" do 
      db = TM::DB.new
      data = { name: "Buy Eggs", id: 1, description: "One Dozen"}
      db.create_task(data)
      expect(db.tasks.size).to eq(1)

      task1 = db.get_task(5)
      expect(task1).to eq(nil)

    end

    it "return the correct task as a Task object" do 
      db = TM::DB.new
      data = { name: "Buy Eggs", id: 1, description: "One Dozen"}
      db.create_task(data)

      data = { name: "Exercise", id: 2, description: "Bike 12 miles", priority: 4, date_created: Time.now - 3, date_completed: Time.now + 3, date_due: Time.now, completed: true, project_id: 12 }
      db.create_task(data)

      expect(db.tasks.size).to eq(2)

      task1 = db.get_task(1)
      task2 = db.get_task(2)
      expect(task1.class).to eq(TM::Task)
      expect(task1.name).to eq("Buy Eggs")
      expect(task1.id).to eq(1)
      expect(task2.class).to eq(TM::Task)
      expect(task2.name).to eq("Exercise")
      expect(task2.id).to eq(2)
    end

  end

  describe 'destroy_task method' do
    it "return nil if no tasks exist" do 
      db = TM::DB.new
      task1 = db.destroy_task(1)
      expect(task1).to eq(nil)
      expect(db.tasks.size).to eq(0)      
    end

    it "delete the correct object and reduce size" do 
      db = TM::DB.new
      data = { name: "Buy Eggs", id: 1, description: "One Dozen"}
      db.create_task(data)

      data = { name: "Exercise", id: 2, description: "Bike 12 miles", priority: 4, date_created: Time.now - 3, date_completed: Time.now + 3, date_due: Time.now, completed: true, project_id: 12 }
      db.create_task(data)

      expect(db.tasks.size).to eq(2)

      task1 = db.destroy_task(1)
      expect(task1.name).to eq("Buy Eggs")

      expect(db.tasks.size).to eq(1)
      expect(db.tasks[1]).to eq(nil)
      expect(db.tasks[2][:name]).to eq("Exercise")

      task2 = db.destroy_task(2)
      expect(task2.name).to eq("Exercise")

      expect(db.tasks.size).to eq(0)
      expect(db.tasks[1]).to eq(nil)
      expect(db.tasks[2]).to eq(nil)
    end
  end

end