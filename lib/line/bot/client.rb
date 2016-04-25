require 'faraday'

module Line
  module Bot
    class Client

      def initialize()
        @conn = Faraday.new(:url => 'https://trialbot-api.line.me') do |builder|
          builder.request  :url_encoded
          builder.response :logger
          builder.adapter  :net_http
        end
      end

      def build_headers
        return {
            'Content-Type' => 'application/json; charser=UTF-8',
            'X-Line-ChannelID' => ENV['LINE_CHANNEL_ID'],
            'X-Line-ChannelSecret' => ENV['LINE_CHANNEL_SECRET'],
            'X-Line-Trusted-User-With-ACL' => ENV['LINE_CHANNEL_MID']
          }
      end
      
      def send_message(to, text)
        @conn.post do |req|
          req.url '/v1/events'
          req.headers = build_headers()
          req.body = {
            'to' => [to],
            'toChannel' => "1383378250",
            'eventType' => "138311608800106203",
            'content' => {
              'contentType' => 1,
              'toType' => 1,
              'text' =>  text
            }
          }.to_json
        end
      end

      def get_profile(mid)
        @conn.post do |req|
          req.url '/v1/profiles'
          req.headers = build_headers()
          req.body = {
            'mids' => mid,
          }.to_json
        end        
      end

    end
  end
end
