class Api::V1::FlashcardsController < ApplicationController
  def index
    @flashcard_set = FlashcardSet.find(params[:flashcard_set_id])
    @flashcards = @flashcard_set.flashcards.all()
    render json: @flashcards
  end

  # GET /flashcard_sets/1
  # GET /flashcard_sets/1.json
  def show
    if @flashcard_set
      render json: @flashcard_set
    else
      render json: @flashcard_set.errors
    end
  end

  # GET /flashcard_sets/new
  def new
    @flashcard_set = FlashcardSet.new
  end

  def create
    @flashcard_set = FlashcardSet.find(params[:flashcard_set_id])
    @flashcard = @flashcard_set.flashcards.create(flashcard_params)
    if @flashcard.save
      render json: @flashcard
    else
      render json: @flashcard.errors
    end
  end

  def destroy
   @flashcard_set = FlashcardSet.find(params[:flashcard_set_id])
   @flashcard = @flashcard_set.flashcards.find(params[:id])
   @flashcard.destroy
   

   render json: { notice: 'Flashcards set was successfully removed.' }
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
