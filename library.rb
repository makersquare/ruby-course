
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
      @borrower=nil
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
    @books.each do |book|
      if book.borrower == borrower
        return nil
      end
    end
      if @books[book_id].check_out(borrower)
        return @books[book_id]
      else
        nil
     end
  end

  def get_borrower(book_id)
    @books[book_id].borrower.name
  end

  def check_in_book(book)
    book.check_in()
  end

  def available_books
  end

  def borrowed_books
  end
end
