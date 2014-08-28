
class Book
  attr_reader :author, :title, :id, :status, :borrower
  attr_accessor :review, :rating, :edition, :year_published
  def initialize(title='', author='', id=nil,year=1800, edition='1st')
    @author = author
    @title = title
    @id = id
    @status = ["available",0]
    @year_published = year
    @edition = edition
    @review = {}
    @rating = {}
  end

  def check_out(borrower='')
    return false if (@status[0] == 'checked_out')
    @borrower = borrower
    @status[0] = 'checked_out'
    @status[1] = Time.now
  end

  def check_in
    return false if (@status[0] == 'available')
    @status[0] = 'available'
    @borrower = 'available'
  end
end

class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def leave_review(library,book_id,review='n/a',rating=10)
    library.books[book_id-1].review[self] = review
    library.books[book_id-1].rating[self] = rating
  end
end

class Library
  attr_reader :id, :title, :author
  def initialize(name='Presidential Library')
    @books = []
  end

  def books
    @books
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    return nil if @books[book_id-1].status[0] == 'checked_out'
    member = @books.map {|x| x.borrower}
    return nil if member.count(borrower)>=2

    
      # member.each do |x|
      # return nil if (x.status[1] - Time.now) > 24*60*24*7*60
      # end

    @books[book_id-1].check_out(borrower)
    @books[book_id-1]
  end

  def get_borrower(id)
    @books[id-1].borrower.name
  end

  def check_in_book(book)
    book.check_in
  end

  def available_books
    avail = @books.select{|x| x.status[0] == "available"}
  end

  def borrowed_books
    borr = @books.select{|x| x.status[0] == 'checked_out'}
  end
  def register_new_book(title,author)
    @books<< Book.new(title,author,@books.count+1)
    # @title = title
    # @author = author
    # @@id[@id.count+1]=newbook
  end
end
