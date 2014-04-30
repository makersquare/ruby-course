require './lib/task-manager.rb'
require 'time'

def test
	project1 = TM::Project.new("project1")
	task1 = TM::Task.new("task1")
	task1.mark_completed
	task1.set_date_created(Time.parse("1/1/2014"))
	task2 = TM::Task.new("task2")
	task2.mark_completed
	task2.set_date_created(Time.parse("2/1/2013"))
	task3 = TM::Task.new("task3")
	task3.mark_completed
	task3.set_date_created(Time.parse("3/1/2014"))

	project1.add_task(task1)
	project1.add_task(task2)
	project1.add_task(task3)

	task_array = project1.retrieve_completed_tasks_by_date
	# expect(task_array.size).to eq(3)

	project1.tasks.each {|x| puts x.name}
	task_array.each {|x| puts x.name}
end

test