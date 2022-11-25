require "nokogiri"
require "selenium-webdriver"

class ScrapTranslation < ApplicationService
  def call
    scrap_deepl
  end

  private

  attr_reader :sentence, :options

  def initialize(sentence, options = nil)
    @sentence = sentence
    @options = options
  end

  def scrap_deepl
    translated_sentence = ''
    time_limit = 0.0
    @sentence = @sentence.gsub(/ /, "%20")
    url = "https://www.deepl.com/pl/translator#en/pl/#{@sentence}"
    options = Selenium::WebDriver::Chrome::Options.new
	  options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.get url

    while translated_sentence.empty? && time_limit < 2
      sleep(0.5)
      html = driver.page_source
      doc = Nokogiri::HTML(html)
      translated_sentence = doc.xpath("//div[@id='target-dummydiv']").text.strip
      time_limit +=0.5
    end
    driver.quit
    puts time_limit
    translated_sentence

  end
end
