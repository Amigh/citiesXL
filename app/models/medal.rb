class Medal < ActiveRecord::Base
  has_many :medalizations
  has_many :students , :through => :medalizations
end
