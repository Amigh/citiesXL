class Student < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  has_many :projects
  has_many :medalizations
  has_many :medals , :through => :medalizations
end
