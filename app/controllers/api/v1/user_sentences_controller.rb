class Api::V1::UserSentencesController < ApplicationController
  before_action :authenticate_user!, except: [:shared_user_sentences]

  def index
    @user_sentence_set = UserSentenceSet.find(params[:user_sentence_set_id])
    @user_sentences = @user_sentence_set.user_sentences.all()
        render json: {user_sentences: @user_sentences, user_sentence_set: @user_sentence_set}, status: :ok
  end

  def shared_user_sentences
    @user_sentence_set = UserSentenceSet.find(params[:user_sentence_set_id])
    @user_sentences = @user_sentence_set.user_sentences.all()
    render json: {user_sentences: @user_sentences, user_sentence_set: @user_sentence_set}, status: :ok
  end

  def create
    @user_sentence_set = UserSentenceSet.find(params[:user_sentence_set_id])
    @user_sentence = @user_sentence_set.user_sentences.new(user_sentence_params)
    if @user_sentence.save
      render json: @user_sentence, status: :ok
    else
      render json: @user_sentence.errors, status: :unprocessable_entity
    end
  end

  def destroy
   @user_sentence = UserSentence.find(params[:id])
   @user_sentence.destroy
   authorize! :destroy, @user_sentence

   render json: { notice: 'Sentence was successfully removed.' }
   head :no_content, status: :ok
 end

 def update
    @user_sentence = UserSentence.find(params[:id])

    if @user_sentence.update(user_sentence_params)
      render json: @user_sentence, status: :ok
    else
      render json: @user_sentence.errors, status: :unprocessable_entity
    end
  end

  private
    def user_sentence_params
      params.require(:user_sentence).permit(:sentence, :key_word, :hint, :comment)
    end
end
