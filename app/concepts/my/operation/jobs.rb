module My
  class Jobs < Trailblazer::Operation
    policy Session::Policy, :my?
  end
end