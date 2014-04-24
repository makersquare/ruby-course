
class Book
  attr_reader :author, :title
  attr_accessor :id, :status, :borrower


  def initialize(title, author, id=nil)
    @title = title
    @author = author
    @borrower = nil
    @status = "available"
  end

  def check_out

    if @status == "available"
      @status = "checked_out"
      return true
    else
      return false
    end
  end

  def check_in
    if @status == "checked_out"
      @status = "available"
    end
  end
end


class Borrower

  attr_accessor :name
  attr_accessor :books

  def initialize(name)
    @name = name
    @books =[]
  end
end

class Library

  attr_accessor :books, :name, :id

  def initialize(name)
    @books = []
    @count = 0

  end

  def register_new_book(book)
    @count +=1
    book.id = @count
    @books << book

  end

  def check_out_book(book_id, borrower)
    selected_book = @books.find {|book| book.id == book_id}

    if selected_book && selected_book.status == "checked_out" || borrower.books.count > 1
      return nil
    end

    if selected_book && selected_book.status == "available"
      selected_book.borrower = borrower
      selected_book.status = "checked_out"
      borrower.books << selected_book
      return selected_book
    else
      return "That book doesn't exist!"
    end

  end

  def get_borrower(book_id)
    selected_book = @books.find {|book| book.id == book_id}
    the_borrower = selected_book.borrower if selected_book
    the_borrower.name if the_borrower
  end

  def check_in_book(book)
    if book.status == "checked_out"
      book.status = "available"
    end
  end

  def available_books
    @books.select {|book| book.status =="available"}
  end

  def borrowed_books

    @books.select {|book| book.status ="checked_out"}
  end
end
