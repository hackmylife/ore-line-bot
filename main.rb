require 'rubygems'
require 'sinatra/base'
require 'sinatra/reloader'
require 'json'
require 'faraday'
require 'dotenv'

class MainApp < Sinatra::Base

  Dotenv.load

  get '/' do
    send_message()
    hello() + ' world'
  end

  def hello()
    'hello'
  end

  def send_message()
    conn = Faraday.new(:url => 'https://trialbot-api.line.me') do |builder|
      builder.request  :url_encoded
      builder.response :logger
      builder.adapter  :net_http
    end
      
    conn.post do |req|
      req.url '/v1/events'
      req.headers = {
        'Content-Type' => 'application/json; charser=UTF-8',
        'X-Line-ChannelID' => ENV['LINE_CHANNEL_ID'],
        'X-Line-ChannelSecret' => ENV['LINE_CHANNEL_SECRET'],
        'X-Line-Trusted-User-With-ACL' => ENV['LINE_CHANNEL_MID']
      }
      req.body = {
        'to' => [ENV['TO_MID']], # callback受け取れるようになるまでenvにで代用
        'toChannel' => "1383378250",
        'eventType' => "138311608800106203",
        'content' => {
          'contentType' => 1,
          'toType' => 1,
          'text' =>  "hello!"
        }
      }.to_json
    end
  end
end

#MainApp.run! :host => 'localhost', :port => 8090
