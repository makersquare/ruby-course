
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
  attr_reader :name, :books, :title, :author, :id

  def initialize(name)
    @name = name
    @books = []
    @lib_id = 0
    @borrowers = {}
  end

  def register_new_book(title, author)
    new_book = Book.new(title, author)
    new_book.id = @lib_id
    @lib_id += 1

    books.push(new_book)
  end

  def check_out_book(book_id, borrower)
    books.each do |book|
      if book.id == book_id && book.status == 'available'
        @borrowers[:book_id] = borrower
        book.status = 'checked_out'
        return book
      end
    end
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
