class Book
  attr_accessor :author, :title, :id, :status

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @id = id
    @status = 'available'
  end


  def checkout
    if @status == 'available'
       @status = 'checked_out'
       true
    else 
       false 
    end 
  end

  def checkin
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
  attr_accessor :books, :borrowers, :available_books
  def initialize
    @books = []
    @borrowered_books = []
    @available_books = []
  end


  def register_new_book(title, author)
    new_book_regist = Book.new(title, author)
    @books << new_book_regist 
    new_book_regist.id = @books.index(new_book_regist)+1
  end 
  
  # def add_book(title, author)

  # end
  def checkout_book(book_id, borrower)
      book_borrower_with_id = @borrowered_books.find {|borrower| borrower.has_key?(book_id)}
      if book_borrower_with_id == nil 
      #     book_borrowed = @borrowers.map {|book| book.id == book_id}
          # if x == []
          #   return "sorry no books found"
          # elsif  x.size 

          # else  
          if @books[book_id-1]!= nil
              @borrowered_books << {book_id => borrower}
              # z = @books.find {|book| book.id == book_id}
              # @available_books.delete!(z)
              @books[book_id-1].status = 'checked_out' 
              @books[book_id-1]
            else 
              nil 
            end 

      else  
            nil
      end
  end

  def get_borrower(book_id)
    book_borrower = @borrowered_books.find{|borrower| borrower.has_key?(book_id)}
    if book_borrower == nil
      return "no borrower took the book with the given id"
    else 
      book_borrower[book_id].name
    end 
  end


  def check_in_book(book)
    x = @borrowered_books.find {|y| y.has_key?(book.id)}
    if x == nil 
      return "sorry no books found"
    else 
      book.status = 'available' 
    end 
  end


  def available_books
    borroweded_books_ids = @borrowered_books.map {|item| item.keys}

    @available_books = @books.delete_if {|book| borroweded_books_ids.include?(book.id)}
end

  # def borrowed_books
  # end
end

book1 = Book.new("title 1", "author 1")
# book2 = Book.new("title 2", "author 2")
# book3 = Book.new("title 3", "author 3")



nyc_library = Library.new
nyc_library.register_new_book("title 1", "author 1")
nyc_library.register_new_book("title 2", "author 2")

p nyc_library.books

cristina = Borrower.new('cristina')
p nyc_library.checkout_book(1, cristina)

p nyc_library.available_books






