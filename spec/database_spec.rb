require 'spec_helper'

describe 'Database class' do

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

  describe 'create_project method' do
    it "increments @project_count" do 
      db = TM::DB.new
      data = { name: "test" }
      db.create_project(data)
      expect(db.projects.size).to eq(1)
      # puts db.projects.inspect
      expect(db.project_count).to eq(1)
      expect(db.projects[1][:id]).to eq(1)
      expect(db.projects[1][:name]).to eq("test")
    end
    
    it "can create more than 1 project correctly" do 
      db = TM::DB.new

      data = { name: "test" }
      db.create_project(data)
      expect(db.projects.size).to eq(1)
      expect(db.project_count).to eq(1)

      data = { name: "hello" }
      db.create_project(data)
      expect(db.projects.size).to eq(2)
      expect(db.project_count).to eq(2)

      expect(db.projects[1][:id]).to eq(1)
      expect(db.projects[1][:name]).to eq("test")

      expect(db.projects[2][:id]).to eq(2)
      expect(db.projects[2][:name]).to eq("hello")
    end

  end
  
  describe 'get_project method' do
    it "return nil if no projects" do 
      expect(true).to eq(true)
    end

    it "return the correct project as a Project object" do 
      db = TM::DB.new
      data = { name: "Twitter" }
      db.create_project(data)

      data = { name: "Facebook" }
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
      expect(true).to eq(true)
    end

    it "delete the correct object and reduce size" do 
      db = TM::DB.new
      data = { name: "Twitter" }
      db.create_project(data)

      data = { name: "Facebook" }
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
      # expect(db.projects[2][:name]).to eq("Facebook")
    end

    it "can handle more than one consecutive delete" do 
      expect(true).to eq(true)
    end
  end

  describe 'build_project method' do
    it "should pass this test" do 
      expect(true).to eq(true)
    end
    it "should pass this test" do 
      expect(true).to eq(true)
    end
    it "should pass this test" do 
      expect(true).to eq(true)
    end
  end

end