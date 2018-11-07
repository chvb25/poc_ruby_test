require_relative 'driver'
require_relative 'addressbook'

class LoginMainmenu < Driver

  #@!method create a intance of login_main
  # @param browser(optional)=> chrome by default
  def initialize(browser = :chrome)
    @driver = Driver.new("http://ci.frapid.com/account/sign-in", browser)
    @driver.elements({:id=>'EmailInputEmail'}).send_keys('demo@mixerp.org')
    @driver.elements({:id=>'PasswordInputPassword'}).send_keys('Demo@4321')
    @driver.elements({:id=>'SignInButton'}).click

    sleep 5
    menu = @driver.elements({:id=>'PhoneMenu', :class=>'apps'})
    @driver.wait_element(menu)

  end

  #@!method go to dashboard screen
  def dashboard
    @driver.elements({:xpath=>'//*[@data-ng-click="toogleDashboard();"]'}).click
  end

  def log_out
    @driver.elements({:xpath=>'//*[@title="Sign Out"]'}).click
  end

  #@!method select a program from dashboard screen
  # @param name=> name of the program to access
  def select_program(name)
    addressbook = @driver.elements({:xpath=>"//*[@id='PhoneMenu']/div[@class='item']/a[@data-app-name='Frapid.#{name}']"})
    addressbook.click
    case name
    when 'AddressBook' then
      self.extend AddressBook
    when 'Config' then
      self.extend Config
    end
  end
end