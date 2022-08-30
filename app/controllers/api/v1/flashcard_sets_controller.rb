class Api::V1::FlashcardSetsController < ApplicationController
  before_action :set_flashcard_set
  before_action :authenticate_user!, except: [:show_shared]

  #before_action :authenticate_user!
  #before_action :set_flashcard_set, only: [:index, :show, :edit, :update, :destroy]

    # GET /flashcard_sets
    def index
      @flashcard_sets = FlashcardSet.accessible_by(current_ability, :index)
      render json: @flashcard_sets, status: :ok
    end

    def show_accessible
      @flashcard_sets = FlashcardSet.accessible_by(current_ability, :show_accessible)
      if !search_flashcard_set_params.empty?
        @flashcard_sets = SearchFlashcardSets.call(@flashcard_sets, search_flashcard_set_params)
      end
      render json: @flashcard_sets, status: :ok
    end

    def show_shared
      @flashcard_sets = FlashcardSet.shared
      if !search_flashcard_set_params.empty?
        @flashcard_sets = SearchFlashcardSets.call(@flashcard_sets, search_flashcard_set_params)
      end
      render json: @flashcard_sets, status: :ok
    end

    # GET /flashcard_sets/1
    def show
        render json: @flashcard_set, status: :ok
    end

    # POST /flashcard_sets
    def create
      @flashcard_set = FlashcardSet.new(flashcard_set_params)
      @flashcard_set.user = current_user

      if @flashcard_set.save
        render json: @flashcard_set, status: :ok
      else
        render json: @flashcard_set.errors, status: :unprocessable_entity

      end
    end

    # PATCH/PUT flashcard_sets/1
    def update
      if @flashcard_set.update(flashcard_set_params)
        render json: @flashcard_set, status: :ok
      else
        render json: @flashcard_set.errors, status: :unprocessable_entity
      end
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
          render status: :not_found if id_with_wrong_title?
        end
      end

      def flashcard_set_params
        params.require(:flashcard_set).permit(:title, :description, :category)
      end

      def search_flashcard_set_params
        params.fetch(:flashcard_set, {}).permit(:user_id, :title, :description, :category, :search_phrase)
      end

      def id_with_wrong_title?
        (params[:id].sub(@flashcard_set.id.to_s, '') != '') &&
        (@flashcard_set.to_param != params[:id])
      end

end
