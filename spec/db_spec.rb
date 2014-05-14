require 'spec_helper'

describe "db" do
  it "exists" do
    expect(DB).to be_a(Class)
  end

  it "returns a db" do
    expect(Tweet.db).to be_a(DB)
  end

  it "is a singleton" do
    db1 = Tweet.db
    db2 = Tweet.db
    expect(db1).to be(db2)
  end

  describe "tags" do
    describe "get_or_create" do
      it "puts a tag in the database" do
        t = Tweet.db.get_or_create_tag(tag: "this")
        expect(t).to be_a(Tag)
        expect(t.id).to be_a(Fixnum)
        expect(t.tag).to eq("this")
        expect(Tweet.db.tags[t.id]).to eq({
          tag: "this",
          id: t.id
        })
      end

      it "doesn't add a task if it already exists" do
        Tweet.db.get_or_create_tag(tag: "this")
        Tweet.db.get_or_create_tag(tag: "this")
        Tweet.db.get_or_create_tag(tag: "this")
        count = Tweet.db.tags.count {|id, tag| tag[:tag] == "this"}
        expect(count).to eq(1)
      end

      it "retreives a tag by it's id" do
        t = Tweet.db.get_or_create_tag(tag: "this")
        t2 = Tweet.db.get_tag(t.id)
        expect(t2).to be_a(Tag)
        expect(t2.id).to eq(t.id)
        expect(t2.tag).to eq(t.tag)
      end
    end
  end

  describe "text_tweets in db" do
    let(:tt) do
      data = {
          content: "testing",
          tags: ["tag1", "tag2"]
        }
      tt = Tweet.db.create_text_tweet(data)
    end
    let(:tag1) { Tweet.db.get_or_create_tag(tag:"tag1") }
    let(:tag2) { Tweet.db.get_or_create_tag(tag:"tag2") }
    describe '.create_text_tweet' do
      it "stores the content in the db" do
        expect(tt).to be_a(TextTweet)
        expect(tt.content).to eq("testing")
        expect(tt.id).to be_a(Fixnum)
        expect(Tweet.db.text_tweets[tt.id]).to eq({
          content: "testing",
          id: tt.id,
        })
      end

      it "also calls get_or_create_tag" do
        # Tweet.db.get_or_create_tag({tag: "tag1"})
        expect(Tweet.db).to receive(:get_or_create_tag).with({tag: "tag1"}).
        and_call_original
        expect(Tweet.db).to receive(:get_or_create_tag).with({tag: "tag2"}).
        and_call_original
        # We have to call tt after the tests so that the expectations 
        # are fulfilled. Rspec remembers the expectations and then checks
        # them when tt is run.
        # If we call it before the tests, rspec forgets that it did stuff.
        
        tt
      end

      it "creates a relationship between text_tweet and tag" do
        tt

        # TODO: We need some sort of way to grab the text_tweet_tag ID instead
        # of hard-coding it in as 0 and x1
        expect(Tweet::db.text_tweet_tags.values).to include(
          {tt_id:tt.id, tag_id:tag1.id, id:0})
        expect(Tweet::db.text_tweet_tags.values).to include(
          {tt_id:tt.id, tag_id:tag2.id, id:1})
      end
    end
  end

  describe "text_tweet_tags in db" do
    describe '.create_text_tweet_tag' do
      it "stores a text_tweet id and a tag_id in a hash" do
        tt_id = 1
        tag_id = 2
        result = Tweet.db.create_text_tweet_tag(tt_id, tag_id)
        expect(Tweet.db.text_tweet_tags[result]).to eq(
        {
          tt_id: 1,
          tag_id: 2,
          id: result
          })
      end
    end
  end
end
