
class Book
  attr_reader :author
  attr_reader :title
  attr_reader :id
  attr_reader :status

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
  end

  def check_out
    @status = "checked_out"
    return true
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
