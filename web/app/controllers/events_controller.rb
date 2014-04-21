class EventsController < ApplicationController
	def create
    user_id = params[:user_id].to_i
    team_id = params[:team_id].to_i
		name = params[:name]

    result = Timeline::CreateEvent.run(user_id: user_id, team_id: team_id, name: name)

		if result.success?
			flash[:success] = "Event created"
		else
			if result.error?
				flash[:error] = "#{result.error}"
			end
		end
		redirect_to team_show_path(params[:team_id])
	end
end