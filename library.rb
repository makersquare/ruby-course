
class Book
  attr_reader :author, :title, :year_published, :edition
  attr_accessor :id, :status, :borrower

  def initialize(title, author, id=nil, status="available", year_published="unknown", edition="unknown")
    @author = author
    @title = title
    @id = id
    @status = status
    @borrower = nil
    @year_published = year_published
    @edition = edition
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
  attr_accessor :books, :available_books, :borrowed_books

  def initialize(name)
    @books = []
    @available_books = []
    @borrowed_books = []
    @book_id = 1
  end

  def register_new_book(title, author)
    new_book = Book.new(title, author, @book_id)
    @books << new_book
    @available_books << new_book
    @book_id +=1
  end

  def check_out_book(book_id, borrower)
    book_out = @books[book_id -1] 
    if book_out.status == "checked_out"
      nil
    elsif borrower.books_checked_out >= 2
      nil
    else
      book_out.borrower = borrower
      book_out.status = "checked_out"
      borrower.books_checked_out += 1
      @available_books.delete(book_out)
      @borrowed_books << book_out
      book_out
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
      @available_books.push(book)
      @borrowed_books.delete(book)
      book.status = "available"
    end
  end

end
