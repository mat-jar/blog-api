class Api::V1::AnswerTimesController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer_time = AnswerTime.new(answer_time_param)

    if @answer_time.save
      render json: @answer_time
    else
      render json: @answer_time.errors, status: :unprocessable_entity

    end
  end

  def user_average
    AnalyseAnswerTime.get_average_by_user(analyse_answer_time_param[:user_id])
  end

  def flashcard_set_average
    AnalyseAnswerTime.get_average_by_flashcard_set(analyse_answer_time_param[:flashcard_id])
  end

  def word_average
    AnalyseAnswerTime.get_average_by_word(analyse_answer_time_param[:word])
  end

  def learning_session_average
    AnalyseAnswerTime.get_average_by_learning_session(analyse_answer_time_param[:learning_session_id])
  end



  private
    def answer_time_param
      params.require(:answer_time).permit(:learning_session_id, :flashcard_id, :round, :time_millisecond)
    end

    def analyse_answer_time_param
      params.require(:answer_time).permit(:learning_session_id, :flashcard_id, :round, :user_id, :word)
    end

end
