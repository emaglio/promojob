class JobApplicationsController < ApplicationController

  def create
    run Job::Apply
    
    redirect_to "/jobs"
  end

  def show
    present Job::Applied

    render Job::Cell::Applied
  end

end
