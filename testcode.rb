require_relative 'lib/task-manager.rb'

# pl = TM::DB.new


TM::CreateProject.run({ :name => "Cool Project" })
TM::CreateProject.run({ :name => "Big Project" })
TM::CreateProject.run({ :name => "Small Project" })

TM::CreateTask.run({ :description => "A fun task", :priority => 7, :project_id => 1 })
TM::CreateTask.run({ :description => "A fun task", :priority => 9, :project_id => 1 })
TM::CreateTask.run({ :description => "A fun task", :priority => 6, :project_id => 1 })
TM::CreateTask.run({ :description => "A fun task", :priority => 3, :project_id => 1 })
TM::CreateTask.run({ :description => "A fun task", :priority => 2, :project_id => 1 })
TM::CreateTask.run({ :description => "A fun task", :priority => 4, :project_id => 1 })
TM::CreateTask.run({ :description => "A fun task", :priority => 6, :project_id => 1 })
TM::CreateTask.run({ :description => "A fun task", :priority => 6, :project_id => 2 })
TM::CreateTask.run({ :description => "A fun task", :priority => 8, :project_id => 2 })
TM::CreateTask.run({ :description => "A fun task", :priority => 2, :project_id => 3 })
TM::CreateTask.run({ :description => "A fun task", :priority => 6, :project_id => 3 })

TM::CreateEmployee.run({ :name => "Bob Johnson" })
TM::CreateEmployee.run({ :name => "Cody Thomas"})

pm = TM::ProjectManager.new
pm.menu


