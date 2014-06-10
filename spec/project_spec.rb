require 'spec_helper'
require 'pry'
require 'time'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "can be created with a name" do
  	project = TM::Project.new("name")
  	expect(project.name).to eq("name")
  end

  it "has to have acode generated automatically" do
  	project = TM::Project.new
  	expect(project.id).not_to eq(nil)
  end

  it "can retrieve a list of all complete_
   tasks, sorted by creation date" do
   	tasks = []
   	d1 = Time.parse("01-01-2014")
	d2 = Time.parse("02-02-2014")
	d3 = Time.parse("01-03-2014")
	d4 = Time.parse("05-11-2014")
	d5 = Time.parse("01-03-2013")
	project = TM::Project.new
	

	expect(Time).to receive(:now).and_return(d1)
	task1 = TM::Task.new(project.id,'desc1',1)
	tasks << task1
	
	expect(Time).to receive(:now).and_return(d2)
	task2 = TM::Task.new(project.id,'desc2',2)
	task2.state_complete!
	tasks << task2
	
	expect(Time).to receive(:now).and_return(d3)
	task3 = TM::Task.new(project.id,'desc3',1)
	tasks << task3
	
	expect(Time).to receive(:now).and_return(d4)
	task4 = TM::Task.new(project.id,'desc4',3)
	task4.state_complete!
	tasks << task4
	
	expect(Time).to receive(:now).and_return(d5)
	task5 = TM::Task.new(project.id,'desc5',7)
	task5.state_complete!
	tasks << task5
	
	res=""
	# binding.pry
	c_tasks = project.completed_tasks(tasks)
	c_tasks.each {|t| res += t.desc + " " }
	expect(res).to eq("desc5 desc2 desc4 ")

	end

	it "can retrieve a list of all incomplete tasks,_
	 sorted by priority" do

	 	tasks = []
	   	d1 = Time.parse("01-01-2014")
		d2 = Time.parse("02-02-2014")
		d3 = Time.parse("01-03-2014")
		d4 = Time.parse("05-11-2014")
		d5 = Time.parse("01-03-2013")
		project = TM::Project.new
		
		#
		expect(Time).to receive(:now).and_return(d1)
		task1 = TM::Task.new(project.id,'desc1',1)
		tasks << task1
		
		expect(Time).to receive(:now).and_return(d2)
		task2 = TM::Task.new(project.id,'desc2',2)
		tasks << task2
		#
		expect(Time).to receive(:now).and_return(d3)
		task3 = TM::Task.new(project.id,'desc3',1)
		tasks << task3
		
		expect(Time).to receive(:now).and_return(d4)
		task4 = TM::Task.new(project.id,'desc4',3)
		task4.state_complete!
		tasks << task4
		#
		expect(Time).to receive(:now).and_return(d5)
		task5 = TM::Task.new(project.id,'desc5',7)
		# task5.state_complete!
		tasks << task5
		
		res=""
		# binding.pry
		c_tasks = project.incomplete_tasks(tasks)
		c_tasks.each {|t| res += t.desc + " " }
		expect(res).to eq("desc1 desc3 desc2 desc5 ")
	end
end

describe 'task' do
	it 'can be created project id,_ 
	description, and priority number' do
		project = TM::Project.new
		task = TM::Task.new(project.id,'desc',1)
		expect(task.p_id).to eq(project.id)
		expect(task.desc).to eq('desc')
		expect(task.priority).to eq(1)
	end

	it 'a task can be marked as completed' do
		project = TM::Project.new
		task = TM::Task.new(project.id,'desc',1)
		task.state_complete!
		expect(task.state_complete).to eq(true)
	end

	it 'has to have a creation date' do
		d1 = Time.parse("01-01-2014")
		# d2 = Time.parse("01-02-2014")
		# d3 = Time.parse("01-03-2014")
		project = TM::Project.new
		expect(Time).to receive(:now).and_return(d1)
		task = TM::Task.new(project.id,'desc',1)
		expect(task.creation_date).to eq(d1)
	end
end

describe 'TerminalClient' do

	it 'show message' do

		terminal = TM::TerminalClient.new
	end
end





































