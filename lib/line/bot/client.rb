require 'faraday'
require 'json'

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
        _post('/v1/events', {
            'to' => [to],
            'toChannel' => "1383378250",
            'eventType' => "138311608800106203",
            'content' => {
              'contentType' => 1,
              'toType' => 1,
              'text' =>  text
            }
          }.to_json)
      end

      def get_profile(mid)
        _post('/v1/profiles', {
            'mids' => mid,
          }.to_json)
      end        

      def _post(url, body)
        response = @conn.post do |req|
          req.url url
          req.headers = build_headers()
          req.body = body
        end
        if response.success? then
          return JSON.parse response.body
        else
          result = JSON.parse response.body
          p result
        end
        return {}
      end

 end
  end
end
