require 'spec_helper'

describe "db" do
  it "exists" do
    expect(DB).to be_a(Class)
  end

  it "returns a db" do
    expect(Quack.db).to be_a(DB)
  end

  it "is a singleton" do
    db1 = Quack.db
    db2 = Quack.db
    expect(db1).to be(db2)
  end

  describe "tags" do
    describe "get_or_create" do
      it "puts a tag in the database" do
        t = Quack.db.get_or_create_tag(tag: "this")
        expect(t).to be_a(Tag)
        expect(t.id).to be_a(Fixnum)
        expect(t.tag).to eq("this")
        expect(Quack.db.tags[t.id]).to eq({
          tag: "this",
          id: t.id
        })
      end

      it "doesn't add a task if it already exists" do
        Quack.db.get_or_create_tag(tag: "this")
        Quack.db.get_or_create_tag(tag: "this")
        Quack.db.get_or_create_tag(tag: "this")
        count = Quack.db.tags.count {|id, tag| tag[:tag] == "this"}
        expect(count).to eq(1)
      end

      it "retreives a tag by it's id" do
        t = Quack.db.get_or_create_tag(tag: "this")
        t2 = Quack.db.get_tag(t.id)
        expect(t2).to be_a(Tag)
        expect(t2.id).to eq(t.id)
        expect(t2.tag).to eq(t.tag)
      end
    end
  end

  describe "text_quacks in db" do
    let(:tq) do
      data = {
          content: "testing",
          tags: ["tag1", "tag2"]
        }
      tq = Quack.db.create_text_quack(data)
    end
    let(:tag1) { Quack.db.get_or_create_tag(tag:"tag1") }
    let(:tag2) { Quack.db.get_or_create_tag(tag:"tag2") }
    describe '.create_text_quack' do
      it "stores the content in the db" do
        expect(tq).to be_a(TextQuack)
        expect(tq.content).to eq("testing")
        expect(tq.id).to be_a(Fixnum)
        expect(Quack.db.text_quacks[tq.id]).to eq({
          content: "testing",
          id: tq.id,
        })
      end

      it "also calls get_or_create_tag" do
        # Quack.db.get_or_create_tag({tag: "tag1"})
        expect(Quack.db).to receive(:get_or_create_tag).with({tag: "tag1"}).
        and_call_original
        expect(Quack.db).to receive(:get_or_create_tag).with({tag: "tag2"}).
        and_call_original
        # We have to call tq after the tests so that the expectations 
        # are fulfilled. Rspec remembers the expectations and then checks
        # them when tq is run.
        # If we call it before the tests, rspec forgets that it did stuff.
        
        tq
      end

      it "creates a relationship between text_quack and tag" do
        tq

        # TODO: We need some sort of way to grab the text_quack_tag ID instead
        # of hard-coding it in as 0 and 1
        expect(Quack::db.text_quack_tags.values).to include(
          {tq_id:tq.id, tag_id:tag1.id, id:0})
        expect(Quack::db.text_quack_tags.values).to include(
          {tq_id:tq.id, tag_id:tag2.id, id:1})
      end
    end
  end

  describe "text_quack_tags in db" do
    describe '.create_text_quack_tag' do
      it "stores a text_quack id and a tag_id in a hash" do
        tq_id = 1
        tag_id = 2
        result = Quack.db.create_text_quack_tag(tq_id, tag_id)
        expect(Quack.db.text_quack_tags[result]).to eq(
        {
          tq_id: 1,
          tag_id: 2,
          id: result
          })
      end
    end
  end
end
