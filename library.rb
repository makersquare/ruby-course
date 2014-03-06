
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
  attr_accessor :book_count
  def initialize(name, book_count=0)
    @name = name
    @book_count = book_count
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

    if book.status == "checked_out"
      return nil
    elsif borrower.book_count > 0
      return nil
    else
    book.status = "checked_out"
    book.borrower = borrower
    book.borrower.book_count += 1
    return book
    end

  end

  def get_borrower(book_id)
    borrowed_book_id = @books.find {|bk| bk.id == book_id}
    return borrowed_book_id.borrower.name
  end

  def check_in_book(book)
    book.status = "available"
    @books << book
  end

  def available_books
    books.select { |book| book.status == "available"}
  end

  def borrowed_books
  end
end
