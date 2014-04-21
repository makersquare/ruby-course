class EventsController < ApplicationController
  def new
    @event = Timeline::Event.new
  end

  def create
    # @event = Timeline::Event.new(params)
    # binding.pry
    binding.pry
    result = Timeline::CreateEvent.run(params)

    if result.success?

      @event = result.event
      redirect_to '/teams'
    else
      @error = result.error
      @event = Timeline::Event.new(params)

      # team_result = Timeline::GetTeamEvents.run(team_id: params[:team_id])
      # @team = team_result.team

      render 'teams/show'
    end

  end
end
