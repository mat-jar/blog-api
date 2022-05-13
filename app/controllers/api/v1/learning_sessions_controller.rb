class Api::V1::LearningSessionsController < ApplicationController

  def index
    @learning_sessions = LearningSession.where("user_id = ?", current_user)

    render json: @learning_sessions
    
    #render json: { message: current_user}
    #render json: { message: "index"}
  end

  def show_specific
    user_id = learning_session_param[:user_id]
    flashcard_set_id = learning_session_param[:flashcard_set_id]

    if user_id && flashcard_set_id
      @learning_sessions = LearningSession.where("user_id = ?", user_id).where("flashcard_set_id = ?", flashcard_set_id)
      #render json: { message: "user #{user}+set#{flashcard_set}."}
      render json: @learning_sessions
    elsif user_id && !flashcard_set_id
      @learning_sessions = LearningSession.where("user_id = ?", user_id)
      #render json: { message: "only user #{user}"}
      render json: @learning_sessions
    elsif !user_id && flashcard_set_id
      @learning_sessions = LearningSession.where("flashcard_set_id = ?", flashcard_set_id)
      #render json: { message: "only sset #{flashcard_set} "}
      render json: @learning_sessions
    else
    render json: { message: "nothing hill"}
    end
  end

  def create
    @learning_session = LearningSession.create(learning_session_param)
    @learning_session.user = current_user

    if @learning_session.save
      render json: @learning_session
    else
      render json: @learning_session.errors
    end
  end

  private
    def learning_session_param
      params.require(:learning_session).permit(:flashcard_set_id, :user_id)
    end


end
