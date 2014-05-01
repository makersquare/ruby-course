require_relative 'task-manager.rb'

p1 = TM::Project.new

t1 = TM::Task.new(description: "Task 1", priority: 1)
t2 = TM::Task.new(description: "Task 2", priority: 2)
t3 = TM::Task.new(description: "Task 3", priority: 1)

t2.set_date_due(Time.now - 4*24*60*60)

p1.add_task(t1,t2,t3)

p1.list_incompleted_tasks_by_priority
