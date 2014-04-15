require 'spec_helper'

describe Timeline::Database::InMemory do

  it_behaves_like "a database"

  let(:db) { described_class.new }

  before { db.clear_everything }

end
