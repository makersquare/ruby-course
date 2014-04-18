require 'spec_helper'

describe Timeline::GetTeamEvents do
 # subject
 before do
   @team = Timeline.db.create_team(name: "The Chrises")
   @event = Timeline.db.create_event(name:"Greetings")
 end

 describe 'error handling' do
   it 'if team does not exist, return error' do
     result = subject.run({team_id: 999})
     expect(result.success?).to eq(false)
   end
 end

 describe 'success' do
   it 'if teams events, return success' do
    result = subject.run(team_id: @team.id)
    expect(result.success?).to eq(true)

  end
end
end
