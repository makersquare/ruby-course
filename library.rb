
class Book
  attr_accessor :status
  attr_reader :author, :title, :id

  def initialize(title=nil, author=nil, id=nil)
    @title = title
    @author = author
    @id = id
    @status = 'available'
  end

  def status
    @status
  end

  def check_out
    if @status == "available"
      @status = "checked_out"
      true
    else
      false
    end
  end

  def check_in
    if @status == "checked_out"
      @status = "available"
      true
    else
      false
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
  @@id = 0

  def initialize()
    @books = []
  end

  def register_new_book(title, author)
    @@id += 1
    @books.push(Book.new(title, author, @@id))
  end


  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    book = @books.select { |book| book.id == book_id }.first
    book.check_out
    book
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
