require 'pg'

module Bookly
  def self.books_repo=(repo)
    @books_repo = repo
  end
  def self.books_repo
    @books_repo
  end
end

require_relative 'bookly/entities/book.rb'

require_relative 'bookly/repositories/books.rb'
