
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
  attr_reader :name, :books
  def initialize(name)
    @name = name
    @books = []
  end

  def add_book(title, author)
    b = Book.new(title, author)
    b.id = b.hash()
    @books.push(b)
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
