class ApplicationController < ActionController::Base
  
  def render(cell_constant, operation: @operation, model: @operation.model, options: {})
    # return super(html:  cell(cell_constant, model), layout: true) # use this to render the page cell with ActionView's layout.
    super(html: cell(cell_constant, model,
      { layout: RailsFoundation::Cell::Layout,
        context: { tyrant: tyrant, policy: operation.policy, flash: flash }
      }.merge( options))
    )
  end

  def tyrant
    Tyrant::Session.new(request.env['warden'])
  end

  def process_params!(params)
    params.merge!(current_user: tyrant.current_user)
  end

  rescue_from Trailblazer::NotAuthorizedError do |exception|
    
    # messages = {
    #     :apply? => flash[:message] = "You have already applied for this job",
    #     nil => flash[:message] = "All the positions for this job have been fulfilled",
    #     :admin? => flash[:message] = "Not authorized, my friend.",
    #     :edit? => flash[:message] = "Not authorized, my friend.",
    #     :my? => flash[:message] = "Not authorized, my friend.", 
    #     :delete? => flash[:message] = "Not authorized, my friend."
    # }

    # messages[exception.query]

    if tyrant.current_user
      if exception.query == :apply?
        flash[:notice] = "You have already applied for this job"
        application = JobApplication.find_by(:job_id => exception.record.id)
        redirect_to overview_job_application_path(application.id)
      else
        if exception.query == nil
          flash[:message] = "All the positions for this job have been fulfilled"
        else
          flash[:message] = "Not authorized, my friend."
        end
        redirect_to root_path
      end
    else
      flash[:notice] = "Need to Sign In or create an account!"
      redirect_to root_path
    end
  end


end
