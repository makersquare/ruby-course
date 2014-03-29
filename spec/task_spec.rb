require 'spec_helper'

module TM
  describe 'Task' do
    it "exists" do
      expect(Task).to be_a(Class)
    end

    it "can be created with a projectid, description, prioirty" do
      project1 = Project.new("Maim Bob")
      task1 = Task.new([project_id: project1.id,
                        description: "Buy a gun",
                        priority: 7])
      expect(task1.project_id).to eq(project1.id)
      expect(task1.description).to eq("Buy a gun")
      expect(task1.priority).to eq(7)
  end
end
