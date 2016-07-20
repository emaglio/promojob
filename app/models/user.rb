class User < ActiveRecord::Base
  include Paperdragon::Model
  
  has_many :jobs, through: :job_applications
  serialize :auth_meta_data
  serialize :image_meta_data
end
