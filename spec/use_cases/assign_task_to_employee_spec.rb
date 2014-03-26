require_relative '../spec_helper.rb'


describe "Assign Task to Employee" do
  before do
    @db = TM::DB.instance
  end

  context "when tid and eid are valid" do
    it "successfully validates a task exists, is incomplete, and has no employee assigned to it" do
      emp = @db.create_emp("Jack")
      proj = @db.create_project("Save the World")
      task = @db.add_task_to_proj(proj.id, "plant some trees", 2)

      result = TM::AssignTaskToEmployee.run({ eid: emp.id, tid: task.id })
      expect(result.success?).to eq(true)
    end
  end

  context "when tid and eid are invalid" do
    it "fails" do
      emp = @db.create_emp("Jack")
      proj = @db.create_project("Save the World")
      task = @db.add_task_to_proj(proj.id, "plant some trees", 2)
      # ensure the ids don't exist
      eid = emp.id + 100
      tid = task.id + 100

      result = TM::AssignTaskToEmployee.run({ eid: eid, tid: tid })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:invalid_task)
    end
  end
end