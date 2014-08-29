
class Book
  attr_reader :author, :title
  attr_accessor :status, :id

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @status = 'available'
    @id = rand(999...9999)
  end
  
  # def id 
  #   @id = rand(999...9999)
  # end
  
  def check_out
    if @status == 'available'
      self.status=('checked_out')
      true
    else
      return false 
    end
  end

  def check_in
    self.status=('available')
  end

end

class Borrower
  attr_reader :name
  
  def initialize(name, num_books= [])
    @name = name
    @num_books = num_books
  end
  def num_book(book_id)
    @num_books << book_id
  end
end

class Library
  attr_accessor :books, :title
  def initialize
    @books = []  
  end
  def register_new_book(title, author)
    @books << Book.new(title, author)
  end

  def books
    @books
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    needed = @books.select { |book| book.id == book_id }.first
    needed.check_out
    borrower.num_book(book_id)
    needed 
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
