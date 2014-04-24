
class Book
  attr_reader :author, :title, :check_out
  attr_accessor :id, :status, :borrower

  def initialize(title, author)
    @author = author
    @title = title
    @id = id
    @status = "available"
  end

  def check_out
    @status = "checked_out"
  end

  def check_in
    @status = "available"
  end
  # def check_in

  # end

  # def status
  #   check_out ? true : false
  # end
end


class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :books, :title, :author, :id
  def initialize(name="")
    @name = name
    @id_count = 1
    @books = []
  end

  def add_book(title, author)
  end

  def register_new_book(book)
    @books << book
    book.id = @id_count
    @id_count += 1
  end


  def check_out_book(book_id, borrower)
  book =@books.select {|b| b.id = book_id}.first
  book.check_out
  book
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
