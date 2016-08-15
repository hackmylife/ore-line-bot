# -*- coding: utf-8 -*-
require 'spec_helper'
require 'date'

RSpec.describe "parser test" do
  before do
    @parser = Parser::Timer.new()
  end

  it "minute parse test" do
    expect(@parser.parse("6分後 テスト").to_i).to eq (Time.now + 6 * 60).to_i
  end

  it "hour parse test" do
    expect(@parser.parse("6時間後 テスト").to_i).to eq (Time.now + 6 * 3600).to_i
  end


  it "hh時 parse test" do
    now = Time.now
    target = Time.mktime 0, 0, 6, now.day, now.month, now.year, now.wday, now.yday, false, "JST"
    expect(@parser.parse("6時 テスト").to_i).to eq target.to_i
  end

  it "hh:mm parse test" do
    now = Time.now
    target = Time.mktime 0, 10, 6, now.day, now.month, now.year, now.wday, now.yday, false, "JST"
    expect(@parser.parse("6:10 テスト").to_i).to eq target.to_i
  end

  it "yyyy-mm-dd hh:mm parse test" do
    now = Time.now
    target = DateTime.new(2016, 5, 10, 11, 10, 0) - Rational(9, 24)
    expect(@parser.parse("2016-05-10 11:10 テスト").to_i).to eq target.to_i
  end

  it "yyyy-mm-dd parse test" do
    now = Time.now
    target = DateTime.new(2016, 5, 10, 0, 0, 0) - Rational(9, 24)
    expect(@parser.parse("2016-05-10 テスト").to_i).to eq target.to_i
  end

  it "mm-dd hh:mm parse test" do
    now = Time.now
    target = DateTime.new(now.year, 5, 10, 11, 10, 00) - Rational(9, 24)
    expect(@parser.parse("05-10 11:10 テスト").to_i).to eq target.to_i
  end

  it "yyyy年mm月dd日 hh:mm parse test" do
    now = Time.now
    target = DateTime.new(2016, 5, 10, 11, 10, 00) - Rational(9, 24)
    expect(@parser.parse("2016年5月10日 11:10 テスト").to_i).to eq target.to_i
  end
  
  it "mm月dd日 hh時mm分 parse test" do
    now = Time.now
    target = DateTime.new(now.year, 5, 10, 11, 10, 00) - Rational(9, 24)
    expect(@parser.parse("5月10日 11:10 テスト").to_i).to eq target.to_i
  end
end
