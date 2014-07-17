# I COMMENTED THIS VERY POORLY. Sorry.
class Book
  attr_reader :author, :title, :id, :status, :borrower

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @id = id
    @status = 'available'
    @borrower = nil
  end

  def check_out(borrower=nil)
    if @status == 'checked_out'
      return false
    else
      @status = 'checked_out'
      @borrower = borrower
      return true
    end
  end

  def check_in
    if @status == 'available'
      return false
    else
      @status = 'available'
      @borrower = nil
      return true
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

  def initialize(name)
    @name = name
    @books = []
  end

  def register_new_book(title, author)
    @books.push(Book.new(title, author, id =(@books.count + 1)))
  end

  def get_borrower(req_id)
    @books.each do |x|
      if x.id == req_id
        return x.borrower.name
      end
    end
  end

  def check_out_book(book_id, borrower)
    books_in_possesion = 0
    @books.each do |x|
      if x.status == 'checked_out'
        return nil
      elsif x.borrower
        books_in_possesion += 1
          return nil if books_in_possesion >=2
      else 
        x.check_out(borrower)
        return x
      end
    end
  end

  def check_in_book(book)
    book.check_in
  end

  def available_books
    @books.select {|x| x.status == 'available'}
  end

  def borrowed_books
    @books.select {|x| x.status == 'checked_out'}
  end

end
