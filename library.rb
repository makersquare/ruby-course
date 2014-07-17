
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
    @status = "available" if @status == "checked_out"
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
    @borrowed_books = {}
  end

  def register_new_book(title, author, id=rand(500))
    new_book = Book.new(title, author, id)
    @available_books << new_book
    @books << new_book
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    if borrower.borrowed.size <= 1 
      book = @books.find{|b| b.id == book_id}
      return nil if book.status == "checked_out"
      @borrowed_books[book_id] = borrower.name
      @available_books.delete(book)
      book.check_out
      borrower.borrowed << book
      book
    else
      return nil
    end
  end

  def get_borrower(book_id)
    @borrowed_books[book_id]
  end

  def check_in_book(book)
    book.check_in
    @available_books << book
    @borrowed_books.delete(book.id)
  end 

  def borrowed_books
    bb = @borrowed_books.select{|k,v| v !=nil}.keys
    bb.map {|i| @books.first}  
  end
end
