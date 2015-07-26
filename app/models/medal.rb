class Medal < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  has_many :medalizations
  has_many :students , :through => :medalizations
end
