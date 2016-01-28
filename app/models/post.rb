class Post < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  mount_uploader :file, AttachmentUploader
end
