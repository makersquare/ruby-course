class EventsController < ApplicationController
	def create
		inputs = {}

		inputs[:name] = params[:name]
		inputs[:user_id] = params[:user_id].to_i
		inputs[:team_id] = params[:team_id].to_i

		result = Timeline::CreateEvent.run(inputs)


		if result.success?
			@event = result.event
		end
		redirect_to "/teams/show/#{inputs[:team_id]}"
	end
end
