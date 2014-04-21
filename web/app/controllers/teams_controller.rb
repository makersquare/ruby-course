class TeamsController < ApplicationController
	def index
		result = Timeline::GetTeams.run({}).teams
		
		if (result.success?)
      @teams = result
    end
	end

	def show
    @team = Timeline.db.get_team(params[:id].to_i)
		@team_events = Timeline::GetTeamEvents.run(team_id: params[:id].to_i).events
	end
end