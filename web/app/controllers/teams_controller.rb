class TeamsController < ApplicationController
	def index
		result = Timeline::GetTeams.run

		if result.success?
			@teams = result.teams
		end
		render 'teams/index'
	end

	def show
		@team_id = params[:team_id].to_i
		@team = Timeline.db.get_team(@team_id)
		result = Timeline::EventsByTeam.run(team_id: @team_id)

		if result.success?
			@events = result.events
		end
		render 'teams/show/'
	end
end
