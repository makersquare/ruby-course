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
    describe '.create_text_quack' do
      it "stores the content in the db" do
        data = {
          content: "testing",
          tags: ["tag1", "tag2"]
        }
        tq = Quack.db.create_text_quack(data)
        expect(tq).to be_a(TextQuack)
        expect(tq.content).to eq("testing")
        expect(tq.id).to be_a(Fixnum)
        expect(Quack.db.text_quacks[tq.id]).to eq({
          content: "testing",
          id: tq.id
        })
      end
    end
  end

  describe "text_quacks to tags" do
  end
end