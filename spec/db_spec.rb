require 'spec_helper'

describe 'Project' do


  it "initiates with blank employees(hash), participating(array), projects(hash), tasks(array)" do
    expect(TM::DB.instance.all_employees).to be_a(Hash)
    expect(TM::DB.instance.all_tasks).to be_a(Hash)
    expect(TM::DB.instance.all_projects).to be_a(Hash)
    expect(TM::DB.instance.participating).to be_a(Array)
  end

  it "can allow access to its hashes and arrays" do
    TM::DB.instance.all_employees[:bob] = 5
    expect(TM::DB.instance.all_employees[:bob]).to eq(5)
  end
end
