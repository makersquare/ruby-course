
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
    @books_checked = {}
    @names = []


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
    if @books[book_id].status == 'checked_out'
      return nil
    else
      @names << @books_checked.values #setting array equal to values in @books_checked {  }
      @pointer = 0
      @names.select do |name|
        if name == borrower.name
          @pointer += 1
        end
      end
      if @pointer < 2
        @books[book_id].check_out
        @books_checked[book_id] = borrower
        @borrowers[borrower.name] = @books[book_id]
      else
        return nil
      end

    end
    #id => borrower
    #sam => id
    # books_checked = 0
    # @books.each do |x|
    #   if x.status == 'checked_out'
    #     return nil
    #   elsif x.borrower
    #     books_checked += 1
    #       return nil if books_checked >= 2
    #   else
    #     x.check_out(borrower)
    #     return x
    #   end
    # end
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
