
class Book
  attr_reader :author, :title
  attr_accessor :id, :status

  def initialize(title, author)
    @title = title
    @author = author
    @id = nil
    @status = 'available'
  end

  def check_out
    if @status == 'available' 
      @status = 'checked_out'
      return true
    elsif @status == 'checked_out'
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
  attr_reader :name, :books, :title, :author
  attr_accessor :id

  def initialize(name)
    @name = name
    @books = []
    @id = 0
  end

  def register_new_book(title, author)
    new_book = Book.new(title, author)
    new_book.id = @id
    @id += 1

    books.push(new_book)
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
