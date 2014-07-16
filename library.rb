
class Book
  attr_reader :author, :title
  attr_accessor :id, :status

  def initialize(title, author, id=nil)
    @title = title
    @author = author
    @id = id
    @status = "available"
  end

  def check_out
    if @status == "available"
      @status = "checked_out" 
      true
    elsif @status == "checked_out"
      return false
    end
  end

  def check_in
    @status = "available" if @status = "checked_out"
  end
end

class Borrower
  attr_reader :name, :borrowed

  def initialize(name)
    @name = name
    @borrowed = []
  end
end

class Library
  attr_reader :name, :books, :borrowed_books, :available_books

  def initialize(name)
    @name = name
    @books = []
    @available_books = []
    @borrowed_books = []
  end

  def register_new_book(title, author, id=rand(500))
    new_book = Book.new(title, author, id)
    @books << new_book
  end

  # def books
  # end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    book = @books.find{|b| b.id == book_id}
    return nil if book.status == "checked_out"
    @borrowed_books << {book_id => borrower.name}
    book.check_out
    borrower.borrowed << book
    book
  end

  def get_borrower(book_id)
    @borrowed_books.find{|h| h[book_id]}[book_id]
  end

  def check_in_book(book)
  end 

  def available_books
  end

  def borrowed_books
  end
end
