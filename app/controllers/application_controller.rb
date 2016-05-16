class ApplicationController < ActionController::Base
  def render(cell_constant, model)
    # return super(html:  cell(cell_constant, model), layout: true) # use this to render the page cell with ActionView's layout.

    super(html: cell(cell_constant, model, layout: RailsFoundation::Cell::Layout))
  end

  def tyrant
    Tyrant::Session.new(request.env['warden'])
  end
  

end
