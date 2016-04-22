require 'rubygems'
require 'sinatra/base'
require 'sinatra/reloader'
require 'json'
require 'faraday'
require 'dotenv'
require './lib/line/bot/client'

class MainApp < Sinatra::Base

  Dotenv.load

  get '/' do
    'done'
  end
  post '/callback' do
    params = JSON.parse request.body.read
    client = Line::Bot::Client.new()
    result = params['result']
    result.each{|message|
      client.send_message(message['content']['from'], message['content']['text'])
    }
    'done'
  end

end

