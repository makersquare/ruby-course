require 'spec_helper.rb'
require 'pry'           #used to allow Pry debugger

describe 'TM::DB' do   #describes what the Project class should do
  describe "db as a singleton" do
    it "works and returns a DB object" do
      db = TM.db
      expect(TM::DB).to be_a(Class)
      expect(db).to be_a(TM::DB)
    end

    it "it will return a hash of projects" do
      project = TM.db
      expect(project.projects).to be_a(Hash)
    end

    it "returns the same project every time" do
      db1 = TM.db
      db2 = TM.db
      expect(db1).to eq(db2)
    end
  end

  describe "for the projects inside DB" do
    let(:project) {TM.db.create_project(:name => "Test Project")}


  describe "create project" do
    it "can return the project entity" do
      expect(project).to be_a(TM::Project)
      expect(project.id).to be_a(Fixnum)
      expect(project.name).to eq("Test Project")
    end

    it "stores information in the db" do
      expect(TM.db.projects[project.id]).to eq({
        :name => "Test Project",
        :id => project.id
        })
    end

    it "gives a unique id every time" do
      p1 = TM.db.create_project(:name => "p1")
      p2 = TM.db.create_project(:name => "p2")
      expect(p1.id).to_not eq(p2.id)
    end

  describe "#get_project" do
    it "returns a project entity with the proper data" do
      p1 = TM.db.create_project(:name => "p1")
      p2 = TM.db.create_project(:name => "p2")
      project = TM.db.get_project(p1.id)
      project2 = TM.db.get_project(p2.id)
      expect(project).to be_a(TM::Project)
      expect(p1.id).to eq(project.id)
      expect(p2.name).to eq(project2.name)
    end
  end

  describe "#update_project" do
    it "updates the project in the db" do
      p1 = TM.db.create_project(:name => "to be updated")
      TM.db.update_project(p1.id, :name => "updated")
      project = TM.db.get_project(p1.id)
      expect(project.name).to eq("updated")
    end

  describe "#destroy_project"
    it "can delete a project from the db" do
      p1 = TM.db.create_project(:name => "p1")
      TM.db.destroy_project(p1.id)
      project = TM.db.get_project(p1.id)
      expect(project).to eq(nil)
    end
  end

  end
end
end





# equal tests to see if they are similar
# be tests to check if they are the same exact
