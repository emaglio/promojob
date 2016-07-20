class User < ActiveRecord::Base
  class Delete < Trailblazer::Operation

    include Model

    policy Session::Policy, :delete?
    model User, :find

    def process(params) #TODO: do we need to destroy anything else?
      deleteJobApplication!
      delete_images!
      model.destroy
    end

  private
    def deleteJobApplication!
      JobApplication.where("user_id = ?", model.id).find_each do |job_application|
       job_application.destroy
      end
    end

    def delete_images!
      Thing::ImageProcessor.new(model.image_meta_data).image! { |v| v.delete! } unless model.image_meta_data == nill
    end
  
  end
end