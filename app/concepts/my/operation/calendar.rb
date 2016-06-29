module My
  class Calendar < Trailblazer::Operation
    policy Session::Policy, :my?
  end
end