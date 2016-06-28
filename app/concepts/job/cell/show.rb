module Job::Cell
  
  class Show < Trailblazer::Cell
    property :id
    property :title
    property :company
    property :requirements
    property :description
    property :user_count
    property :salary
    property :starts_at
  end

end
