require 'spec_helper'

describe Bookly::Repositories::Books do
  subject { Bookly::Repositories::Books.new('bookly_dev') }

  before do
    subject.delete_all
  end

  it "saves and finds a book" do
    book = Bookly::Book.new('How to Train a Trainer', Date.parse('1900-12-15'))
    subject.save(book)
    expect(book.id).to_not be_nil

    retrieved_book = subject.find(book.id)
    expect(retrieved_book.id).to eq book.id
    expect(retrieved_book.name).to eq book.name
    expect(retrieved_book.published_at).to eq book.published_at
  end

  it "gets all books" do
    subject.save  Bookly::Book.new("How Hulk Has Hands", Date.parse('1983-10-29'))
    subject.save  Bookly::Book.new("When Will Won't Work", Date.parse('2013-05-15'))

    books = subject.all
    expect(books.count).to eq 2
    expect(books.map &:name).to include "How Hulk Has Hands", "When Will Won't Work"
  end
end
