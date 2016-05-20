class ApplicationController < ActionController::Base
  def render(cell_constant, model)
    # return super(html:  cell(cell_constant, model), layout: true) # use this to render the page cell with ActionView's layout.

    super(html: cell(cell_constant, model, layout: RailsFoundation::Cell::Layout, context: { tyrant: tyrant }))
  end

  def tyrant
    Tyrant::Session.new(request.env['warden'])
  end

  # FIXME: where do we enforce the signed in constrained?

  rescue_from Trailblazer::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:message] = "Not authorized, my friend."
    redirect_to root_path
  end
end
