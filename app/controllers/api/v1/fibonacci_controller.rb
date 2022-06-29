class Api::V1::FibonacciController < ApplicationController

  def index
    @messages = MessageStorage.list
    render json: @messages
  end

  private
  def fibonacci_params
    params.require(:fibonacci).permit(:number)
  end

end
