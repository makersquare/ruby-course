require 'spec_helper'

describe Timeline::GetTeams do
  it 'exists' do
    expect(Timeline::GetTeams).to be_a Class
  end

  it 'returns all teams in database' do
    team = Timeline.db.create_team(name: 'damnit')
    team2 = Timeline.db.create_team(name: 'bushwackers')

    # Timeline::GetTeams.new.run
    # described_class
    result = described_class.run
    expect(result.success?).to eq true
    expect(result.teams.count).to eq 2
    expect(result.teams.first.name).to eq 'damnit'
  end
end
