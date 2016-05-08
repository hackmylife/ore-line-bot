require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter=> "mysql2",
  :host => "localhost",
  :database => "timerbot",
  :username => "root"
)

class User < ActiveRecord::Base
end

class Work < ActiveRecord::Base
end

class Timer < ActiveRecord::Base
  scope :find_between, -> from, to {
    if from.present? && to.present?
      where(alert_at: from..to)
    elsif from.present?
      where('alert_at >= ?', from)
    elsif to.present?
      where('alert_at <= ?', to)
    end
  }
end
