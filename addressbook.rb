require_relative 'driver'
require_relative 'complement'

module AddressBook
  include Complement

  #@!method gives the number of contact in the list
  def contacts_count
    contacts = @driver.elements({:class=>'entry'}, true)

    if contacts.size == 0
      @driver.log_message 'contacts list is empty'
    else
      @driver.log_message 'contacts list count: '+ contacts.size.to_s, 'error'
    end
  end

  #@!method fill and save the contact
  def fill_contact_data(contact = Contact.new)

    @driver.elements({:id=>'PrefixInputText'}).send_keys(contact.prefix)
    @driver.elements({:id=>'SuffixInputText'}).send_keys(contact.sufix)
    @driver.elements({:id=>'FirstNameInputText'}).send_keys(contact.firstName)
    @driver.elements({:id=>'MiddleNameInputText'}).send_keys(contact.middleName)
    @driver.elements({:id=>'LastNameInputText'}).send_keys(contact.lastName)

    unless contact.emails.nil?
      contact.emails.each { |x|
        @driver.elements({:xpath=>'//*[@id="EmailAddressesDiv"]/input'}).send_keys(x)
        @driver.elements({:xpath=>'//*[@id="EmailAddressesDiv"]/input'}).send_keys(:enter)
      }
    end

    unless contact.phones.nil?
      contact.phones.each { |x|
        @driver.elements({:xpath=>'//*[@id="MobileNumbersDiv"]/input'}).send_keys(x)
        @driver.elements({:xpath=>'//*[@id="MobileNumbersDiv"]/input'}).send_keys(:enter)
      }
    end

    sleep 10
    @driver.elements({:id=>'SaveButton'}).click
    @driver.log_message "Saved contact: #{contact.firstName} #{contact.middleName} #{contact.lastName}"
  end

  def select_contact contact
    @driver.elements({:xpath=>"//*[text()[contains(.,'#{contact.firstName} #{contact.middleName} #{contact.lastName}')]]"}).click
    @driver.log_message "Selected contact: #{contact.firstName} #{contact.middleName} #{contact.lastName}"
  end

  #@!method review of the saved values
  def validate_values contact
    @driver.log_message 'First Name is not equal', 'error' unless @driver.elements({:id=>'FirstNameInputText'}).attribute("value").eql? contact.firstName
    @driver.log_message 'Middle Name is not equal', 'error' unless @driver.elements({:id=>'MiddleNameInputText'}).attribute("value").eql? contact.middleName
    @driver.log_message 'Last Name is not equal', 'error' unless @driver.elements({:id=>'LastNameInputText'}).attribute("value").eql? contact.lastName
  end

  def delete_contact contact
    select_contact contact
    deleteButton = @driver.elements({:id=>'DeleteAnchor', :class=>'item'})
    deleteButton.location_once_scrolled_into_view
    deleteButton.click
    alert = @driver.switch_to_popup
    sleep 3
    alert.accept
    @driver.log_message "Deleted contact: #{contact.firstName} #{contact.middleName} #{contact.lastName}"
  end

end