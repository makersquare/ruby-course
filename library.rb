class Book
  attr_reader :title, :author, :status
  attr_accessor :id, :borrower

  def initialize(title=nil, author=nil, id=nil, borrower=nil, status='available')
    @title = title
    @author = author
    @status = status
    @id = id
    @borower = borrower
  end


  def check_out
    if @status == 'available'
      @status = 'checked out'
      return true
    else
      return false
    end
  end

  def check_in
    if @status == 'checked out'
      @status = 'available'
      return true
    else
      return false
    end
  end

end

class Borrower
  attr_reader :name
  attr_accessor :num_books_checked_out
  def initialize(name)
    @name = name
    @num_books_checked_out = 0
  end
end

class Library
  @@id = 0
  attr_reader :books
  def initialize(name='nil')
    @books = []
  end

  def checked_out
    @checked_out
  end

  def register_new_book(title, author)
    @books << Book.new(title, author, @@id)
    @@id += 1
    @books.last
  end

  def get_borrower(book_id)
    book = @books.select {|x| x.id == book_id}[0]
    if book.status == 'available'
      return nil
    else 
      book.borrower.name
    end
  end

  def check_out_book(book_id, borrower)
    book = @books.select {|x| x.id == book_id}[0]
    if book.status == 'available' && borrower.num_books_checked_out < 2
      borrower.num_books_checked_out += 1
      book.borrower = borrower
      book.check_out
    end
  end

  def check_in_book(book_id)
    book = @books.select {|x| x.id == book_id}[0]
    if book.status == 'checked out'
      book.check_in
      book.borrower.num_books_checked_out -= 1
    end
  end

  def available_books
    @books.select {|x| x.status == 'available'}
  end

  def borrowed_books
    @books.select {|x| x.status == 'checked out'}
  end
end

