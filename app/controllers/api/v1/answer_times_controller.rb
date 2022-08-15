class Api::V1::AnswerTimesController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer_time = AnswerTime.new(answer_time_param)

    if @answer_time.save
      render json: @answer_time, status: :ok
    else
      render json: @answer_time.errors, status: :unprocessable_entity

    end
  end

  def user_average
    if analyse_answer_time_param.values_at("user_id").join.empty?
      render status: :unprocessable_entity
      return
    end
    @average_answer_time = AnalyseAnswerTime.get_average_by_user(analyse_answer_time_param[:user_id])
    render json: { average_answer_time: @average_answer_time}, status: :ok
  end

  def flashcard_set_average
    if analyse_answer_time_param.values_at("flashcard_set_id").join.empty?
      render status: :unprocessable_entity
      return
    end
    @average_answer_time = AnalyseAnswerTime.get_average_by_flashcard_set(analyse_answer_time_param[:flashcard_set_id])
    render json: { average_answer_time: @average_answer_time}, status: :ok
  end

  def word_average
    if analyse_answer_time_param.values_at("word").join.empty?
      render status: :unprocessable_entity
      return
    end
    @average_answer_time = AnalyseAnswerTime.get_average_by_word(analyse_answer_time_param[:word])
    render json: { average_answer_time: @average_answer_time}, status: :ok
  end

  def learning_session_average
    if analyse_answer_time_param.values_at("learning_session_id").join.empty?
      render status: :unprocessable_entity
      return
    end
    @average_answer_time = AnalyseAnswerTime.get_average_by_learning_session(analyse_answer_time_param[:learning_session_id])
    render json: { average_answer_time: @average_answer_time}, status: :ok
  end



  private
    def answer_time_param
      params.require(:answer_time).permit(:learning_session_id, :flashcard_id, :round, :time_millisecond)
    end

    def analyse_answer_time_param
      params.require(:answer_time).permit(:learning_session_id, :flashcard_id, :round, :user_id, :word, :flashcard_set_id)
    end

end
