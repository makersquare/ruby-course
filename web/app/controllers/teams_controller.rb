class TeamsController < ApplicationController
	def index
		@teams = Timeline::GetTeams.run(params).teams
	end

	def show
		@teams = Timeline.db.get_teams(params[:id].to_i)
		@team_name = @team.name
		@team_events = Timeline::GetTeamEvents.run(team_id: @team.id.to_i).team_events
		puts @team_events
		puts @team_events.size
	end
end
