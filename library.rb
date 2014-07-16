
class Book
  attr_reader :author

  def initialize(title, author,id=nil,status=:available)
    @title = title
    @author = author
    @id = id
    @status = status
  end

  def title
    @title
  end

  def status
    @status
  end

  def id
    @id
  end

  def check_out
    if @status == :available
      @status = :checked_out
      true
    elsif @status 
      false
    end
  end

  def check_in
    @status = :available
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
  def initialize(name)
    @books = []
    @checkouts = {}
  end

  def books
    @books
  end

  def register_new_book(title,author,id)
    @books << Book.new(title,author,id)
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    hold = @books.find{|x| x.id == book_id}
    if @checkouts.find_all{|k,v| v == borrower}.count >= 2
      return nil
    elsif hold.check_out
      @checkouts[book_id] = borrower
      @books.drop(book_id)
      hold
    end
  end

  def get_borrower(book_id)
    @checkouts[book_id].name
  end

  def check_in_book(book)
    book.check_in
    @books << book
    @checkouts.delete_if{|k,v| k == book.id}
  end

  def available_books
    available_books = @books.delete_if{ |x| @checkouts.has_key?(x.id) }
    available_books
  end

  def borrowed_books
    borrowed_books = @books.select{ |x| @checkouts.has_key?(x.id) }
    borrowed_books
  end
end
