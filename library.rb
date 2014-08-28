
class Book
  attr_reader :author, :title, :id, :status, :borrower
  # @borrower = []
  def initialize(title='', author='', id=nil)
    @author = author
    @title = title
    @id = id
    @status = "available"
  end

  def check_out(borrower='')
    return false if (@status == 'checked_out')
    @borrower = borrower
    @status = 'checked_out'
  end

  def check_in
    return false if (@status == 'available')
    @status = 'available'
  end
end

class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :id, :title, :author
  def initialize(name='Presidential Library')
    @books = []
  end

  def books
    @books
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    return nil if @books[book_id-1].status == 'checked_out'
    @books[book_id-1].check_out(borrower)
    @books[book_id-1]
  end

  def get_borrower(id)
    @books[id-1].borrower.name
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
  def register_new_book(title,author)
    @books<< Book.new(title,author,@books.count+1)
    # @title = title
    # @author = author
    # @@id[@id.count+1]=newbook
  end
end
