require 'rubygems'
require 'sinatra/base'
require 'sinatra/reloader'
require 'date'
require 'json'
require 'faraday'
require 'dotenv'
require './lib/line/bot/client'
require './lib/db'
require './lib/parser/datetime'


class MainApp < Sinatra::Base

  Dotenv.load
  @@client = Line::Bot::Client.new()

  get '/' do
    'done'
  end
  
  post '/callback' do
    params = JSON.parse request.body.read

    result = params['result']
    result.each{|message|
      user_check(message)
      timer(message)
      echo(message)
    }

    'done'
  end

  def timer(message)
    text = message['content']['text']
    parser = Parser::DateTime.new()
    date = parser.parse(text);
    if date.present?
      text.match(/^[\s]*\s(^[\s]*)/)
      label = $1
      print date + ': ' + label 
      return true
    else
      return false
    end
  end
  
  def echo(message) 
    @@client.send_message(message['content']['from'], message['content']['text'])
  end

  def user_check(message)
    mid = message['content']['from']
    unless User.exists?(mid: mid) then
      profile = @@client.get_profile(mid).fetch('contacts').first
      user = User.new
      user.mid = mid
      user.display_name = profile['displayName']
      user.created_at = Time.now.to_i
      user.save
    end
  end
  
end

