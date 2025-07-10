class UsersController < ApplicationController
  def show
    @user = User.find(params[ :id])
    @prototypes = @user.prototypes.order(created_at: :asc)
  end
end
