class Medal < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  has_many :medalizations
  has_many :students , :through => :medalizations
  validates :description,:type_name, :score,:display_name,:name, :image,presence: true
  default_scope { order("position ASC") }
  def per_type_name()
    if self.type_name == 'gold'
      return 'طلا'
    elsif self.type_name == 'silver'
      return 'نقره'
    else
      return 'برنز'
    end
  end
end
