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

  def scrap_mw
    sentences = []
    url = "https://www.merriam-webster.com/dictionary/#{@word}"
    response = HTTParty.get(url)
    html = response
    doc = Nokogiri::HTML(html.body)
    doc.xpath("//div[contains(@class, 'in-sentences')]/span[contains(@class, 'ex-sent')]").each do |span|
      sentences.push(span.text.strip) if /\A[[:upper:]]/.match(span.text.strip)
    end
    sentences
  end

  def scrap_mac
    sentences = []
    url = "https://www.macmillandictionary.com/dictionary/british/#{@word}"
    response = HTTParty.get(url)
    html = response
    doc = Nokogiri::HTML(html.body)
    doc.xpath("//p[@class='EXAMPLE']").each do |span|
      sentences.push(span.text.strip) if /\A[[:upper:]]/.match(span.text.strip)
    end
    sentences
  end

  def scrap_coll
    sentences = []
    url = "https://www.collinsdictionary.com/dictionary/english/#{@word}"
    response = HTTParty.get(url)
    html = response
    doc = Nokogiri::HTML(html.body)
    doc.xpath("//span[@class='quote']").each do |span|
      sentences.push(span.text.strip) if /\A[[:upper:]]/.match(span.text.strip)
    end
    sentences
  end

  def scrap_long
    sentences = []
    url = "https://www.ldoceonline.com/dictionary/#{@word}"
    response = HTTParty.get(url)
    html = response
    doc = Nokogiri::HTML(html.body)
    doc.xpath("//span[@class='EXAMPLE']").each do |span|
      sentence = span.text.strip
      sentence.slice!(160.chr('UTF-8'))
      sentences.push(sentence) if /\A[[:upper:]]/.match(sentence)
    end
    sentences
  end

  def scrap_brit
    sentences = []
    url = "https://www.britannica.com/dictionary/#{@word}"
    response = HTTParty.get(url)
    html = response
    doc = Nokogiri::HTML(html.body)
    doc.xpath("//div[@class='vi_content']").each do |span|
      sentence = span.text
      sentence.slice!(/\[.*\]/)
      sentence = sentence.strip
      sentences.push(sentence) if /\A[[:upper:]]/.match(sentence)
    end
    sentences
  end

  def scrap_ox
    sentences = []
    url = "https://www.oxfordlearnersdictionaries.com/definition/english/#{@word}"
    response = HTTParty.get(url)
    html = response
    doc = Nokogiri::HTML(html.body)
    doc.xpath("//span[@class='x']").each do |span|
      sentence = span.text
      sentence.slice!(/\(.*\)/)
      sentences.push(sentence) if /\A[[:upper:]]/.match(sentence)
    end
    sentences
  end

  def scrap_free
    sentences = []
    url = "https://www.thefreedictionary.com/#{@word}"
    response = HTTParty.get(url)
    html = response
    doc = Nokogiri::HTML(html.body)
    doc.xpath("//span[@class='illustration']").each do |span|
      sentence = span.text
      sentence.slice!(/\(.*\)/)
      sentence = sentence.gsub(/\"/, "")
      sentence = sentence.strip
      sentences.push(sentence) if /\A[[:upper:]]/.match(sentence)
    end
    sentences
  end

end
