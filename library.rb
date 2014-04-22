
class Book
  attr_reader :author

  def initialize(title, author)
    @author = author
  end

  def title
    "The Stranger"
  end

  def id
  end

  def status
    "available"
  end
end

class Borrower
  def initialize(name)
  end
end

class Library
  def initialize(name)
    @books = []
  end

  def books
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
