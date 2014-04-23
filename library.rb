
class Book
  attr_accessor :id, :status, :title, :author, :borrower
  attr_reader :year_published, :edition

  def initialize(title, author, options = {})
    @author = author
    @title = title
    @status = "available"
    @borrower = nil
    @year_published =
      case options[:year_published]
      when Fixnum then options[:year_published]
      when String then options[:year_published].to_i
      else nil
      end
    @edition =
      case options[:edition]
      when String then options[:edition].to_i
      when Fixnum then options[:edition]
      else nil
      end
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

class Borrower
  attr_reader :name
  attr_accessor :book_count

  def initialize(name)
    @name = name
    @book_count = 0
  end
end


class Library
  @@book_id_counter = 0

  def initialize(name='default_library_name', books=[])
    @name = name
    @inventory = books
  end

  def books
    @inventory
  end

  def register_new_book(book)
    @@book_id_counter += 1
    book.id = @@book_id_counter
    @inventory << book
  end

  def check_out_book(book_id, borrower)
    b = @inventory.select {|book| book.id == book_id}
    book = b.first
    if (borrower.book_count < 2) && (book.status == "available")
      book.check_out
      book.borrower = borrower
      borrower.book_count += 1
      book
    else
      nil
    end
  end

  def check_in_book(book)
    if book.status == "checked_out"
      book.status = "available"
      book.borrower = nil
    end
  end

  def available_books
    @inventory.select {|book| book.status == "available"}
  end

  def borrowed_books
    @inventory.select {|book| book.status == "checked_out"}
  end

  def get_borrower(book_id)
    book = @inventory.select {|book| book.id == book_id }
    book.first.borrower.name
  end
end
