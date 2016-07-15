module Job::Cell
  
  class Show < Trailblazer::Cell
    property :id
    property :title
    property :company
    property :requirements
    property :description
    property :duration
    property :user_count
    property :salary
    property :starts_at
    property :ends_at
  end

end
