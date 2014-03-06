
class Book
  attr_accessor :borrower, :title, :author, :status, :id

  def initialize(title, author, status="available", borrower="", id=nil)
    @author = author
    @title = title
    @status = status
    @borrower = borrower
    @id = id
  end

  def check_out
      if @status == "available"
        @status = "checked_out"
        return true
      else
        false
      end
    end

    def check_in
      @status = "available"
    end
  end


class Borrower
  attr_reader :name
  def initialize(name)
  @name = name
  end
end

class Library
  attr_accessor :books

  def initialize
    @books = []
  end

  #def count
  #  @books.length
  #end

  def books
    @books
  end

  def register_new_book(title, author)
   books.push(Book.new(title, author, books.count))
  end



  def check_out_book(book_id, borrower)
    book = @books.find {|book| book.id == book_id}

    if (book.status == 'checked_out')
      return nil
    else
      book.status = 'checked_out'
      book.borrower = borrower
    end

    return book
  end

  def get_borrower(book_id)
    book = books.find {|book| book.id == book_id}
    return book.borrower.name
  end


  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
