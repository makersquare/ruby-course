
class Book
  attr_reader :title, :author, :status
  attr_accessor :id

  def initialize(title=nil, author=nil, id=nil, status='available')
    @title = title
    @author = author
    @status = status
    @id = id
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
    if @status == 'checked_out'
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
  @@checked_out = {}
  def initialize(name='nil')
    @books = []
    @id = books.length
  end

  def books
    @books
  end

  def register_new_book(title, author)
    @books << Book.new(title, author, @id)
    @id += 1
  end

  def get_borrower(book_id)
    @@checked_out[book_id].name
  end

  def check_out_book(book_id, borrower)
    if @books[book_id].status == 'available'
      @books[book_id].check_out
      @@checked_out[book_id] = borrower
    end
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

