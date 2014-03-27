require 'spec_helper.rb'
  describe TM::CreateTask do
    before do
      @db = TM.db
      @project = @db.create_project("Test")
    end

    it "creates a new task" do
      result = subject.run({ :description => "Description", :priority => 3, :project_id => @project.project_id})
      expect(result.task.project_id).to eq(@project.project_id)
      expect(result.success?).to eq(true)
    end

    it "returns error if project id does not exist" do
      result = subject.run({ :description => "Description", :priority => 3, :project_id => 1000})
      expect(result.error?).to eq(true)
      expect(result.error).to eq(:project_does_not_exist)
    end
  end
