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

    def thumb
      if image.exists?
        # link_to image_tag image[:thumb], image[:original].url, :data => {:'data-lightbox' => "profile_image"}
      end
    end

  end
end
