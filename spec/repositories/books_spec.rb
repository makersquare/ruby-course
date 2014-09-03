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
end
