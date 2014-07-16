
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
    @borrowed = []
  end

  def books
    @books
  end

  def add_book(title, author)
    id = 111111 + Random.rand(1000000)
    @books << Book.new(title,author,id)
  end

  def check_out_book(book_id, borrower)
    @books.each do |book|
      if book_id == book.id
        @borrowed.push({ 
          name:borrower.name,
          id: book_id
        })
        test = book.check_out
        if test
          return book
        else
          return nil
        end
      end
    end
  end

  def get_borrower(book_id)
    @borrowed.find do 
      |book| book[:id] == book_id
      return book[:name]
    end
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
