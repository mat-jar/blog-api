class Api::V1::FlashcardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @flashcard_set = FlashcardSet.find(params[:flashcard_set_id])
    @flashcards = @flashcard_set.flashcards.all()
    render json: @flashcards
  end

  def create
    @flashcard_set = FlashcardSet.find(params[:flashcard_set_id])
    @flashcard = @flashcard_set.flashcards.new(flashcard_params)
    if @flashcard.save
      render json: @flashcard
    else
      render json: @flashcard.errors, status: :unprocessable_entity
    end
  end

  def destroy
   @flashcard = Flashcard.find(params[:id])
   @flashcard.destroy
   authorize! :destroy, @flashcard

   render json: { notice: 'Flashcard was successfully removed.' }
   head :no_content, status: :ok
 end

 def edit
   @flashcard_set = FlashcardSet.find(params[:flashcard_set_id])
   @flashcard = @flashcard_set.flashcards.find(params[:id])
end

 def update
    @flashcard_set = FlashcardSet.find(params[:flashcard_set_id])
    @flashcard = @flashcard_set.flashcards.find(params[:id])

    if @flashcard.update(flashcard_params)
      redirect_to flashcard_set_path(@flashcard_set)
    else
      render :edit
    end
  end

  private
    def flashcard_params
      params.require(:flashcard).permit(:front_text, :back_text)
    end
end
