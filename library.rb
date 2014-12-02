

class Book
  attr_reader :author, :title 
  attr_accessor :id, :status, :borrower

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
    @borrower
  end

  def check_out
    if @status == "available"
      @status = "checked_out"
      return true
    else 
      return false
    end
  end

  def check_in
    if @status == "checked_out"
      @status = "available"
    end
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
  attr_accessor :books
  attr_reader :name

  @@book_id_counter = 0

  def initialize(name)
    @name = name
    @books = []
    @available_books = []
  end

  # def books
  # end
  def register_new_book(title, author)
    created_book = Book.new(title, author)
    @books << created_book
    @@book_id_counter += 1
    created_book.id = @@book_id_counter
  end
  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    book = @books.select { |x| x if x.id == book_id }[0]
    if book.status == "available" && (borrower.borrowed.length < 2)
      book.check_out
      book.borrower = borrower
      borrower.borrowed << book
      book
    else
      return nil
    end

  end

  def get_borrower(book_id)
    book = @books.select { |x| x if x.id == book_id }[0]
    book.borrower.name
  end

  def check_in_book(book)
    book.check_in
    book.borrower = nil
    book
  end

  def available_books
    avail = @books.map { |x| x if x.status == "available"}
    avail.compact!
    avail
  end

  def borrowed_books
    bor = @books.map { |x| x if x.borrower }
    bor.compact!
    bor
  end
end
