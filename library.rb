require 'pry-byebug'
class Book
  attr_reader :author, :title, :id, :status, :borrower, :year_published, :edition
  attr_accessor :review
  def initialize(title,author,year_published=1800,edition='1st')
    @author = author
    @title = title
    @id = nil
    @status = "available"
    @year_published = year_published
    @edition = edition
    @review = {}
  end

  def check_out
    return false if @status == "checked_out"
    @status = "checked_out" if @status == "available"

  end

  def check_in
    @status = "available" if @status == "checked_out"
  end

  def overdue?
  end

  def available?
    return true if @status == "available"
  end

  def change_id(x)
    @id = x
  end

end

class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def leave_review
  end


end

class Library
  @@counter = 0 
  
  attr_reader :books, :name, :book_status
  def initialize(name="library")
    @name = name
    @books = []
    @book_status = {}  
  end

  def book_by_id
  end

  def books
    @books
  end

  def add_book(book_instance)
    @@counter += 1
    book_instance.change_id(@@counter)
    @books.push(book_instance)
    @book_status[@@counter.to_s]={book:book_instance}
  end

  def check_out_book(book_id,borrower)
    return nil if self.more_than_two?(borrower)
    return nil if !@book_status[book_id.to_s][:book].check_out
    @book_status[book_id.to_s][:book].check_out
    @book_status[book_id.to_s][:borrower] = borrower
    @book_status[book_id.to_s][:book] 
  end

  def get_borrower(book_id,ind='name')
    return @book_status[book_id.to_s][:borrower] if ind =='id'
    return @book_status[book_id.to_s][:borrower].name if ind == 'name'
  end

  def check_in_book(book)
    book.check_in
  end

  def available_books
    @books.select {|x| x.available?}
  end

  def borrowed_books
    @books.select {|x| !x.available?}
  end

  def register_new_book(title,author)
    new_book_instance = Book.new(title,author)
    add_book(new_book_instance)
  end

  def more_than_two?(borrower)
    array = self.borrowed_books.map {|x| x.id}
    array2 = array.map {|x| self.get_borrower(x,'id')}
    array2.count(borrower) >=2 ? true : false



  end

end