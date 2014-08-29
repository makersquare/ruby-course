
class Book
  attr_reader :title, :author, :id, :status

  def initialize(title=nil, author=nil, id=nil, status='available')
    @title = title
    @author = author
    @status = status
    @id = id
  end

  def check_out
    if status == 'available'
      @status = 'checked_out'
      return true
    else
      return false
    end
  end

  def check_in
    if status == 'checked_out'
      @status = 'available'
      return true
    else
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

  def initialize(name='nil')
    @books = []
    @id = 0
  end

  def books
    @books
  end

  def register_new_book(title, author)
    @id += 1
    @books << Book.new(title, author, @id)
  end

  def check_out_book(book_id, borrower)
    
  end

  def add_book
    @books
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end