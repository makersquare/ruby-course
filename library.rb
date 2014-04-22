
class Book
  attr_reader :author, :status, :title
  attr_accessor :id
  # attr_accessor :check_out

  def initialize(title, author)
    @title = title
    @author = author
    @status = "available"
    @id = nil
  end

  def check_out
    @status = "checked_out"
  end

  def check_in
    @status = "available"
  end
end

class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library
  def initialize(name)
    @books = []
    @id_count = 1
  end

  def books
    @books
  end

  def register_new_book(book)
    @books << book
    book.id = @id_count
    @id_count += 1
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
