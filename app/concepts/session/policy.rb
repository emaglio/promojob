class Session::Policy

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

  def my?
    @user
  end

  def update?
    edit?
  end

  def edit?
    admin? or current_user?
  end

  def current_user_application?
    return unless @user
    @user.email == @model.user.email
  end

  def delete_application?
    admin? or current_user_application?
  end

  def delete?
    edit?
  end

end
