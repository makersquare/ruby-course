
class Book

  def initialize(title, author, id=nil, status="available")
    @title = title
    @author = author
    @id = id
    @status = status
  end

  def author
    @author
  end

  def title
    @title
  end

  def id
    @id
  end

  def status
    @status
  end

  def check_out
    if @status == "available"
        @status = "checked_out"
        true
      elsif @status == "checked_out"
        false
      end
    end

    def check_in
      if @status == "checked_out"
        @status = "available"
      else
        "That isn't our book!"
      end
  end
end

class Borrower
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

class Library
  attr_writer :register_new_book
  def initialize(name)
    @books = []
    @checkouts = {}
  end

  def books
    @books
  end

  def register_new_book(title, author, id=nil)
    @books << Book.new(title, author, id)
  end

    def check_out_book(book_id, borrower)
    check = @books.find{|x| x.id == book_id}
      if check.check_out
        @checkouts[book_id] = borrower
        check
      end
  end

  def get_borrower(book_id)
    @checkouts[book_id].name
  end

  def check_in_book(book)
    book.check_in
    @checkouts.delete(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
