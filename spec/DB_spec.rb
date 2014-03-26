require 'spec_helper'

describe 'DB' do
  it 'exists' do
    expect(TM::DB).to be_a(Class)
  end

  before do
    @db = TM::DB.new
  end

describe 'initialize' do
  it 'has 4 hashes initialized for project, task, id, members' do
    expect(@db.projects).to eq ({})
    expect(@db.tasks).to eq ({})
    expect(@db.employees).to eq ({})
    expect(@db.memberships).to eq ({})
  end
end
end
