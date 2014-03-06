
class Book
  attr_accessor :borrower, :title, :author, :status, :id

  def initialize(title, author, id=nil, status="available", borrower="")
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
  attr_accessor :borrower_books
  def initialize(name)
  @name = name
  @borrower_books = []
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
    final_book = nil
    bookish = @books[book_id]
    if bookish.status == "available"
      if borrower.borrower_books.length < 2
        bookish.status = "checked_out"
        bookish.borrower = borrower
        borrower.borrower_books.push(bookish.title)
        final_book = bookish
      end
    end
    final_book
  end

  def get_borrower(book_id)
    book = books.find {|book| book.id == book_id}
    return book.borrower.name
  end


  def check_in_book(book)
    book.status = "available"
  end

  def available_books
    available_books = []
    available_books = books.select {|book| book.status == "available"}
    available_books
  end

  def borrowed_books
  end
end



