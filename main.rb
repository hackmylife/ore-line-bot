require 'rubygems'
require 'sinatra/base'
require 'sinatra/reloader'
require 'json'
require 'faraday'
require 'dotenv'
require './lib/line/bot/client'
require './lib/db'

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
      echo(message)
    }

    'done'
  end

  def echo(message) 
    @@client.send_message(message['content']['from'], message['content']['text'])
  end

  def user_check(message) 
    mid = message['content']['from']
    
  end

  
end

