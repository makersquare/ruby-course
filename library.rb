
class Book
  attr_reader :author, :title, :id

  def initialize(title, author)
    @author = author
    @title = title
    @id = id
  end
end
book = Book.new("The Stranger", "Albert Camus")

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
