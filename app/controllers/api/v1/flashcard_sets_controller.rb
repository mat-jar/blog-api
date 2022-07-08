class Api::V1::FlashcardSetsController < ApplicationController
  before_action :set_flashcard_set
  before_action :authenticate_user!, except: [:show_shared]

  #before_action :authenticate_user!
  #before_action :set_flashcard_set, only: [:index, :show, :edit, :update, :destroy]

    # GET /flashcard_sets
    def index
      @flashcard_sets = FlashcardSet.accessible_by(current_ability, :index)
      render json: @flashcard_sets
    end

    def show_specific
      @flashcard_sets = FlashcardSet.accessible_by(current_ability, :show_specific)
      render json: @flashcard_sets
    end

    def show_accessible
      @flashcard_sets = FlashcardSet.accessible_by(current_ability, :show_accessible)
      render json: @flashcard_sets
    end

    def show_shared
      @flashcard_sets = FlashcardSet.shared
      render json: @flashcard_sets
    end

    # GET /flashcard_sets/1
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
    def update
    end

    # DELETE /flashcard_sets/1
    def destroy
      @flashcard_set.destroy
      authorize! :destroy, @flashcard_set

      render json: { notice: 'Flashcards set was successfully removed.' }
      head :no_content, status: :ok
    end

    private

      def set_flashcard_set
        if params[:id]
          @flashcard_set = FlashcardSet.find(params[:id])
        end
      end

      def flashcard_set_params
        params.require(:flashcard_set).permit(:title, :description, :category)
      end
end
