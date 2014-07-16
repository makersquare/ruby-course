
class Book
  attr_accessor :title, :author, :id, :status

  def initialize(title, author, id=nil)
    @title = title
    @author = author
    @id = id
    @status = 'available'
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      true
    else
      return false
    end
  end

  def check_in
    if @status == 'checked_out'
      @status = 'available'
      true
    else
      return false
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
  attr_accessor :books, :name, :id
  
  def initialize
    @books = []
    @id_tab = 0
    @borrowers = {}
    @book_tracker = {}

  end
# @@ people << { name: name, id: @@person_counter }
  # def books
  # end
  def register_new_book(title, author, id=@id_tab)
    @books << Book.new(title, author, id)
    @id_tab += 1
  end


  def add_book(title, author)

  end

  def check_out_book(book_id, borrower, count=0)
   # if @borrowers.key

    if @books[book_id].status == 'checked_out'
      return nil
    else
      @books[book_id].status = 'checked_out'
      @borrowers[borrower.name] = @books[book_id]
    end

    #id => borrower
    #sam => id
  end

  def get_borrower(book_id)
    @borrowers.key(@books[book_id])
  end

  def check_in_book(book)
    book.check_in
  end

  def available_books
    @books.select { |book| book.status == 'available'}
    
  end

  def borrowed_books
    @books.select { |book| book.status == 'checked_out'}
  end
end
