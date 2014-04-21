require 'spec_helper'

describe Timeline::GetTeams do

  before do
    Timeline.db.clear_everything
  end

  describe 'error handling' do
    it 'if there are no teams in the database, return error' do
      result = subject.run()

      expect(result.error).to eq(:no_teams_in_database)
      expect(result.success?).to eq(false)
    end

    it "returns all teams from the database" do 
      team = Timeline.db.create_team(name: "Dream Team")
      result = subject.run()

      expect(result.success?).to eq(true)
      expect(result.teams.count).to eq(1)
      expect(result.teams.first.name).to eq(team.name)
    end
  end
end