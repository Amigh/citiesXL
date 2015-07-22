class Medalization < ActiveRecord::Base
  belongs_to :medal
  belongs_to :student
end
