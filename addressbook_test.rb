require_relative 'login_main'
require_relative 'contact'


ct = Contact.new
browser = LoginMainmenu.new
sleep 3


browser.select_program('AddressBook')
sleep 5
browser.contacts_count
browser.fill_contact_data ct
sleep 5
browser.contacts_count


browser.select_contact ct
sleep 5
browser.validate_values ct
sleep 15


browser.delete_contact ct
sleep 5
browser.contacts_count


browser.dashboard
sleep 3
browser.log_out