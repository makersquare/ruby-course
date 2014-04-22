
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
  attr_reader :books, :borrowers

  def initialize(name)
    @books = []
    @borrowers = {}
  end

  def register_new_book(book)
    book.id = rand()
    @books << book
  end

  def check_out_book(book, borrower)
    if book.status == 'available'
      book.status = 'checked_out'
      @borrowers[book.title] = borrower.name
      return book
    end
  end

  def get_borrower(book)
    @borrowers[book.title]
  end

  def check_in_book(book)
    @borrowers.delete(book.title)
    book.status = 'available'
  end

  def available_books
  end

  def borrowed_books
  end
end
