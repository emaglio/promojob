module My::Cell

  module Tyrant
    def tyrant
      context[:tyrant]
    end
  end

  class Jobs < Trailblazer::Cell

  end

  class Applications < Trailblazer::Cell
    include Tyrant

    def show
      job_apps = JobApplication.where(user_id: tyrant.current_user.id, status: options[:status])

      cell(Item, collection: job_apps)
    end

    class Item < Trailblazer::Cell 
      
    end
  end

end