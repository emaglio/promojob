module User::Cell
  class Index < Trailblazer::Cell
  private
    def total
      model.size
    end
  end

  class Item < Trailblazer::Cell
    property :phone

    def link
      link_to model.email, model
    end
  end
end
