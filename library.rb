
class Book
  attr_accessor :author, :title, :id, :status

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
    @id = nil
  end

  def check_out
    if @status == 'checked_out'
      false
    else
      @status = 'checked_out'
    end
  end

  def check_in
    if @status == 'checked_out'
      @status = 'available'
    end
  end
end

class Borrower
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :books

  def initialize(name)
    @books = []
  end

  def register_new_book(book)
    book.id = rand()
    @books << book
  end

  def check_out_book(book, borrower)
    book.status = 'checked_out'
    return book
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
