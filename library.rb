
class Book
  attr_accessor :status, :borrower, :status, :year_published, :edition
  attr_reader :author, :title, :id

  def initialize(title=nil, author=nil, id=nil, borrower=nil)
    @title = title
    @author = author
    @id = id
    @status = 'available'
    @borrower = borrower
    @year_published = nil
    @edition = nil
  end

  def check_out
    if @status == "available"
      @status = "checked_out"
      true
    else
      false
    end
  end

  def check_in
    if @status == "checked_out"
      @status = "available"
      true
    else
      false
    end
  end
end

class Borrower
  attr_reader :name
  attr_accessor :books

  def initialize(name)
    @name = name
    @books = {}
  end

  def leave_review(book, review)
    @books[book.title][:review] = review
  end
end

class Library
  attr_reader :books
  @@id = 0

  def initialize()
    @books = []
  end

  def register_new_book(title, author)
    @@id += 1
    @books.push(Book.new(title, author, @@id))
  end

  def check_out_book(book_id, borrower)
    book = @books.select { |book| book.id == book_id }.first
    if book.status == "available" && borrower.books.length < 2
      book.check_out
      borrower.books[book.title] = {
        review: nil,
        days_until_due: 7
      }
      book.borrower = borrower
      book
    else
    end
  end

  def get_borrower(book_id)
    book = @books.select { |book| book.id == book_id }.first
    book.borrower.name
  end

  def check_in_book(book)
    book.check_in
    book.borrower.books.delete(book)
    book.borrower = nil
  end

  def available_books
    available = @books.select { |book| book.status == "available" }
  end

  def borrowed_books
    borrowed = @books.select { |book| book.status == "checked_out" }
  end
end

class Time
  def self.elapse_days(days, lib)
    borrowers_books_array = lib.books.select { |book| book.borrower != nil }
    borrowers_book = borrowers_books_array.each { |book| book }
    borrowers_book.each { |book| book.borrower.books[book.title][:days_until_due] -= days }
  end
end
