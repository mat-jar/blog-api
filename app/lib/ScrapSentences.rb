require "httparty"
require "nokogiri"

class ScrapSentences < ApplicationService
  def call
    scrap
  end

  private

  attr_reader :word, :options

  def initialize(word, options = nil)
    @word = word
    @options = options
  end

  def scrap
    sentences = []
    url = "https://www.merriam-webster.com/dictionary/#{@word}"
    response = HTTParty.get(url)
    html = response
    doc = Nokogiri::HTML(html)
    doc.xpath("//div[contains(@class, 'in-sentences')]/span[contains(@class, 'ex-sent')]").each do |span|
      sentences.push(span.text.strip)
    end
    sentences
  end

end
