
class SearchFlashcardSets < ApplicationService

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

      if options[:title]
        @resources = resources.where(title: options[:title])
      end

      if options[:description]
        @resources = resources.where(description: options[:description])
      end

      if options[:category]
        @resources = resources.where(category: options[:category])
      end

      resources
    end
  end
