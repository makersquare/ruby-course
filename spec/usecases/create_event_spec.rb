require_relative '../spec_helper'

describe Timeline::CreateEvent do
  it 'exists' do
    expect(Timeline::CreateEvent).to be_a Class
  end

  it 'returns error for no user_id provided' do
    result = subject.run(name: 'b', team_id: 15315)
    expect(result.success?).to be_false
    expect(result.error).to eq :no_user_id_provided
  end

  it 'returns error for no team_id provided' do
    user = Timeline.db.create_user(name: 'bob')
    result = subject.run(name: 'b', user_id: user.id)
    expect(result.success?).to be_false
    expect(result.error).to eq :no_team_id_provided
  end

  it 'returns error for user_id doesnt exist' do
    result = subject.run(name: 'b', team_id:2491385091, user_id: 15318686458455)
    expect(result.success?).to be_false
    expect(result.error).to eq :user_doesnt_exist
  end

  it 'returns error for team_id doesnt exist' do
    user = Timeline.db.create_user(name: 'bob')
    result = subject.run(name: 'b', team_id:2491385091, user_id: user.id)
    expect(result.success?).to be_false
    expect(result.error).to eq :team_doesnt_exist
  end

  it 'creates an event' do
    user = Timeline.db.create_user(name: 'bob')
    team = Timeline.db.create_team(name: 'teamname')
    result = subject.run(name: 'event', team_id: team.id, user_id: user.id)
    expect(result.success?).to eq true
    expect(result.event.name).to eq 'event'
    expect(result.event.user_id).to eq user.id
  end
end
