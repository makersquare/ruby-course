
class Book

  attr_reader :author, :title, :id

  attr_accessor :status

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @id = id
    @status = 'available'
  end

  def check_out
    if @status == 'checked_out'
       return false
    else
      @status = 'checked_out'
      true
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

  def initialize
    @books = []
    @last_id = 0
    @borrowers_hash = {}
  end

  def books
    @books
  end

  def register_new_book(title, author)
    @last_id += 1
    @books << Book.new(title, author, id=@last_id)

  end

  def check_out_book(book_id, borrower)
   
      book = @books.find  do |book|
        book.id == book_id
      end

      if !(@borrowers_hash.values.include?(borrower.name)) && book.check_out
        @borrowers_hash[book.id] = borrower.name
        book
      else
       nil
      end
    
  end

  def get_borrower(book_id)
    @borrowers_hash[book_id]
  end


  def check_in_book(book)
    book.status = 'available'
    @borrowers_hash[book.id] = nil
  end

  def available_books
    @books.select {|book| book.status == 'available'}
  end

  def borrowed_books
    @books.select {|book| book.status == 'checked_out'}
  end
end
