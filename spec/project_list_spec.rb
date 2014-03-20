require 'spec_helper'

describe 'ProjectList' do
  	it "exists" do
    	expect(TM::ProjectList).to be_a(Class)
  	end

	it 'adds a project to a project list' do
		list = TM::ProjectList.new
		project = TM::Project.new('project')
		list.add_project(project)

		expect(list.project_list).to eq([project])

	end

	it 'returns an incompleted tasks list based on project id' do
		project = TM::Project.new('project')
		task = TM::Task.new('red',2,project.id)
		project.add_task(task)
		list = TM::ProjectList.new
		list.add_project(project)
		# list.tasks_for_project(project.id)

		expect(list.tasks_for_project(project.id)).to eq([task])

	end
 
  
end

