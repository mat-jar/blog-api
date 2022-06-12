class Api::V1::AnswerTimesController < ApplicationController



  def create
    @answer_time = AnswerTime.new(answer_time_param)

    if @answer_time.save
      render json: @answer_time
    else
      render json: @answer_time.errors
    end
  end

  def user_average
    AnalyseAnswerTime.get_user_average_answer_time(analyse_answer_time_param[:user_id])
  end

  def flashcard_set_average
    AnalyseAnswerTime.get_flashcard_set_average_answer_time(analyse_answer_time_param[:flashcard_id])
  end

  def word_average
    AnalyseAnswerTime.get_word_average_answer_time(analyse_answer_time_param[:word])
  end

  def learning_session_average
    AnalyseAnswerTime.get_learning_session_average_answer_time(analyse_answer_time_param[:learning_session_id])
  end



  private
    def answer_time_param
      params.require(:answer_time).permit(:learning_session_id, :flashcard_id, :round, :time_millisecond)
    end

    def analyse_answer_time_param
      params.require(:answer_time).permit(:learning_session_id, :flashcard_id, :round, :user_id, :word)
    end

end
