require 'dotenv'
require 'date'
require './lib/line/bot/client'
require './lib/db'
require './lib/parser/datetime'

Dotenv.load
client = Line::Bot::Client.new()

now = Time.now
from = DateTime.new(now.year, now.month, now.day, now.hour - 9, now.min, 0)
to = DateTime.new(now.year, now.month, now.day, now.hour - 9, now.min, 0) + Rational(1, 1440)

p now
p from.to_i
p to.to_i - 1

timers = Timer.find_between(from.to_i, to.to_i - 1)

timers.each do |timer|
  begin
    client.send_message(timer.mid, timer.name)
  end
end
