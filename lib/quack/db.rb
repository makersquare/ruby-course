class Quack::DB
  attr_reader :text_quacks, :tags, :text_quack_tags

  def initialize
    @text_quacks = {}
    @next_tq_id = 0
    @tags = {}
    @next_tag_id = 0
    @text_quack_tags = {}
    @text_quack_tags_counter = 0
  end

  def create_text_quack(data)
    data[:id] = @next_tq_id
    @next_tq_id += 1
    data.delete(:tags)
    @text_quacks[data[:id]] = data
    TextQuack.new(data[:content], nil, data[:id])
  end

  def get_or_create_tag(data)
    existing_tag = tags.select {|id, tag| tag[:tag] == data[:tag]}.first
    if existing_tag
      data = existing_tag.last
    else
      data[:id] = @next_tag_id
      @next_tag_id += 1
      @tags[data[:id]] = data
    end
    Tag.new(data[:tag], data[:id])
  end

  def get_tag(id)
    data = @tags[id]
    Tag.new(data[:tag], data[:id])
  end

  # For creating a text_quack_tag
  # Expects two inputs: tq_id and tag_id representing the ids of the quack and 
  # the tag
  # Adds the text_quack_tag to the database
  # Returns the id of the new text_quack_tag

  def create_text_quack_tag(tq_id, tag_id)
    id = @text_quack_tags_counter
    data = {tq_id: tq_id, tag_id: tag_id, id: id}
    @text_quack_tags[id] = data
    @text_quack_tags_counter += 1
    return id
  end
end

module Quack
  def self.db
    @__db_instance ||= DB.new
  end
end
