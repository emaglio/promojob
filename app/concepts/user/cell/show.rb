module User::Cell
  class Show < Trailblazer::Cell
    property :firstname
    property :lastname
    property :email
    property :phone
    property :block
  end
end
