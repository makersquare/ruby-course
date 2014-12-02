
class Book
  attr_reader :author
  attr_reader :title
  attr_accessor :id
  attr_accessor :status

  def initialize(title, author)
    @author = author
    @title = title
    @status = 'available'
  end

  def check_out
    if (@status == 'available')
      @status = 'checked_out'
      return true
    else
      return false
    end
  end

  def check_in
    if (@status == 'checked_out')
      @status = 'available'
      return true
    else
      return false
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
attr_reader :books
attr_reader :name
attr_reader :next_id
attr_accessor :borrowers


  def initialize(name)
    @books = []
    @next_id = 1
    @borrowers = {}
    @name = name
    
  end

  def register_new_book(title, author)
      new_book = Book.new(title,author)
      new_book.id = @next_id
      @next_id += 1

      books.push(new_book)
  end

  def check_out_book(book_id, borrower)
    if (!borrowers.has_value?(borrower.name))
      books.each do |book|
        if (book.id == book_id && book.status == 'available')
           @borrowers[:book_id] = borrower.name
           book.status = 'checked_out'
           return book
        else
          return nil
        end
      end
    end
  end

  def check_in_book(book)

    books.each do |b|
      if (b == book && book.status == 'checked_out')
         book_id = b.id
         @borrowers[:book_id] = nil
         book.status = 'available'
         return book
      else
        return nil
      end
    end

  end

  def get_borrower(book_id)
    return @borrowers[:book_id]
  end

  def available_books
    avail = []

    books.each do |b|
      if (b.status == 'available')
       avail.push(b)
      end
    end
    return avail
  end

  def borrowed_books
    checked = []

    books.each do |b|
      if (b.status == 'checked_out')
       checked.push(b)
      end
    end
    return checked
  end
end
