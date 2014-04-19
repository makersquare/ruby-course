module Timeline
	class EventsByTeam < UseCase
		def run(inputs)
			team_id = inputs[:team_id]
			
			return failure(:team_id_not_found) if Team.find(team_id) == nil
			return failure(:no_events) if Team.find(team_id).events == nil

			events = Database::PersistentDB::Team.events

			success :events => events
		end
	end
end