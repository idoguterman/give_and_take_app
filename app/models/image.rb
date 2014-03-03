class Image < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar
  attr_accessible :description , :user_id, :user, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :avatar_cache, :remove_avatar , :remote_image_url
  belongs_to :user
  


  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def picture_from_url(url)
    self.avatar = URI.parse(url)
    self.crop_x = 0 if self.crop_x.blank?
    require 'debugger';debugger
    save!
    puts self.inspect
  end
end

