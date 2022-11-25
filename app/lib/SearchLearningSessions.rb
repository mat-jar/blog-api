
class SearchLearningSessions < ApplicationService

    def call
      filter
    end

    private

    attr_reader :resources, :options

    def initialize(resources, options)
      @resources = resources
      @options   = options
    end

    def filter
      if options[:user_id]
        @resources = resources.where(user_id: options[:user_id])
      end

      if options[:flashcard_set_id]
        @resources = resources.where(learnable_id: options[:flashcard_set_id])
      end

      resources
    end
  end
