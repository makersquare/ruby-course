
class Book
  attr_reader :author
  attr_reader :title
  attr_accessor :id
  attr_reader :status
  def initialize(title, author)
    @title = title
    @author = author
    @id = nil
    @status = 'available'
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
    else
      puts "u can't"
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
  attr_reader :books
  attr_reader :name
  def initialize(name)
    @name = name
    @books = []
    @bookidcount = 0
  end

  def add_book(title, author)
    book = (Book.new(title, author))
    @books.push(book)
    book.id = @books.length
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
