class Api::V1::FlashcardsController < ApplicationController
  before_action :authenticate_user!, except: [:shared_flashcards]

  def index
    @flashcard_set = FlashcardSet.find(params[:flashcard_set_id])
    @flashcards = @flashcard_set.flashcards.all()
    @flashcard_set_settings_panel = @flashcard_set.flashcard_set_settings_panels.where(user_id: current_user.id)
    render json: {flashcards: @flashcards, flashcard_set: @flashcard_set, flashcard_set_settings_panel: @flashcard_set_settings_panel}, status: :ok
  end

  def shared_flashcards
    @flashcard_set = FlashcardSet.find(params[:flashcard_set_id])
    @flashcards = @flashcard_set.flashcards.all()
    if current_user
      @flashcard_set_settings_panel = @flashcard_set.flashcard_set_settings_panels.where(user_id: current_user.id)
    else
      @flashcard_set_settings_panel = nil
    end
    render json: {flashcards: @flashcards, flashcard_set: @flashcard_set, flashcard_set_settings_panel: @flashcard_set_settings_panel}, status: :ok
  end

  def create
    @flashcard_set = FlashcardSet.find(params[:flashcard_set_id])
    @flashcard = @flashcard_set.flashcards.new(flashcard_params)
    if @flashcard.save
      render json: @flashcard, status: :ok
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

 def update
    @flashcard = Flashcard.find(params[:id])

    if @flashcard.update(flashcard_params)
      render json: @flashcard, status: :ok
    else
      render json: @flashcard.errors, status: :unprocessable_entity
    end
  end

  private
    def flashcard_params
      params.require(:flashcard).permit(:front_text, :back_text, :front_photo, :back_photo, :front_audio, :back_audio, :hint)
    end
end
