
class Book
  attr_reader :author, :title, :year_published, :edition
  attr_accessor :id, :status, :borrower, :reviews, :due_date

  def initialize(title, author, id=nil, status="available", year_published="unknown", edition="unknown")
    @author = author
    @title = title
    @id = id
    @status = status
    @borrower = nil
    @year_published = year_published
    @edition = edition
    @reviews = {}
    @due_date = nil
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
  attr_accessor :books_checked_out, :reviews, :overdue

  def initialize(name)
    @name = name
    @books_checked_out = []
    @reviews = {}
  end

  def review_book(book, rating, review="")
    book.reviews[self.name] = [rating, review]  
    @reviews[book.title] = [rating, review]
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
    elsif borrower.books_checked_out.size >= 2
      nil
    elsif borrower.books_checked_out.any? {|x| x.due_date < Time.now}
      nil
    else
      book_out.borrower = borrower
      book_out.status = "checked_out"
      borrower.books_checked_out << book_out
      book_out.due_date = Time.now + (60 * 60 * 24 * 7 * 1)
      @available_books.delete(book_out)
      @borrowed_books << book_out
      book_out
    end
  end

  def get_borrower(book_id)
    book = @books.find {|x| x.id == book_id}
    book.borrower.name
    #book.due_date = nil
  end

  def check_in_book(book)
    if book.status == "available"
      nil
    else
      borrower = book.borrower
      borrower.books_checked_out.delete(book)
      book.borrower, book.due_date = nil
      @available_books.push(book)
      @borrowed_books.delete(book)
      book.status = "available"
    end
  end

end
