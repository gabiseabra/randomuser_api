class User < ApplicationRecord
  include ScopeConcern

  mount_uploader :avatar, AvatarUploader

  scope :search, ->(term) { like_any(%i[name email], term) }

  self.per_page = 15
end
