require "httparty"
require "nokogiri"

class ScrapSentences < ApplicationService

  def call
    sentences = scrap_mw + scrap_mac + scrap_coll + scrap_long + scrap_brit + scrap_ox + scrap_free
    sentences.uniq
  end

  private

  attr_reader :word, :options

  def initialize(word, options = nil)
    @word = word
    @options = options
  end

  def is_sentence?(text)
    /\A[[:upper:]]/.match?(text) #string starts with capital letter
  end

  def scrap_dictionary(url, xpath)
    sentences = []
    response = HTTParty.get(url)
    page_body = Nokogiri::HTML(response.body)
    page_body.xpath(xpath).each do |element|
      text = element.text
      text.gsub("\u00A0", " ") #replace &nbsp with standard space;
      text.strip! #remove leading and trailing whitespace
      text.slice!(/\(.*\)/) #remove parentheses with text inside
      text.slice!(/\[.*\]/) #remove brackets with text inside
      #sentence = sentence.gsub(/\"/, "")
      sentences.push(text) if is_sentence?(text)
    end
   sentences
  end

  def scrap_mw
    url = "https://www.merriam-webster.com/dictionary/#{@word}"
    xpath = "//div[contains(@class, 'in-sentences')]/span[contains(@class, 'ex-sent')]"
    scrap_dictionary(url, xpath)
  end

  def scrap_mac
    url = "https://www.macmillandictionary.com/dictionary/british/#{@word}"
    xpath = "//p[@class='EXAMPLE']"
    scrap_dictionary(url, xpath)
  end

  def scrap_coll
    url = "https://www.collinsdictionary.com/dictionary/english/#{@word}"
    xpath = "//span[@class='quote']"
    scrap_dictionary(url, xpath)
  end

  def scrap_long
    url = "https://www.ldoceonline.com/dictionary/#{@word}"
    xpath = "//span[@class='EXAMPLE']"
    scrap_dictionary(url, xpath)
  end

  def scrap_brit
    url = "https://www.britannica.com/dictionary/#{@word}"
    xpath = "//div[@class='vi_content']"
    scrap_dictionary(url, xpath)
  end

  def scrap_ox
    url = "https://www.oxfordlearnersdictionaries.com/definition/english/#{@word}"
    xpath = "//span[@class='x']"
    scrap_dictionary(url, xpath)
  end

  def scrap_free
    url = "https://www.thefreedictionary.com/#{@word}"
    xpath = "//span[@class='illustration']"
    scrap_dictionary(url, xpath)
  end

end
