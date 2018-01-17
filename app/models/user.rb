class User < ApplicationRecord
  include App::Scopes

  JSON = %i[id title name email phone cel avatar].freeze

  mount_uploader :avatar, AvatarUploader

  scope :search, ->(term) { like_any(%i[name email], term) }

  self.per_page = 15
end
