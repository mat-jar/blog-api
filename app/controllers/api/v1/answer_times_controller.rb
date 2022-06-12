class Api::V1::AnswerTimesController < ApplicationController

  def create
    @answer_time = AnswerTime.new(answer_time_param)

    if @answer_time.save
      render json: @answer_time
    else
      render json: @answer_time.errors
    end
  end

  private
    def answer_time_param
      params.require(:answer_time).permit(:learning_session_id, :flashcard_id, :round, :time_millisecond)
    end

end
