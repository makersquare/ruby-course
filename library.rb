
class Book
  attr_reader :title, :author
  attr_accessor :status, :id, :borrower

  def initialize(title, author)
    @title = title
    @author = author
    @status = "available"
  end

  def check_out
    if @status == "checked_out"
      return false
    else
    @status = "checked_out"
    end
    return true
  end

  def check_in
    @status = "available"
  end
end

class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :books
  def initialize(name)
    @books = []
  end

  def register_new_book(title, author)
    book = Book.new(title, author)
    @books << book
    book.id = books.count
  end

  def check_out_book(book_id, borrower)
    book = books.find { |bk| bk.id == book_id }
    book.status = "checked_out"
    book.borrower = borrower
    return book
  end

  def get_borrower(book_id)
    borrowed_book_id = @books.find {|bk| bk.id == book_id}
    return borrowed_book_id.borrower.name
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
