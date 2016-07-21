class User < ActiveRecord::Base
  include Paperdragon::Model
  processable :image

  
  has_many :jobs, through: :job_applications
  serialize :auth_meta_data
  serialize :image_meta_data
end
