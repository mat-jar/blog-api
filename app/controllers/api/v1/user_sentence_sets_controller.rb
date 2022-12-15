class Api::V1::UserSentenceSetsController < ApplicationController
  before_action :set_user_sentence_set
  before_action :authenticate_user!, except: [:show_shared]


    def index
      @user_sentence_sets = UserSentenceSet.accessible_by(current_ability, :index)
      render json: @user_sentence_sets, status: :ok
    end

    def show_accessible
      @user_sentence_sets = UserSentenceSet.accessible_by(current_ability, :show_accessible)
      if !search_user_sentence_params.empty?
        @user_sentence_sets = SearchUserSentenceSets.call(@user_sentence_sets, search_user_sentence_params)
      end
      render json: @user_sentence_sets, status: :ok
    end

    def show_shared
      @user_sentence_sets = UserSentenceSet.shared
      if !search_user_sentence_params.empty?
        @user_sentence_sets = SearchUserSentenceSets.call(@user_sentence_sets, search_user_sentence_params)
      end
      render json: @user_sentence_sets, status: :ok
    end

    def show
        render json: @user_sentence_set, status: :ok
    end

    def create
      @user_sentence_set = UserSentenceSet.new(user_sentence_set_params)
      @user_sentence_set.user = current_user

      if @user_sentence_set.save
        render json: @user_sentence_set, status: :ok
      else
        render json: @user_sentence_set.errors, status: :unprocessable_entity

      end
    end

    def update
      if @user_sentence_set.update(user_sentence_set_params)
        render json: @user_sentence_set, status: :ok
      else
        render json: @user_sentence_set.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @user_sentence_set.destroy
      authorize! :destroy, @user_sentence_set

      render json: { notice: 'Sentences set was successfully removed.' }
      head :no_content, status: :ok
    end

    private

      def set_user_sentence_set
        if params[:id]
          @user_sentence_set = UserSentenceSet.find(params[:id])
          render status: :not_found if id_with_wrong_title?
        end
      end

      def user_sentence_set_params
        params.require(:user_sentence_set).permit(:title, :description, :category, :access)
      end

      def search_user_sentence_params
        params.fetch(:user_sentence_set, {}).permit(:user_id, :title, :description, :category, :search_phrase, :access)
      end

      def id_with_wrong_title?
        (params[:id].sub(@user_sentence_set.id.to_s, '') != '') &&
        (@user_sentence_set.slug != params[:id])
      end
end
