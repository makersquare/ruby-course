module Timeline
	class EventsByTeam < UseCase
		def run(inputs)
			team_id = inputs[:team_id].to_i
			
			return failure(:team_id_not_found) if Timeline.db.get_team(team_id) == nil
			return failure(:no_events) if Timeline.db.get_events_by_team(team_id) == nil

			events = Timeline.db.get_events_by_team(team_id)

			success :events => events
		end
	end
end