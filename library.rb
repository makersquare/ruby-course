
class Book
  attr_reader :author, :title, :id, :status, :check_out

  def initialize(title, author)
    @author = author
    @title = title
    @id = id
    @status = "available"
  end

  def check_out
    @status = "checked_out"
  end

  # def check_in

  # end

  # def status
  #   check_out ? true : false
  # end
end
book = Book.new("The Stranger", "Albert Camus")
book.status

class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :books, :title, :author, :id
  def initialize(name, id = 0)
    @name = name
    @id = id
    @books = []
  end

  # def books
  #   @books
  # end

  def add_book(title, author)
  end

  def register_new_book(add_book)
    @books << add_book
  end

  def check_out_book(book_id, borrower)
  end

  def created_book
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
# lib = Library.new("Bola")
# lib.books
# lib.add_book("Nausea", "Jean-Paul Sartre")
