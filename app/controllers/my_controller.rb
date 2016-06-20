class MyController < ApplicationController

  def jobs
    present My::Jobs
    render My::Cell::Jobs, model: nil
  end

end