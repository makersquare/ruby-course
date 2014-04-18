require 'spec_helper'

describe Timeline::GetTeamEvents do
 # subject
 before do
   @team = Timeline.db.create_team(name: "The Chrises")
   @event = Timeline.db.create_event(name:"Greetings", team_id:@team.id)
   @event2 = Timeline.db.create_event(name:"bleh", team_id:@team.id)
 end

 describe 'error handling' do
   it 'if team does not exist, return error' do
     result = subject.run({team_id: 999})
     expect(result.success?).to eq(false)
     expect(result.error).to eq(:missing_team)
   end
 end

 describe 'success' do
   it 'if teams events, return success' do
    result = subject.run(team_id: @team.id)
    expect(result.success?).to eq(true)
    expect(result.events).to eq([@event, @event2])

  end
end
end
