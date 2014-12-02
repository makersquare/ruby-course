
class Book
  attr_accessor :id
  attr_reader :author, :title, :status

  def initialize(title, author)
    @title = title
    @author = author
    @id = nil
    @status = 'available'
  end

  def check_out()
      if @status == "available"
        @status =  'checked_out'
        return true
    elsif @status ==  'checked_out'
      return false
    end
  end
  def check_in()
      if @status == "checked_out"
        @status =  'available'
        return true
    elsif @status ==  'available'
      return false
    end
  end
end

class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :name, :books, :borrowed_books

  def initialize(name)
    @name = name
    @books = []
    @borrowed_books = []
    @borrower = {}
  end

  def add_book(title, author)
    b = Book.new(title, author)
    b.id = b.hash()
    @books.push(b)
  end

  def check_out_book(book_id, borrower)
    book = find_book_by_id(book_id)
    r = book.check_out
    if r
      borrowed_books.push(book)
      @borrower[book_id] = borrower
      return book
    else
      return nil
    end 
  end
  def find_book_by_id(book_id)
    b = nil
    @books.each do |book|
      if book.id = book_id
        return book
      end
    end
  end
  def check_in_book(book)
  end

  def available_books
  end
  def get_borrower(book_id)
    return @borrower[book_id]
  end
end
