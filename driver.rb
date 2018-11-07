require 'selenium-webdriver'

class Driver

  # @!method constructor of class, start webdriver and navigate to url
  # @param url
  # @param browser (optional)=> chrome by default
  def initialize(url, browser)
    @driver ||= Selenium::WebDriver.for browser
    @driver.manage.window.maximize
    @driver.manage.timeouts.implicit_wait = 10
    @driver.navigate.to url
    Selenium::WebDriver.logger.level = :debug
    @log ||= Logger.new('Logs/'+DateTime.now.strftime('%Q')+'.log')
    @log.formatter = proc do |severity, datetime, progname, msg|
      date_format = datetime.strftime("%Y-%m-%d %H:%M:%S")
      puts msg
      "[#{date_format}] #{severity}  (#{progname}): #{msg}\n"
    end
    log_message 'browser start'
    @wait = Selenium::WebDriver::Wait.new(:timeout => 15) # seconds
  end

  # @!method elements: find element or elements in page
  # @param arguments_hash
  # @param elements (optional)=> is false by default. If this is true return an array of elements
  # @return element or array of element
  def elements(arguments ={}, elements =false)
    if elements
      el = @driver.find_elements(arguments)
    else
      el = @driver.find_element(arguments)
    end
    return el
  end

  #@!method close
  def close
    @driver.quit
  end

  #@!method wait to load the element
  def wait_element(element)
    @wait.until{element}
  end


  def click_wait(elementClick, elementWait)
    log_message 'click at element: ' << elementClick.to_s
    elementClick.click
    sleep 2
    wait_element(elementWait)
  end

  #@!method switch to popup
  def switch_to_popup
    return @driver.switch_to.alert
  end

  #@!method log messages in terminal and log file
  # @param message to write
  # @param type of log
  def log_message (message, type='info')
    case type
    when 'debug' then
      @log.debug message
    when  'error' then
      @log.error message
    else
      @log.info message
    end
  end

end