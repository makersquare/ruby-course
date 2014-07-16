
class Book
  attr_reader :author, :title, :id, :status

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @id = id
    @status = 'available'
  end

  def check_out
    if @status == 'checked_out'
      return false
    else
      @status = 'checked_out'
    end
  end

  def check_in
    if @status == 'available'
      return false
    else
      @status = 'available'
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
  attr_reader :books

  def initialize(name)
    @name = name
    @books = []
  end

  def register_new_book(title, author)
    @books << Book.new(title, author, id =(@books.count + 1))
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
