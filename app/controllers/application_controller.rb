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
    if tyrant.current_user
      if exception.query == :apply?
        flash[:message] = "You have already applied for this job"
      else
        if exception.query == nil
          flash[:message] = "All the positions for this job have been fulfilled"
        else
          flash[:message] = "Not authorized, my friend."
        end
      end
    else
      flash[:notice] = "Need to Sign In or create an account!"
    end
    redirect_to root_path
  end


end
