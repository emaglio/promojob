class ApplicationController < ActionController::Base
  def render(cell_constant, model)
    # return super(html:  cell(cell_constant, model), layout: true) # use this to render the page cell with ActionView's layout.

    super(html: cell(cell_constant, model, layout: RailsFoundation::Cell::Layout))
  end

  def tyrant
    Tyrant::Session.new(request.env['warden'])
  end
  helper_method :tyrant

  require_dependency "session/operation/impersonate"
  before_filter { Session::Impersonate.(params.merge!(tyrant: tyrant)) } # TODO: allow Op.(params, session)

  rescue_from Trailblazer::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:message] = "Not authorized, my friend."
    redirect_to root_path
  end
  

end
