require 'spec_helper.rb'

describe TM::DB do
  describe "existance of class" do
    it "exists" do
      expect(TM::DB).to be_a(Class)
    end
  end

  describe "db" do
    it "gives you a DB object" do
      expect(TM.db).to be_a(TM::DB)
    end

    it "gives you a singleton db every time" do
      result1 = TM.db
      result2 = TM.db
      expect(result1).to eq(result2)
    end

    describe "projects in db" do

      let(:project) {TM.db.create_project({name: "p1"})}

      describe "#create_project" do
        it "takes a name and returns a project" do
          expect(project).to be_a(TM::Project)
          expect(project.name).to eq("p1")
        end

        it "assigns the project a unique id" do
          data1 = {name: "p1"}
          data2 = {name: "p2"}

          p1 = TM.db.create_project(data1)
          p2 = TM.db.create_project(data2)

          expect(p1.id).to_not eq(p2.id)
        end
      end

      describe "#get_project" do
        it "takes an id and gives the associated project" do
          copy = TM.db.get_project(project.id)
          expect(project.name).to eq(copy.name)
          expect(project.id).to eq(copy.id)
        end

        it "returns nil if the project doesn't exist" do
          expect(TM.db.get_project(5)).to eq(nil)
        end
      end

      describe "#update_project" do
        xit "updates the given project in the db" do
          project = TM.db.create_project({name: "p1"})
          TM.db.update_project({name: "hello"}, project.id)
          project = TM.db.get_project(project.id)
          expect(project.name).to eq("hello")
        end
      end

      describe "#build_project" do
        it "takes a data hash and creates a project entity" do
          data = {
            name: "testing",
            id: 5
          }
          project = TM.db.build_project(data)
          expect(project).to be_a(TM::Project)
          expect(project.name).to eq("testing")
          expect(project.id).to eq(5)
        end
      end
    end

    describe "tasks in db" do
      let(:task) do
        TM.db.create_task( {
          priority: 5,
          description: "do this",
          project_id: 0
        })
      end

      describe "#create_task" do
        let(:task) do
          TM.db.create_task( {
            priority: 5,
            description: "do this",
            project_id: 0,
          })
        end
        it "creates a task given priority, description and project id" do
          expect(task).to be_a(TM::Task)
          expect(task.project_id).to eq(0)
          expect(task.description).to eq("do this")
          expect(task.priority).to eq(5)
        end

        it "gives a unique id" do
          expect(task.id).to eq(0)
          task2 = TM.db.create_task({
            priority: 2,
            description: "do that",
            project_id: 2
            })
          expect(task2.id).to eq(1)
        end
      end

      describe "#build_task" do
        it "returns an entity with given data" do
          data = {
            priority: 5,
            description: "do this",
            project_id: 0,
            id: 5,
            complete: false,
            timestamp: Time.now
          }
          task = TM.db.build_task(data)
          expect(task).to be_a(TM::Task)
          expect(task.project_id).to eq(data[:project_id])
          expect(task.description).to eq(data[:description])
          expect(task.priority).to eq(data[:priority])
          expect(task.id).to eq(data[:id])
          expect(task.complete).to eq(false)
          # This test is not going to work because we don't have Timecop :(
          # expect(task.timestamp).to eq(Time.now)
        end
      end

      describe '#get_task' do
        it "takes an id and gives the associated task" do
          copy = TM.db.get_task(task.id)
          expect(copy).to be_a(TM::Task)
          expect(copy.project_id).to eq(task.project_id)
          expect(copy.description).to eq(task.description)
          expect(copy.priority).to eq(task.priority)
          expect(copy.id).to eq(task.id)
          expect(copy.complete).to eq(false)
        end
      end

      describe '#update_task' do

      end
    end
  end

end