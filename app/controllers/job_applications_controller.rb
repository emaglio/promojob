class JobApplicationsController < ApplicationController

  def create
    run Job::Apply
    
    redirect_to "/jobs"
  end

  def show
    present Job::Applied

    render Job::Cell::Applied
  end

  def edit
    form Job::EditApplication

    render Job::Cell::EditApplication, model: @form
  end

  def update
    present Job::UpdateApplication 
    
    redirect_to "/job_applications/applied"
  end

end
