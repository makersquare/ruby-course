
class Book
  attr_accessor :id, :status, :borrower
  attr_reader :author, :title


  def initialize(title, author, status='available')
    @title = title
    @author = author
    @status = status
    @id = nil
    @borrower = nil
  end

  def status
    @status
  end

  def check_out
    if @status != "checked_out"
      @status = "checked_out"
      true
    else
      false
    end
  end

  def check_in
    if @status == "checked_out"
      @status = "available"
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
  attr_accessor :books, :available, :borrowed

  def initialize
    @books = []
    @books_borrowed = []
  end

  def add_book(title, author)
    new_book = Book.new(title, author)
    @books << new_book
    new_book.id = @books.length - 1
  end

  def check_out_book(book_id, borrower)
    if @books_borrowed.length < 2
      if (@books[book_id].status == 'available')
        @books[book_id].status = "checked_out"
        @books[book_id].borrower = borrower
        @books_borrowed << borrower
        @books[book_id]
      end
    end
  end

  def get_borrower(book_id)
    @books[book_id].borrower.name
  end

  def check_in_book(book)
    book.status = 'available'
  end

  def available_books
    @books.select { |book|
      if book.status == 'available'
        book
      end
    }
  end

  def borrowed_books
    @books.select { |book|
      if book.status == 'checked_out'
        book
      end
    }

  end
end
