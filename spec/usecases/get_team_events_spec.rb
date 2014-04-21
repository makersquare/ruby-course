require 'spec_helper'

describe Timeline::GetTeamEvents do

  before do
    @team = Timeline.db.create_team(name: "Dream Team")
    @event = Timeline.db.create_event(name: "event", team_id: @team.id)
  end

  describe 'error handling' do
    it 'if team does not exist, return error' do
      result = subject.run({team_id: 999})
      expect(result.error).to eq(:missing_team)
      expect(result.success?).to eq(false)
    end

    it "returns team events" do 
      result = subject.run({team_id: @team.id})
      expect(result.success?).to eq(true)
      expect(result.events.count).to eq(1)
      expect(result.events.first.id).to eq(@event.id)
    end
  end
end