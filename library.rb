
class Book
  attr_reader :author , :title
  attr_accessor :status, :id, :borrower, :year_published, :edition, :rating, :review, :time, :due_date, :in_line

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
    @id= nil
    @borrower= nil
    @year_published = nil
    @edition = nil
    @rating = []
    @review = []
    @time=nil
    @in_line=[]
  end


  def check_out
    if @status == "available"
      @status = "checked_out"
      return true
    else
      return false
    end
  end

  def check_in
    if @status == "checked_out"
      @status = "available"
      return true
    else
      return false
    end
  end



end

class Borrower
  attr_reader :name, :borrowed, :status, :past_due

  def initialize(name)
    @name = name
    @borrowed=[]
    @status = "good"
    @past_due = []
  end

  def critic(book,stars=nil,rant=nil)
    book.rating =  stars
    book.review = rant
  end
end

class Library
  attr_accessor :books, :books_in, :books_out
  @@count= 0
  def initialize(name)
    @books = []
    @name = name
    @@count=0
    @books_in=[]
    @books_out=[]
  end

  def books
    @books
  end

  def register_new_book(title, author)
    @@count+=1
    @@count
    a = Book.new(title, author)
    a.id = title
    @books<<a
    @books_in<<a
  end

  def add_book(title, author)
    @@count+=1
  end

  def check_out_book(book_id, borrower)
    b = @books.select {|x| x.title == book_id}
    if b[0].status == "checked_out"
      if borrower.status == "good"
        puts "Do you want to be put into the queue for the book? yes or no?"
        answer = gets.chomp.downcase
        case answer
          when 'yes'
            b[0].in_line<<borrower
            puts "The book is out for another #{self.time_remaining(b[0].title)}."
            puts "You are #{in_line.length} in line."
          when 'no'
            puts "Sounds goodie!"
            puts "Would you like to check out a different book?"
          else
            puts "Well played sir. Stay golden."
        end
      else
        puts "Please return the following books: #{borrower.past_due} before attempting to check out more books."
      end
    elsif borrower.status == "overdue"
      puts borrower.past_due
    else
      b[0].check_out
      b[0].borrower = borrower
      b[0].borrower.borrowed<<b[0]
      b[0].time = Time.now.to_i
      b[0].due_date = Time.now.to_i +86400
      if b[0].borrower.borrowed.count>2
        return nil
      else
        @books_out<<b[0]
        @books_in.delete(b[0])
        b[0]
      end
    end
  end

  def get_borrower(book_id)
    b = @books.select {|x| x.title == book_id}
    b.first.borrower.name
  end

  def check_in_book(book)
    book.check_in
    @books_in<<book
    @books_out.delete(book)

  end

  def available_books
    @books_in
  end

  def borrowed_books
    @books_out
  end

  def time_left(book_id)
    od = @books.select {|x| x.title == book_id}
    time_remaining = od[0].due_date - od[0].time
    if time_remaining<0
      puts "The book is overdue!"
      od[0].borrower.status = "overdue"
      od[0].borrower.borrowed.past_due<<od[0]
    end
    puts time_remaining
  end
end


