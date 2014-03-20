require_relative 'lib/task-manager.rb'

pl = TM::ProjectList.new
pl.addproject("First")
pl.addproject("Second")
pl.addproject("Third")

pl.projects[0].addtask(1,"Fun task",1)
pl.projects[0].addtask(2,"Fun task",2)
pl.projects[0].addtask(3,"Fun task",2)
pl.projects[1].addtask(4,"Fun task",2)
pl.projects[1].addtask(5,"Fun task",3)
pl.projects[1].addtask(6,"Fun task",3)
pl.projects[2].addtask(7,"Fun task",1)
pl.projects[2].addtask(8,"Fun task",4)
pl.projects[2].addtask(9,"Fun task",4)
pl.projects[2].addtask(10,"Fun task",5)

pl.projects[2].markcomplete(7)
pl.projects[2].markcomplete(9)
pl.projects[2].markcomplete(10)

pl.addemployee("Devon")
pl.addemployee("Brian")
pl.addemployee("Other guy")

pl.projects[0].addemployee(pl.employees[0])
pl.projects[0].addemployee(pl.employees[1])

projectmanager = TM::ProjectManager.new(pl)

projectmanager.menu

# "emp history EID - Show completed tasks for employee with id=EID"
