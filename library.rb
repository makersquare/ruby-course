class Book
  attr_accessor :author, :title, :id, :status

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
    else
      false
    end
  end

  def check_in
    @status = "available"
  end
end

class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
    @borrowed_books = []
  end

  def borrow_book(book)
    @borrowed_books.push(book)
  end
end

class Library
  attr_accessor :books, :borrowers_books
  def initialize(name)
    @books = []
    @borrowers_books = {}
  end

  def books=(book)
    @books.push(book)
  end

  def add_book(title, author)
    @books.unshift(Book.new(title, author, rand(20000).to_s))
  end

  def check_out_book(book_id, borrower)
    found_book = nil
    @books.each do |book| 
      if book.id == book_id  && book.status != "checked_out"
        book.status = "checked_out"
        borrower.borrow_book(book)
        @borrowers_books[book.id] = borrower.name #jimmy helped some with this
        found_book = book
      end
    end
  found_book
end

  def check_in_book(book)
  end

  def get_borrower(book_id)
    @borrowers_books[book_id] #Professor Nick helped me with this - big time.
  end


  def available_books
  end

  def borrowed_books
  end
end
