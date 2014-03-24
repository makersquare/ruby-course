require_relative 'lib/task-manager.rb'

pl = TM::ProjectList.new
pl.addproject("First Project")
pl.addproject("Second Project")
pl.addproject("Third Project")

pl.projects[0].addtask("Task 1",1)
pl.projects[0].addtask("Task 2",2)
pl.projects[0].addtask("Task 3",2)
pl.projects[1].addtask("Task 4",2)
pl.projects[1].addtask("Task 5",3)
pl.projects[1].addtask("Task 6",3)
pl.projects[2].addtask("Task 7",1)
pl.projects[2].addtask("Task 8",4)
pl.projects[2].addtask("Task 9",4)
pl.projects[2].addtask("Task 10",5)

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

