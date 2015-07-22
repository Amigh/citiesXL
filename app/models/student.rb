class Student < ActiveRecord::Base
  has_many :medalizations
  has_many :medals , :through => :medalizations
end
