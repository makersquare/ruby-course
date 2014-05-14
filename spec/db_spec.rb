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

  describe 'pic_tweets in db' do
    let(:pt) do
      data = {
        content: "My pic",
        pic_url: "my_pic.jpg",
        tags: ["my", "pic"]
      }
      Tweet.db.create_pic_tweet(data)
    end

    let(:pt2) do
      data = {
        content: "My pic2",
        pic_url: "my_pic2.jpg",
        tags: ["my", "pic"]
      }
      Tweet.db.create_pic_tweet(data)
    end

    let(:pt3) do
      data = {
        content: "My pic3",
        pic_url: "my_pic3.jpg",
        tags: ["my"]
      }
      Tweet.db.create_pic_tweet(data)
    end

    let(:tag1) { Tweet.db.get_or_create_tag(tag:"my") }
    let(:tag2) { Tweet.db.get_or_create_tag(tag:"pic") }

    describe ".create_pic_tweet" do
      it "returns a PicTweet" do
        expect(pt).to be_a(PicTweet)
        expect(pt.content).to eq("My pic")
        expect(pt.pic_url).to eq("my_pic.jpg")
        expect(pt.id).to be_a(Fixnum)
        # TODO: test pt.tags
      end

      it "also calls get_or_create_tag" do
        # Tweet.db.get_or_create_tag({tag: "tag1"})
        expect(Tweet.db).to receive(:get_or_create_tag).with({tag: "my"}).
        and_call_original
        expect(Tweet.db).to receive(:get_or_create_tag).with({tag: "pic"}).
        and_call_original
        # We have to call tt after the tests so that the expectations 
        # are fulfilled. Rspec remembers the expectations and then checks
        # them when tt is run.
        # If we call it before the tests, rspec forgets that it did stuff.
        
        pt
      end

      it "creates a relationship between pic_tweet and tag" do
        pt

        # TODO: We need some sort of way to grab the text_tweet_tag ID instead
        # of hard-coding it in as 0 and x1
        expect(Tweet::db.pic_tweet_tags.values).to include(
          {pt_id:pt.id, tag_id:tag1.id, id:0})
        expect(Tweet::db.pic_tweet_tags.values).to include(
          {pt_id:pt.id, tag_id:tag2.id, id:1})
      end
    end

    describe ".get_pic_tweets_from_tag" do
      it "returns array of PicTweets linked to the tag" do
        # Calling all our let block stuff
        pt
        pt2
        pt3

        tag = Tweet.db.get_or_create_tag({tag:"pic"})
        result = Tweet.db.get_pic_tweets_from_tag(tag)
        expect(result).to be_a(Array)
        expect(result.length).to eq(2)
        expect(result.first).to be_a(PicTweet)
      end
    end
    
    describe ".build_pic_tweet" do
      let(:data) do 
        {
          content: "My Pic",
          tags: ["my", "pic"],
          pic_url: "my_pic.jpg"
        }
      end
      it "returns a PicTweet" do
        result = Tweet.db.build_pic_tweet(data)
        expect(result).to be_a(PicTweet)
      end
    end
  end
end
