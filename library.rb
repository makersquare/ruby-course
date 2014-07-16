
class Book
  attr_reader :author, :title, :id
  attr_accessor :status

  def initialize(title, author, id = nil, status = 'available')
    @title = title
    @author = author
    @id = id
    @status = status
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
        x
      elsif x.id == book_id && x.status == "checked_out"
        puts "Can't check it out, it's already gone dude!"
      else
        puts "Don't have that"
      end
    end

  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
