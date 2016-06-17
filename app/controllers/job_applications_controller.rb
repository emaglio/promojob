class JobApplicationsController < ApplicationController

  def create
    run Job::Apply do |op|
      flash[:notice] = "Applied for #{Job.find(op.model.job_id).title}"
    end
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
    flash[:notice] = "Job application updated"    
    redirect_to "/job_applications/applied"
  end

  def destroy
    run Job::DeleteApplication
    flash[:alert] = "Job application deleted"    
    redirect_to "/job_applications/applied"
  end

end
