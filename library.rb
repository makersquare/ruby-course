
class Book
  attr_accessor :author, :title, :id, :status

  def initialize(title, author, status: 'available')
    @title = title
    @author = author
    @status = status
    @id = nil
  end

  def check_out()
    if status == 'available'
      @status = 'checked_out'
      true
    else
      false
    end
  end

  def check_in()
    if status == 'checked_out'
      @status = 'available'
    end
  end

end

class Borrower

  attr_accessor :name

  def initialize(name)
    @name = name
  end

end

class Library
  attr_accessor :books, :book_ids_to_borrowers

  def initialize(name)
    @books = []
    @book_ids_to_borrowers = {}
  end

  def count
    @books.size
  end

  # replaced w. attr_accessor
  # def books
  # end

  def add_book(title, author)
    new_book = Book.new(title, author)
    new_book.id = 1 + rand(100000000)
    books << new_book
  end

  def check_out_book(book_id, borrower)

    found_book = nil
    books.each do |x|
      if x.id == book_id
        found_book = x
      end
    end
    
    borrowers = book_ids_to_borrowers.values

    if borrowers.include?(borrower)
      return nil
    end
    
    if found_book != nil
      checked_out = found_book.check_out
    end
    
    if checked_out
        book_ids_to_borrowers.store(found_book.id, borrower)
        return found_book
    else
      return nil
    end
  end


  def check_in_book(book)
    book.status = 'available'
  end

  #array of available books
  def available_books
    ids = book_ids_to_borrowers.keys
    available_books = books.select {|x| ids.include?(x.id) == false }
  end

  def borrowed_books
    ids = book_ids_to_borrowers.keys
    borrowed_books = books.select {|x| ids.include?(x.id) == true }
  end

  def get_borrower(book_id)
    book_ids_to_borrowers[book_id].name
  end

end
