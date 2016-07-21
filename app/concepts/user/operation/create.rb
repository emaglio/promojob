require "reform/form/validation/unique_validator"
require "tyrant/sign_up"


class User < ActiveRecord::Base
  class Create < Trailblazer::Operation # => User::Create
    include Model
    model User, :create

    policy Session::Policy, :create?

    contract do
    	property :firstname
      property :lastname
      property :email
      property :gender
      property :phone
      property :age
      property :block
      property :password, virtual: true
      property :confirm_password, virtual: true
      property :profile_image, virtual: true

      extend Paperdragon::Model::Writer
      processable_writer :image
      property :image_meta_data
      validates :profile_image,  file_size: { less_than: 1.megabyte,
                                              message: "File too big, it must be less that 1 MB."},
        file_content_type: { allow: ['image/jpeg', 'image/png', 'image/jpg', 'image/pdf'], 
                             message: "Invalid format, file shoidl be one of: *./jpeg, *./jpg, *./png and *./pdf"}



      validates :firstname, :lastname, :gender, :phone, :age, :email, :password,  presence: true
      validates :phone, :email, unique: true
      validates :age, numericality: { only_integer: true, greater_than: 0}

      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      VALID_PASSWORD_REGEX = /(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])/
      
      validates :email, format: {with: VALID_EMAIL_REGEX}
  
      validates :password,  length: {in: 5..20, too_short: "must have at least 5 characters",
                            too_long: "must have at most 20 characters"},
                            format: {with: VALID_PASSWORD_REGEX, 
                            message: "must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter"}  
      validate :password_ok?
      
      def password_ok?
        return unless email and password
        errors.add(:password, "Passwords don't match") if password != confirm_password
      end
    end


    # * hash password, set confirmed
    # * hash password, set unconfirmed with token etc.

    # * no password, unconfirmed, needs password.
    def process(params)
      validate(params[:user]) do |contract|
        update!
        upload_image!(contract) unless contract.profile_image == nil
        contract.save # save User with email.
      end
    end

    private
      def update!
        auth = Tyrant::Authenticatable.new(contract.model)
        auth.digest!(contract.password) # contract.auth_meta_data.password_digest = ..
        auth.confirmed!
        auth.sync
      end

      def upload_image!(contract)
        contract.image!(contract.profile_image) do |v|
          v.process!(:original)
          v.process!(:thumb) { |job| job.thumb!("120x120#") }
        end
      end
  end
end