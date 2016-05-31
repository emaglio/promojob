module Job::Cell

  class Applied < Trailblazer::Cell
  private
    def total
      model.size
    end
  end

  class Item < Trailblazer::Cell

    def link
      link_to model.title, model
    end
  
  end      
end