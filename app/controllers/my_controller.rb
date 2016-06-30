class MyController < ApplicationController

  def jobs
    present My::Jobs
    render My::Cell::Jobs, model: nil
  end

  def calendar
    present My::Calendar
    render My::Cell::Calendar, model: nil, options: {offset: @operation.offset}
  end

end