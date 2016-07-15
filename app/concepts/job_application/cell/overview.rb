module JobApplication::Cell
  class Overview < Trailblazer::Cell
    property :job
    
    property :message
    property :status
  end
end