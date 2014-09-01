
# I wrote program to accept a the test code pretty close to as it was written. The biggest change I made was
# having the original checkout method two different methods, one to create the book and the second to check it out.
# The original test code didn't assign the new books as variables and creating a dynamic variable name that I could
# later call on proved to be a bit difficult. I decided to store the instanes in an array, in which the index was the 
# same as the new ID. It works, but after seening your solution of just assigning the variables in the test code, I could
# have definitely simplified things. I went back and forth as to whether I should store available/checked out books in 
# seperate new arrays, as I think it would be quicker to call upon and return a result in the case of a large number of books, 
# as opposed checking the status of each book contained in a hash, which is why I originally went with the 2 arrays. I might 
# come back and play with this once I finish the puppy breeding assignment.  

class Book
  attr_reader :title, :author, :status
  attr_accessor :id

  def initialize(title=nil, author=nil, id=nil, status='available')
    @title = title
    @author = author
    @status = status
    @id = id
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      return true
    else
      return false
    end
  end

  def check_in
    if @status == 'checked_out'
      @status = 'available'
      return true
    else
      return false
    end
  end

end

class Borrower
  attr_reader :name
  attr_accessor :num_books_checked_out
  def initialize(name)
    @name = name
    @num_books_checked_out = 0
  end
end

class Library
  attr_reader :books, :checked_out, :available_books, :borrowed_books
  def initialize(name='nil')
    @books = []
    @id = books.length # should be set to 0, but becomes buggy when testing, id is assigned
    @checked_out = {} # book_id => borrower
    @available_books = []
    @borrowed_books = []
  end

  def checked_out
    @checked_out
  end

  def register_new_book(title, author)
    @books << Book.new(title, author, @id)
    @available_books << @books.last
    @id += 1
  end

  def get_borrower(book_id)
    if @books[book_id].status == 'available'
      return nil
    else 
      @checked_out[book_id].name
    end
  end

  def check_out_book(book_id, borrower)
    if @books[book_id].status == 'available' && borrower.num_books_checked_out < 2
      @books[book_id].check_out
      @checked_out[book_id] = borrower
      borrower.num_books_checked_out += 1
      @available_books.delete(@books[book_id])
      @borrowed_books << @books[book_id]
    end
  end

  def check_in_book(book_id)
    if @books[book_id].status == 'checked_out'
      @books[book_id].check_in
      @checked_out[book_id].num_books_checked_out -= 1
      @checked_out.delete(book_id)
      @available_books << @books[book_id]
      @borrowed_books.delete(@books[book_id])
    end
  end
end

