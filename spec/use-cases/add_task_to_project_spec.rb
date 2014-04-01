require 'spec_helper'
describe TM::AddTaskToEmployee do
  before do
    @db = TM.DB
  end

  it "adds a task to employee" do
    employee = @db.create_employee('bob')
    task = @db.create_task('description')
    result = subject.run(:tid => task.id, :eid => employee.id)
    expect(result.success?).to eq true
    expect(result.tasks.eid).to eq employee.id
  end



end
