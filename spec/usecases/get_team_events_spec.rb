describe Timeline::GetTeamEvents do
  it 'exists' do
    expect(Timeline::GetTeamEvents).to be_a(Class)
  end
  it 'returns an error if a team doesn\'t exist' do
    team = Timeline.db.create_team(name: 'tittytoffy')
    result = described_class.run(team_id: 39403942084)
    expect(result.success?).to be_false
    expect(result.error).to eq(:team_doesnt_exist)
  end
  it 'gets events by team' do
    user = Timeline.db.create_user(name: 'Thutford')
    team = Timeline.db.create_team(name: 'dingleberries')
    team2 = Timeline.db.create_team(name: 'buttery brothels')
    event1 = Timeline.db.create_event(name: 'Forthcoming Fathers', user_id: user.id, team_id: team.id)
    event2 = Timeline.db.create_event(name: 'Reluctant Mothers', user_id: user.id, team_id: team2.id)

    result = subject.run(team_id: team.id)
    expect(result.success?).to be_true
    expect(result.events.count).to eq(1)
    expect(result.events.first.name).to eq('Forthcoming Fathers')

  end
end
