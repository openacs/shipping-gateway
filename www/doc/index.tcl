ad_page_contract {

    Index to documentation of Shipping Service Contract.

    @author Bart Teeuwisse <bart.teeuwisse@7-sisters.com>
    @creation-date May 2002

} {
} -properties {
    title:onevalue
    context_bar:onevalue
}

# Authenticate the user

set user_id [ad_maybe_redirect_for_registration]

set package_name "Shipping Service Contract"
set title "$package_name Documentation"

# Check if the ecommerce and the ticket-tracker packages are installed
# on the system.

set ecommerce_installed [apm_package_installed_p ecommerce]
set ticket_tracker_installed [apm_package_installed_p ticket-tracker]

# Set the context bar.

set context_bar [ad_context_bar $package_name]

# Set signatory for at the bottom of the page

set signatory "bart.teeuwisse@7-sisters.com"
