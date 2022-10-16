class Api::V1::TeacherTokensController < ApplicationController
  before_action :authenticate_user!

  def create
    if current_user.role != "teacher"
      render json: { message: "You must be a teacher to generate a tacher token"}, status: :forbidden
    else
      @teacher_token = TeacherToken.new
      @teacher_token.teacher = current_user

      if @teacher_token.save
        render json: @teacher_token.token, status: :ok
      else
        render json: @teacher_token.errors, status: :unprocessable_entity
      end
    end
  end

end
