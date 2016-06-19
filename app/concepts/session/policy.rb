class Session::Policy
  # include Gemgem::Policy
  def initialize(user, model)
    @user = user
    @model = model
  end

  attr_reader :user

  def true?
    true
  end

  def create?
    true
  end

  def admin?
    return unless @user
    @user.email == "info@cj-agency.de"
  end

  def apply?
    return unless @user
    #user already apply and job still available
    JobApplication.where(job_id: @model.id, user_id: @user.id).size == 0
  end

  def current_user?
    return unless @user
    @user.email == @model.email
  end

  # def signed_in?
  #   tyrant.signed_in?
  # end

  # the problem here is that we need deciders to differentiate between contexts (e.g. signed_in?)
  # that we actually already know, e.g. Create::SignedIn knows it is signed in.
  #
  # Idea: Thing::Policy::Update.()
  def update?
    edit?
  end

  def edit?
    # don't need signed_in? because current_user? will be false if the user is not signed in
    # signed_in? and (admin? or model.users.include?(user))
    admin? or current_user?
  end
  
  def delete?
    edit?
  end

  class NotAuthorizedError < RuntimeError
    attr_reader :query, :record, :policy

    def initialize(options = {})
      if options.is_a? String
        message = options
      else
        @query  = options[:query]
        @record = options[:record]
        @policy = options[:policy]

        message = options.fetch(:message) { "not allowed to #{query} this #{record.inspect}" }
      end

      super(message)
    end
  end

end
