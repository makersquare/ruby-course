class EventsController < ApplicationController
  def create
    team_id = params[:team].to_i
    team_name = params[:team_name]
    tags = params[:tags].split(',').collect {|t| t.strip}
    user_name = params[:user]
    event_name = params[:event_name]

    result = Timeline::CreateEvent.run name: event_name, team_id: team_id, tags: tags, user_name: user_name
    if result.success?
      redirect_to({action: 'show', controller: 'teams', team_id: team_id, team_name: team_name}, alert: "Event successfully added.")
    else
      redirect_to({action: 'show', controller: 'teams', team_id: team_id, team_name: team_name}, alert: "Error: " + result.error.to_s)
    end    
  end
end
