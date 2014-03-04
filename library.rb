
class Book
  attr_reader :author, :title, :id, :status, :borrower

  def initialize(title="", author="",id=nil)
    @title = title
    @author = author
    @status = "available"
    @id = id
  end

  def check_out(borrower=nil)
    if @status == "available"
      @status="checked_out"
      @borrower = borrower
      return true
    else
      false
    end
  end

  def check_in()
    if @status == "checked_out"
      @status="available"
      return true
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

  def initialize(name="")
    @books = []
  end

  def register_new_book(name,author)
    @books.push(Book.new(name,author,@books.count))
  end

  # def books
  # end

  # def add_book(title, author)
  # end

  def check_out_book(book_id, borrower)
    if @books[book_id].check_out(borrower)
      return @books[book_id]
    else
      false
    end
  end

  def get_borrower(book_id)
    @books[book_id].borrower.name
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
