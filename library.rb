class Book
  attr_reader :author, :title, :id, :status
  def initialize(title="", author="")
    @title = title
    @author = author
    @id = nil
    @status = "available"

  def title=(title)
    @title=title
  end

  def author=(author)
    author=author
  end

  def status=(status)
    @status=status
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
    @status = "available"
  end
end

end
class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def name=(name)
    @name=name
  end


end

class Library
  attr_accessor :name
  attr_reader :books
  def initialize(name)
    @books = []
  end

  def books
    @books
  end


  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
