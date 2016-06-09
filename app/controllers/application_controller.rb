class ApplicationController < ActionController::Base
  helper_method :flashes, :parent_controller
  
  def render(cell_constant, operation: @operation, model: @operation.model)
    # return super(html:  cell(cell_constant, model), layout: true) # use this to render the page cell with ActionView's layout.
    super(html: cell(cell_constant, model,
      layout: RailsFoundation::Cell::Layout,
      context: { tyrant: tyrant, policy: operation.policy, flash: flash }))
  end

  def tyrant
    Tyrant::Session.new(request.env['warden'])
  end

  def process_params!(params)
    params.merge!(current_user: tyrant.current_user)
  end

  
  def flashes
    @flash = parent_controller.flash
    render RailsFoundation::Cell::Message, model: @flash
  end

  def parent_controller
  end

  # FIXME: where do we enforce the signed in constrained?

  rescue_from Trailblazer::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:message] = "Not authorized, my friend."
    redirect_to root_path
  end

end
