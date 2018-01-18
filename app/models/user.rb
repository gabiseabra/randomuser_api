class User < ApplicationRecord
  include App::Scopes

  JSON = %i[id title name email phone cel avatar].freeze

  before_save :capitalize_names

  mount_uploader :avatar, AvatarUploader

  scope :search, ->(term) { term.present? ? like_any(%i[name email], term) : all }

  self.per_page = 15

  private

  def capitalize_names
    self.name = name.split.map(&:capitalize).join(' ')
    self.title = title.capitalize
  end
end
