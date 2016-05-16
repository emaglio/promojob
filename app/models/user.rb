class User < ActiveRecord::Base
  has_many :jobs, through: :job_applications
  serialize :auth_meta_data
end
