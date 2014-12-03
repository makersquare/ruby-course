class Book
  attr_reader :author, :title
  attr_accessor :status, :id

  # status fields
  CHECKED_OUT = 'checked_out'
  AVAILABLE   = 'available'

  def initialize(title, author)
    @author = author
    @title = title
    @id = nil
    @status = AVAILABLE
  end

  def available?
    @status == AVAILABLE
  end

  def check_out?
     @status == CHECKED_OUT
  end 

  def check_out
    if @status == AVAILABLE 
      @status = CHECKED_OUT
      return true 
    else @status = CHECKED_OUT
      return false
    end
  end

  def check_in
    if @status = CHECKED_OUT
      check_out = false
      @status = AVAILABLE 
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
  attr_reader  :name
  attr_accessor :borrowed_books, :available_books
  
  def initialize(name)
    @name = name
    @books = []
    @id = 0
    @borrowed_books = {}
    @available_books = []
  end

  def books
    @books
  end

  def add_book(title, author)
    @id +=1
    b = Book.new(title, author)
    b.id = @id 
    @books << b
    @available_books << b
  end

  def check_out_book(book_id, borrower)
    b = @books.find{ |x| x.id == book_id} #find book by id
    @borrowed_books[borrower.name] ||= []
    if (b.available? && @borrowed_books[borrower.name].size < 2)
      @borrowed_books[borrower.name] << book_id
      b.check_out
      @available_books.delete(b)
      return b
    else 
      return nil
    end 
  end

  def get_borrower(book_id)
     @borrowed_books.keys{|k,v| v.include? book_id }.first 
  end

  def check_in_book(book)
    if book.check_out? 
      @available_books << book
      book.check_in
      bor = self.get_borrower(book.id)
      @borrowed_books.delete(bor)
    end
  end

  def borrow_books
    borrow_books = []
    @books.each do |b| 
      if  b.check_out?
        borrow_books << b
      end
    end
    borrow_books
  end

end