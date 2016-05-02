class JobApplicationsController < ApplicationController

  def create
    run Job::Apply
    redirect_to "/jobs"
  end

end
