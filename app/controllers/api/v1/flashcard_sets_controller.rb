class Api::V1::FlashcardSetsController < ApplicationController
  before_action :set_flashcard_set
  before_action :authenticate_user!, except: [:index, :show]
  #before_action :set_flashcard_set, only: [:index, :show, :edit, :update, :destroy]
    # GET /flashcard_sets
    # GET /flashcard_sets.json
    def index
      @flashcard_sets = FlashcardSet.all
      render json: @flashcard_sets
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

    # GET /flashcard_sets/1/edit
    def edit
    end

    # POST /flashcard_sets
    # POST /flashcard_sets.json
    def create
      @flashcard_set = FlashcardSet.new(flashcard_set_params)
      @flashcard_set.user = current_user



      if @flashcard_set.save
        render json: @flashcard_set
      else
        render json: @flashcard_set.errors, status: :unprocessable_entity
        
      end
    end

    # PATCH/PUT flashcard_sets/1
    # PATCH/PUT /flashcard_sets/1.json
    def update
    end

    # DELETE /flashcard_sets/1
    # DELETE /flashcard_sets/1.json
    def destroy
      @flashcard_set.destroy

      render json: { notice: 'Flashcards set was successfully removed.' }
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_flashcard_set
        if params[:id]
          @flashcard_set = FlashcardSet.find(params[:id])
        end
      end

      # Only allow a list of trusted parameters through.
      def flashcard_set_params
        params.require(:flashcard_set).permit(:title, :description, :category)
      end
end
