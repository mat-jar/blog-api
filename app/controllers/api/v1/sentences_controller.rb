class Api::V1::SentencesController < ApplicationController

  def show
  word = sentences_param[:word]
  response = ScrapSentences.call(word)
  


  render json: {word: response,  message: "Sentence"}, status: :ok
  end

  private

  def sentences_param
    params.require(:sentences).permit(:word)
  end

end
