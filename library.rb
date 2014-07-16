
class Book
  attr_reader :author, :title, :id, :status

  def initialize(title, author, id= nil)
    @title = title
    @author = author
    @status = 'available'
    @id = id
  end

  def check_out
    if @status = "available"
      @status = "checked_out"
    end
  end

  def check_in
    if @status = "checked_out"
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
  attr_reader :books
  def initialize
    @books = []
  end

  def register_new_book(title, author)
    @books << Book.new(title, author, @id = (books.count + 1))
  end

  def check_out_book(book_id, borrower)
    @books.each do |x|
      if x.id == book_id
        x.check_out
        return x
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
