
class Book
  attr_reader :author, :title
  attr_accessor :status, :id

  def initialize(title, author, id=nil, status='available')
    @title = title
    @author = author
    @id = id
    @status = status
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      true
    else
      false
    end
  end

  def check_in
    if @status == 'checked_out'
      @status = 'available'
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
  attr_accessor :books, :name

  def initialize(name)
    @books = []
    @book_id = 0
  end

  def books
    @books
  end

  def register_new_book(book_object)
    book_object.id = @book_id +=1
    @books << book_object
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
