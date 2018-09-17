class Room::Policy
  def initialize(user, model)
    @user = user
    @model = model
  end

  def view?
    @model.users.include? @user
  end
end
