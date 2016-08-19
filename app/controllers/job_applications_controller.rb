class JobApplicationsController < ApplicationController

  def create
    run JobApplication::Apply do |op|
      flash[:notice] = "You have applied for #{Job.find(op.model.job_id).title}"
    end

    redirect_to "/jobs"
  end

  def show
    present JobApplication::Applications

    render JobApplication::Cell::Applications, options: {status: @operation.status}
  end

  def edit
    form JobApplication::Edit

    render JobApplication::Cell::Edit, model: @model
  end

  def update
    run JobApplication::Update do 
      flash[:notice] = "Job application updated"
      return redirect_to applications_job_applications_path(status: "Apply")
    end
    render JobApplication::Cell::Edit, model: @model
  end

  def destroy
    run JobApplication::Delete
    flash[:alert] = "Job application deleted"    
    redirect_to root_path
  end

  def overview
    present JobApplication::Overview

    render JobApplication::Cell::Overview
  end

end
