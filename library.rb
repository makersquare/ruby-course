
class Book

  attr_reader :author, :title, :id, :status

  def initialize(title, author,id=nil, status='available')
    @title = title
    @author = author
    @id = id
    @status = status
  end

  def check_out
    if @status == 'available'
      @status.gsub!(/\bavailable\b/,'checked_out')
      true
    else
      false
    end
  end

  def check_in
    if @status == 'checked_out'
      @status.gsub!(/\bchecked_out\b/,'available')
      true
    else
      false
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
  attr_reader :name

  def initialize(name)
    @name = name
    @books = []
  end

  def books
    @books
  end

  def add_book(title, author)
    @books << Book.new(title,author)
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
