module User::Cell
    class Show < Trailblazer::Cell

    property :firstname
    property :lastname
    property :gender
    property :age
    property :email
    property :phone
    property :block

    extend Paperdragon::Model::Reader
    processable_reader :image
    property :image_meta_data
    processable_reader :file
    property :file_meta_data


    def link_cv
      link_to "View CV", file[:original].url, data: { lightbox: "image", title: "CV" } if file.exists?
    end
  end
end
