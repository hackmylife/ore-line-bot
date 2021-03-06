# coding: utf-8
require 'date'

module Parser
  class Timer

    FORMAT = [
      '%Y/%m/%d %H:%M',
      '%Y-%m-%d %H:%M',
      '%Y年 %m月 %d日 %H: %M',
      '%H: %M',
      '%H時',
      '%Y-%m-%d %H:%M:%S',
      '%Y/%m/%d %H:%M:%S',
      '%m/%d %H:%M',
      '%m-%d %H:%M',
      '%m月 %d日 %H: %M',
      '%Y-%m-%d',
      '%Y/%m/%d',
    ]

    def initialize()
    end

    def parse(time_str)
      return parse_regex(time_str) || parse_time_fromat(time_str) 
    end

    def parse_time_fromat(time_srt)
      date = nil
      FORMAT.each do |format|
        begin
          date = DateTime.strptime(time_srt, format)
          date = date - Rational(9, 24)
          break
        rescue ArgumentError
        end
      end
      return date
    end

    def parse_regex(time_srt)
      # min later expression
      if time_srt.match(/([0-9０-９]+)\s*(?:分|min)/) then
        after = $1.to_i * 60
        return Time.now + after
      end

      # houre later expression
      if time_srt.match(/([0-9０-９]+)\s*(?:時間後|hour)/) then
        after = $1.to_i * 3600
        return Time.now + after
      end
      return nil

    end
  end
end
