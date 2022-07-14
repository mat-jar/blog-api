class Api::V1::LearningSessionsController < ApplicationController
  before_action :authenticate_user!
  #load_and_authorize_resource


  def index
    @learning_sessions = LearningSession.accessible_by(current_ability, :index)
    render json: @learning_sessions
  end

  def show_accessible
    @learning_sessions = LearningSession.accessible_by(current_ability, :show_accessible)
    if !search_learning_session_param.empty?
      @learning_sessions = SearchLearningSessions.call(@learning_sessions, search_learning_session_param)
    end
    render json: @learning_sessions
  end

  def show_specific
    user_id = learning_session_param[:user_id].to_s
    flashcard_set_id = learning_session_param[:flashcard_set_id].to_s

    if !user_id.empty? && !flashcard_set_id.empty?
      @learning_sessions = LearningSession.where("user_id = ?", user_id)
      .where("flashcard_set_id = ?", flashcard_set_id)
      .accessible_by(current_ability, :show_specific)

      render json: @learning_sessions
    elsif !user_id.empty? && flashcard_set_id.empty?
      @learning_sessions = LearningSession.where("user_id = ?", user_id)
      .accessible_by(current_ability, :show_specific)

      render json: @learning_sessions
    elsif user_id.empty? && !flashcard_set_id.empty?
      @learning_sessions = LearningSession.where("flashcard_set_id = ?", flashcard_set_id)
      .accessible_by(current_ability, :show_specific)

      render json: @learning_sessions
    else
    render json: { message: "nothing hill"}
    end
  end

  def create
    @learning_session = LearningSession.new(learning_session_param)
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

    def search_learning_session_param
      params.fetch(:learning_session, {}).permit(:flashcard_set_id, :user_id)
    end

end
