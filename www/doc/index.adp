<master>
  <property name="title">@title@</property>
  <property name="signatory">@signatory@</property>
  <property name="context_bar">@context_bar@</property>
  <property name="header_stuff"><link href="index.css" type="text/css" rel="stylesheet"></property>

  <h2>Why</h2>

  <p>This version of the @package_name@ is a first stab at a service
  contract offering a generalized interface to shipping operations
  such as obtaining quotes for services and tracking shipments.</p>

  <h2>Background</h2>

  <p>Shipping goods can be a common occurrence on OpenACS
  sites. Whether it is to ship goods sold through the <if
  @ecommerce_installed@ eq 1><a href="/doc/ecommerce"></if>ecommerce
  package<if @ecommerce_installed@ eq 1></a></if> or to return items
  after a problem report logged by the <if @ticket_tracker_installed@
  eq 1><a href="/doc/ticket-tracker"></if>ticket tracker<if
  @ticket_tracker_installed@ eq 1></a></if>.</p>

  <p>There are also many different shipping companies to choose from,
  e.g. <a href="http://www.ups.com">UPS</a>, <a
  href="http://www.fedex.com">FedEx</a>, <a
  href="http://www.airborne.com/">Airborne Express</a>, <a
  href="http://www.dhl.com/">DHL</a> and many others. Most of these
  shippers have Internet based APIs for initiating shipments and
  tracking parcels.</p>

  <p>Goal of the @package_name@ is to provide a single shipping
  interface to OpenACS packages regardless of the actual shipping
  method. Calling packages do not have to be aware of how shipments
  are handled; this could be one of the aforementioned shipping
  companies or an in-house solution.</p>

  <p>This version of the @package_name@ is very simple on purpose. The
  complex nature of the problem combined with the multitude of
  interfaces by shipping companies and the limited capabilities of the
  current <a href="/doc/acs-service-contract">ACS Service Contract
  API</a> warrant a careful and deliberate approach. Future versions
  will grow in capabilities while maintaining backwards compatibility
  where possible.</p>

  <h2>Usage</h2>

  <p>As is, the @package_name@ provides two operations:</p>

  <blockquote>

    <h3>RatesAndServicesSelection</h3>

    <p>The RatesAndServicesSelection returns a list of services
    offered by the shipper and their associated charges to ship the
    given parcel from A to B. Services are identified by the shippers
    service code.</p>

    <h3>ServiceDescription</h3>

    <p>The ServiceDescription operation returns the description of the
    service level identified by the service code.</p>

  </blockquote>

  <p>The @package_name@ only defines these operations. Concrete
  functions that implement the operations of the contract have to be
  written for each shipper. See the <a
  href="/doc/acs-service-contract">ACS Service contract</a> for
  details on writing implementations for service contracts.</p>

  <p class="note">Note: This release has been tested with PostgreSQL
  only. While the contract supports both databases I was not able to
  test the Oracle version. Please report any problems you might find
  in the <a href="http://openacs.org/sdm/">OpenACS SDM</a>.</p>

  <h2>API Reference</h2>

  <blockquote>

    <h3>RatesAndServicesSelection</h3>

    <p>The RatesAndServicesSelection operation takes 8 input arguments:</p>
    <ol>
      <li>

	<p><strong>orig_country_iso:string</strong></p>

	<p>The 2 letter ISO abbreviation of the country where the
	shipment originates. See the countries table for a complete
	list of ISO standard abbreviations. The countries table is
	part of the Reference Data - Country package. E.g. 'US'.</p>

      </li>
      <li>

	<p><strong>orig_zip_code:string</strong></p>

	<p>The zip code of the shipment's origin. E.g. '95062'.</p>

      </li>
      <li>

	<p><strong>dest_country_iso:string</strong></p>

	<p>The 2 letter ISO abbreviation of the destination country of
	the shipment. See the <code>countries</code> table for a
	complete list of ISO standard abbreviations. The countries
	table is part of the Reference Data - Country
	package. E.g. 'NL'.</p>

      </li>
      <li>

	<p><strong>dest_zip_code:string</strong></p>

	<p>The zip code of the shipment's destination. E.g. '7812
	PC'</p>

      </li>
      <li>
	
	<p><strong>shipment_value:string</strong></p>

	<p>The total value of the shipment. E.g. '49.99'.</p>

      </li>
      <li>

	<p><strong>value_currency_code:string</strong></p>

	<p>The 3 letter abbreviation of the currency used to express
	the shipment value in. See the <code>currencies</code table
	for a complete list of currency abbreviations. The currencies
	table is part of the Reference Data - Currency
	package. E.g. 'USD'.</p>

      </li>
      <li>

	<p><strong>shipment_weight:string</strong></p>

	<p>The total weight of the shipment. E.g. '7.8'.</p>

      </li>
      <li>

	<p><strong>weight_unit_of_measure:string</strong></p>

	<p>The unit of measure of the shipment weight. E.g. 'lbs'.</p>

      </li>
    </ol>

    <p>RatesAndServicesSelection returns a list of rates and services
    in a single parameter: rates_and_services:string. The
    rates_and_services value is a list of arrays. Each array contains
    the service_code of service level and the total_charges for the
    service. The following code example illustrates how the list
    should be interpreted.</p>

    <pre> 
      <code>
	set rates_and_services [acs_sc_call "ShippingGateway" "RatesAndServicesSelection" \
				    [list "$orig_country_iso" "$orig_zip_code" "$dest_country_iso" "$dest_zip_code" \
	                                "$shipment_value" "$value_currency_code" "$shipment_weight" "$weight_unit_of_measure"] \
				        "$shipping_gateway"]
        foreach service $rates_and_services {
	    array set rate_and_service $service
	    set total_charges $rate_and_service(total_charges)
	    set service_code $rate_and_service(service_code)
	    set service_description [acs_sc_call "ShippingGateway" "ServiceDescription" \
					"$service_code" \
					 "$shipping_gateway"]

        }
      </code>
    </pre>
    
    <h3>ServiceDescription</h3>

    <p>ServiceDescription has only one input argument:
    service_code:string. The operation also returns a single
    parameter: service_description:string. See the above code example
    for an illustration of use of the ServiceDescription
    operation.</p>

  </blockquote>

  <h2>Credits</h2>

  <p>The @package_name@ was designed and written by <a
  href="mailto:bart.teeuwisse@7-sisters.com">Bart Teeuwisse</a> for <a
  href="http://www.berklee.edu">Berklee College Of Music</a> while
  working as a subcontractor for <a
  href="http://www.furfly.net">furfly.net</a>.</p>

  <p>The @package_name@ is free software; you can redistribute it
    and/or modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2 of
    the License, or (at your option) any later version.</p>

  <p>The @package_name@ is distributed in the hope that it will be
    useful, but WITHOUT ANY WARRANTY; without even the implied
    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU General Public License for more details.</p>

  <p>A <a href="license">copy of the GNU General Public License</a> is
    included. If not write to the Free Software Foundation, Inc., 59
    Temple Place, Suite 330, Boston, MA 02111-1307 USA
