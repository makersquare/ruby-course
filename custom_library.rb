class Library
  attr_accessor :books, :borrowed_books
  @@book_id = 0
  def initialize args = {}
    @books = args[:books] || []
    @borrowed_books = {}
  end

  def available_books
    books.select {|book| book.available?}
  end

  def overdue_books
    borrowed_books.select {|k,v| v[1] < Time.now}
  end

  def register_new_book title, author
    books << Book.new(title: title, author: author, id: generate_book_id)
  end

  def generate_book_id
    @@book_id += 1
  end

  def find_book book_id
    books.select {|book| book_id == book.id}.pop
  end

  def check_out_book book_id, borrower
    selected_book = find_book book_id
    return nil if deny_check_out? selected_book, borrower

    selected_book.check_out
    add_book_to_borrowed_list selected_book, borrower
    selected_book
  end

  def due_date
    Time.now + 60*10080
  end

  def add_book_to_borrowed_list selected_book, borrower
    borrowed_books[selected_book] = [borrower, due_date]
  end

  def deny_check_out? selected_book, borrower
    return checked_out?(selected_book) || ineligible?(borrower) || overdue?(borrower)
  end

  def checked_out? selected_book
    borrowed_books.keys.include? selected_book
  end

  def overdue? borrower
    borrowed_books.values.select {|v| v[0] == borrower}.any? {|v| v[1] < Time.now}
  end

  def ineligible? borrower
    borrowed_books.values.map {|v| v[0] }.count(borrower) >= 2
  end

  def schedule_check_out book_id, borrower
    selected_book = find_book book_id
    check_out_date = borrowed_books.fetch(selected_book)[1]
    check_out_book(book_id, borrower) if Time.now == check_out_date
  end

  def check_in_book book
    borrowed_books.delete(book)
    book.check_in
  end

  def get_borrower book_id
    borrowed_books[find_book(book_id)][0].name
  end

end

class Book
  attr_accessor :status
  attr_reader :title, :author, :id, :year_published, :edition, :review
  def initialize args = {}
    @status = 'available'
    @author = args[:author]
    @title = args[:title]
    @id = args[:id] || nil
    @year_published = args[:year_published] || nil
    @edition = args[:edition] || nil
  end

  def available?
    @status == 'available'
  end

  def check_out
    @status == 'available' ? (@status = 'checked_out'; true) : false
  end

  def check_in
    @status = 'available'
  end

  def review borrower, rating, review=nil
    "#{borrower.name} gave #{title} #{rating} stars. #{review}"
  end

end

class Borrower
  attr_reader :name
  def initialize args = {}
    @name = args[:name]
  end
end
