class Book
  attr_reader :title, :author, :id
  attr_accessor :status

  def initialize(title, author)
    @title = title
    @author = author
    @id = nil
    @status = 'available'
  end

  def status
    @status
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      return true
    else 
      return false
    end
  end

  def check_in
    @status = 'available'
  end
end
  
class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :name
  attr_accessor :books

  def initialize(name)
    @name = name
    @books = []
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
