require "rspec"
require "./exercises.rb"
require 'date'


describe Exercises do

  it "returns strings times three or nope" do

    ans = Exercises.ex0("str")
    expect(ans).to eq "strstrstr"
    ans = Exercises.ex0("wishes")
    expect(ans).to eq "nope"

  end

  it "return items in array" do

    ans = Exercises.ex1([0,5,6,7,8])
    expect(ans).to eq 5
    ans = Exercises.ex1([])
    expect(ans).to eq 0

  end

  it "return second item in array" do

    ans = Exercises.ex2([0,5,6,7,8])
    expect(ans).to eq 5
    ans = Exercises.ex2([])
    expect(ans).to eq 'No Second Element'

  end

  it "return second item in array" do

    ans = Exercises.ex3([0,5,6,7,8])
    expect(ans).to eq 26
    ans = Exercises.ex3([])
    expect(ans).to eq 0

  end

  it "return max in array" do

    ans = Exercises.ex4([0,5,6,7,8])
    expect(ans).to eq 8
    ans = Exercises.ex4([])
    expect(ans).to eq nil

  end
  
  it "puts print items in array" do

    expect(STDOUT).to receive(:puts).and_return('a')
    expect(STDOUT).to receive(:puts).and_return('b')
    expect(STDOUT).to receive(:puts).and_return('c')
    Exercises.ex5(['a','b','c'])

  end

  it "last is panda or GODZILLA" do

    arry = ['a', 'b', 'c']
    Exercises.ex6(arry)
    expect(arry[arry.count-1]).to eq 'panda'
    Exercises.ex6(arry)
    expect(arry[arry.count-1]).to eq 'GODZILLA'

  end

  it "push string to end if exists" do

    arry = ['alpha', 'beta', 'gamma']
    Exercises.ex7(arry, 'omega')
    expect(arry[2]).to eq 'gamma'
    Exercises.ex7(arry, 'beta')
    expect(arry[arry.count-1]).to eq 'beta'

  end

  it "prints name and occupation from hash-filled array" do

    arry = [{:name => "barry", :occupation => "worker"},{:name => "freddy", :occupation => "chef"}]
    expect(STDOUT).to receive(:puts).and_return('barry')
    expect(STDOUT).to receive(:puts).and_return('worker')
    expect(STDOUT).to receive(:puts).and_return('freddy')
    expect(STDOUT).to receive(:puts).and_return('chef')
    Exercises.ex8(arry)

  end

  it "find if time is leap year" do

    res = Exercises.ex9(DateTime.new(2000))
    expect(res).to eq true
    res = Exercises.ex9(DateTime.new(2004))
    expect(res).to eq true
    res = Exercises.ex9(DateTime.new(2100))
    expect(res).to eq false
    res = Exercises.ex9(DateTime.new(1999))
    expect(res).to eq false

  end

  it "is it happy hour" do

    my_time = Time.new(2002, 10, 31, 2)
    allow(Time).to receive(:now).and_return(my_time)

    res = Exercises.ex10
    expect(res).to eq 'normal prices'

    new_time = Time.new(2002, 10, 31, 17)
    allow(Time).to receive(:now).and_return(new_time)

    res = Exercises.ex10
    expect(res).to eq 'happy hour'
    

  end

end