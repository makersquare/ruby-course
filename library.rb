
class Book
  attr_reader :author, :title
  attr_accessor :id, :status, :borrower

  def initialize(title, author, id=nil, status="available")
    @author = author
    @title = title
    @id = id
    @status = status
    @borrower = nil
  end

  def check_out
    if @status == "checked_out" 
      false 
    else 
      @status = "checked_out"
      true
    end
  end

  def check_in
    @status = "available"
  end
end

class Borrower
  attr_reader :name
  attr_accessor :books_checked_out

  def initialize(name)
    @name = name
    @books_checked_out = 0
  end
end

class Library
  attr_accessor :books

  def initialize(name)
    @books = []
    @book_id = 1
  end

  def register_new_book(title, author)
    @books << Book.new(title, author, @book_id)
    @book_id +=1
  end

  def check_out_book(book_id, borrower)
    book = @books[book_id -1] 
    if book.status == "checked_out"
      nil
    elsif borrower.books_checked_out >= 2
      nil
    else
      book.borrower = borrower
      book.status = "checked_out"
      borrower.books_checked_out += 1
      book
    end
  end

  def get_borrower(book_id)
    book = @books.find {|x| x.id == book_id}
    book.borrower.name
  end

  def check_in_book(book)
    if book.status == "available"
      nil
    else
      borrower = book.borrower
      borrower.books_checked_out -= 1
      book.borrower = nil
      book.status = "available"
    end
  end

  def available_books
  end

  def borrowed_books
  end
end
