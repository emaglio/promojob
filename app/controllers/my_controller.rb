class MyController < ApplicationController

  def jobs
    present My::Jobs
    render My::Cell::Jobs, model: nil
  end

  def calendar
    render My::Cell::Calendar, model: nil
  end

end