# require 'spec_helper'

# describe 'Client' do

#   let (:klass) { TM::Client }

#   describe "Available Commands" do
#     it "'help' prints out the command list" do
#       expect(klass.send(:help)).to be_a(String)
#     end

#       # '  exit - Exit this application',
#       # '  ',
#       # '  create employees NAME - Create a new employee',
#       # '  create projects NAME - Create a new project',
#       # '  create tasks PID PRIORITY DESC - Add a new task to project PID',
#       # '  ',
#       # '  show employees - Show all employees',
#       # '  show employees EID - Show employee EID and assigned project',
#       # '  show employees EID COMPLETED - Show completed tasks for employee EID',
#       # '  show employees EID INCOMPLETE - Show remaining tasks and associated projects for employee EID',
#       # '  ',
#       # '  show projects - Show all projects',
#       # '  show projects PID - Show project PID and incomplete tasks',
#       # '  show projects PID COMPLETED - Show project PID and completed tasks',
#       # '  show projects PID EMPLOYEES - Show employees participating in this project',
#       # '  ',
#       # '  show tasks TID - Show task TID',
#       # '  ',
#       # '  recruit projects PID EID - Add employee EID to project PID',
#       # '  assign tasks TID EID - Assign task TID to employee EID',
#       # '  ',
#       # '  update tasks TID [PRIORITY=VALUE COMPLETED=VALUE DESC=VALUE] - Updates task TID with any or all of the supplied values',
#       # '  update employees EID NAME=VALUE - Updates employee EID with the supplied values',
#       # '  update projects PID COMPLETED=VALUE NAME=VALUE - Updates project PID with the supplied values'
#   end

#   context "Employees" do
#     before(:all) do
#       db.send(:conn).exec('TRUNCATE TABLE employees RESTART IDENTITY CASCADE')
#     end

#     let(:sklass) { 'employees' }
#     let(:klass ) { TM::Employee }
#     let(:args  ) { {'name' => 'Sam'} }
#     let(:update_args) { {'name' => 'Joe'} }

#     it ".create accepts a klass as string and argument hash and returns the created object" do
#       result = @db.create(sklass, args)
#       expect( result  ).to be_a(klass)
#       expect(result.id).to be_a(Integer)
#     end

#     it ".get accepts a klass as string and an id and returns the object" do
#       object = @db.create(sklass, args)
#       result = @db.get(sklass, object.id)
#       expect( result  ).to be_a(klass)
#       expect(result.id).to be_a(Integer)
#       expect(result.id).to eq(object.id)
#     end

#     it ".update accepts a klass as string and an id and args hash and returns the updated object" do
#       object = @db.create(sklass, args)
#       result = @db.update(sklass, object.id, update_args)
#       expect( result  ).to be_a(klass)
#       expect(result.id).to be_a(Integer)
#       expect(result.id).to eq(object.id)

#       expect(result.name).to eq(update_args['name'])
#       expect(result.email).to eq(update_args['email'])
#     end

#     it ".delete accepts a klass as string and an id and returns the deleted object" do
#       object = @db.create(sklass, args)
#       result = @db.delete(sklass, object.id)
#       expect( result  ).to be_a(klass)
#       expect(result.id).to be_a(Integer)
#       expect(result.id).to eq(object.id)

#       expect(@db.get(sklass, object.id)).to eq(nil)
#     end
#   end

#   context "Projects" do
#     before(:all) do
#       @conn.exec('TRUNCATE TABLE projects RESTART IDENTITY CASCADE')
#     end

#     let(:sklass) { 'projects' }
#     let(:klass ) { TM::Project }
#     let(:args  ) { {'name' => 'Test Project', 'completed' => false} }
#     let(:update_args) { {'name' => 'Project Test', 'completed' => true} }

#     it ".create accepts a klass as string and argument hash and returns the created object" do
#       result = @db.create(sklass, args)
#       expect( result  ).to be_a(klass)
#       expect(result.id).to be_a(Integer)
#     end

#     it ".get accepts a klass as string and an id and returns the object" do
#       object = @db.create(sklass, args)
#       result = @db.get(sklass, object.id)
#       expect( result  ).to be_a(klass)
#       expect(result.id).to be_a(Integer)
#       expect(result.id).to eq(object.id)
#     end

#     it ".update accepts a klass as string and an id and args hash and returns the updated object" do
#       object = @db.create(sklass, args)
#       result = @db.update(sklass, object.id, update_args)
#       expect( result  ).to be_a(klass)
#       expect(result.id).to be_a(Integer)
#       expect(result.id).to eq(object.id)

#       expect(result.name).to eq(update_args['name'])
#       expect(result.completed).to eq(update_args['completed'])
#     end

#     it ".delete accepts a klass as string and an id and returns the deleted object" do
#       object = @db.create(sklass, args)
#       result = @db.delete(sklass, object.id)
#       expect( result  ).to be_a(klass)
#       expect(result.id).to be_a(Integer)
#       expect(result.id).to eq(object.id)

#       expect(@db.get(sklass, object.id)).to eq(nil)
#     end
#   end

#   context "Tasks" do
#     before(:all) do
#       @conn.exec('TRUNCATE TABLE tasks RESTART IDENTITY CASCADE')
#       @employee = @db.create( 'employees', {'name' => 'Joe', 'email' => 'joe@email.com'} )
#       @project  = @db.create( 'projects', {'name' => 'Write Code', 'completed' => false } )
#     end

#     let(:sklass) { 'tasks' }
#     let(:klass ) { TM::Task }
#     let(:args  ) {
#       {'priority' => 1, 'description' => 'Test Task',
#        'project_id' => @project.id, 'employee_id' => @employee.id,
#        'completed' => false}
#     }
#     let(:update_args) {
#       {'priority' => 3, 'description' => 'Task Test', 'completed' => true}
#     }

#     it ".create accepts a klass as string and argument hash and returns the created object" do
#       result = @db.create(sklass, args)
#       expect( result  ).to be_a(klass)
#       expect(result.id).to be_a(Integer)

#       expect(result.project_id).to eq(@project.id)
#       expect(result.employee_id).to eq(@employee.id)
#       expect(result.created_at).to be_a(Time)
#     end

#     it ".get accepts a klass as string and an id and returns the object" do
#       object = @db.create(sklass, args)
#       result = @db.get(sklass, object.id)
#       expect( result  ).to be_a(klass)
#       expect(result.id).to be_a(Integer)
#       expect(result.id).to eq(object.id)
#     end

#     it ".update accepts a klass as string and an id and args hash and returns the updated object" do
#       object = @db.create(sklass, args)
#       result = @db.update(sklass, object.id, update_args)
#       expect( result  ).to be_a(klass)
#       expect(result.id).to be_a(Integer)
#       expect(result.id).to eq(object.id)

#       expect(result.description).to eq(update_args['description'])
#       expect(result.completed).to eq(update_args['completed'])
#     end

#     it ".delete accepts a klass as string and an id and returns the deleted object" do
#       object = @db.create(sklass, args)
#       result = @db.delete(sklass, object.id)
#       expect( result  ).to be_a(klass)
#       expect(result.id).to be_a(Integer)
#       expect(result.id).to eq(object.id)

#       expect(@db.get(sklass, object.id)).to eq(nil)
#     end
#   end
# end
