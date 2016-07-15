module My
  class Calendar < Trailblazer::Operation
    policy Session::Policy, :my?

    def model!(params)
      @offset = 0 if params[:offset] == "0"
      @offset = params[:offset].to_i
    end

    attr_reader :offset
  end
end