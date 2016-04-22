require 'rubygems'
require 'sinatra/base'
require 'sinatra/reloader'
require 'json'
require 'faraday'
require 'dotenv'


class MainApp < Sinatra::Base

  Dotenv.load
  include './lib/line/bot/client'

  get '/' do
    'done'
  end
  post '/callback' do
    params = JSON.parse request.body.read
    result = params['result']
    result.each{|message|
      Line::Bot::Client.send_message(message['content']['from'], message['content']['text'])
    }
    'done'
  end

end

