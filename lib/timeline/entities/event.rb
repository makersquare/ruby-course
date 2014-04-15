module Timeline
  class Event < Entity
    attr_accessor :id, :user_id, :team_id
    attr_accessor :name, :content, :created_at, :tags

    validates_presence_of :user_id, :team_id, :name
  end
end
