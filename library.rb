
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
  attr_accessor :book_count

  def initialize(name)
    @name = name
    @book_count = 0
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
        if borrower.book_count < 2
          borrower.book_count += 1
          x.status = "checked_out"
          x.borrower = borrower.name
          x
        else
          nil
        end
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
    num = books.select {|x| x.status == 'available'}
    num
  end

  def borrowed_books
    num = books.select {|x| x.status == 'checked_out'}
    num
  end
end
