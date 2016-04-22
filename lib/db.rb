require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter=> "mysql2",
  :host => "localhost",
  :database => "workbot"
  :username => "root"
)

class User < ActiveRecord::Base
end

class Work < ActiveRecord::Base
end

class Task < ActiveRecord::Base
end
