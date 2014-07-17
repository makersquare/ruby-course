class EventsController < ApplicationController
  def create
     result = Timeline::CreateEvent.run(name: params[:name], user_id: params[:user_id].to_i, team_id: params[:team_id].to_i)
     puts "#{result.inspect}"
    if result.success?
      redirect_to "teams/show/#{params[:team_id]}"
    else
      @error = result.error
    end
  end
end
