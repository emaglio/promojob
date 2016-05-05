module Job::Cell
  
  class Show < Trailblazer::Cell
    property :id
    property :title
    property :company
    property :requirements
    property :description
    property :salary
    property :startingday
  end

end