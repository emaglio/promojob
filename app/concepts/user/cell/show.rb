module User::Cell
  class Show < Trailblazer::Cell
    property :firstname
    property :lastname
    property :email
    property :phone
    property :block

    extend Paperdragon::Model::Reader
    processable_reader :image
    property :image_meta_data

    def thumb
      image_tag image[:thumb].url, class: :th if image.exists?
    end
  end
end
