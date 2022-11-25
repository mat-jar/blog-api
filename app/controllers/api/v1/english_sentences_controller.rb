class Api::V1::EnglishSentencesController < ApplicationController

  def show
    @number = english_sentences_param[:number].to_i
    @key_word = english_sentences_param[:key_word]
    @english_sentences = []
    EnglishSentence.where(key_word: @key_word).sample(@number).each {|r| @english_sentences.push(r.sentence)}

    if @english_sentences.empty?
      @english_sentences = ScrapSentences.call(@key_word)
      @english_sentences.each do |sentence|
        @english_sentence = EnglishSentence.new(key_word: @key_word, sentence: sentence)
        #@english_sentence.save
      end
      @english_sentences = @english_sentences.sample(@number)
    end

    render json: {key_word: @key_word,  english_sentences: @english_sentences}, status: :ok

  end

  def translate
    @sentence = translate_sentence_param[:sentence]
    @translated_sentence = ScrapTranslation.call(@sentence)

    render json: {original_sentence: @sentence,  translated_sentence: @translated_sentence}, status: :ok

  end

  def random
    @number = random_english_sentences_param[:number].to_i
    @random_english_sentences = []
    EnglishSentence.all.sample(@number).each {|r| @random_english_sentences.push(r.sentence)}

    render json: {random_english_sentences: @random_english_sentences}, status: :ok

  end


  private

    def english_sentences_param
      params.require(:english_sentences).permit(:key_word, :number)
    end

    def random_english_sentences_param
      params.require(:random_english_sentences).permit(:number)
    end

    def translate_sentence_param
      params.require(:translate_sentence).permit(:sentence)
    end

end
