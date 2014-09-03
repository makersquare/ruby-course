require 'bookly'
Bookly.books_repo = Bookly::Repositories::Books.new('bookly_test')

RSpec.configure do |config|
  config.before(:each) do
    Bookly.books_repo.delete_all
  end
end
