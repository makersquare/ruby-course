
class Book
  attr_reader :author, :title, :id
  attr_accessor :status, :borrower

  def initialize(title, author, id = nil, status = 'available')
    @title = title
    @author = author
    @id = id
    @status = status
    @borrower = :no_one
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
  attr_reader :books

  def initialize(name)
    @books = []
    @name = name
    @@id_counter = 0
  end

  def register_new_book(title, author)
    @@id_counter += 1
    added = Book.new(title, author, @@id_counter)
    @books << added
  end

  def created_book(title, author, id)

  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    @books.find do |x|
      if x.id == book_id && x.status == "available"
        x.status = "checked_out"
        #borrower.books.push(x.book_id)
        x.borrower = borrower.name
        x
      elsif x.id == book_id && x.status == "checked_out"
        nil
      else
        puts "Don't have that"
      end
    end
  end

  def get_borrower(book_id)
    dude = @books.find {|x| x.id == book_id}
    dude.borrower
  end

  def check_in_book(book)
    book.status = 'available'
    book.borrower = :no_one
  end

  def available_books
  end

  def borrowed_books
  end
end
