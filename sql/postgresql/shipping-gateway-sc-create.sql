-- Definition of the ShippingGateway service contract.

select acs_sc_contract__new (
           'ShippingGateway',			       -- contract_name
	   'Interface to shipping rates and services'  -- contract_desc
);

-- RatesAndServicesSelection returns a list of arrays. Each array
-- contains the service level code (service_code) and the associated
-- total charges (total_charges) for the shipment.

select acs_sc_msg_type__new (
           'ShippingGateway.RatesAndServicesSelection.InputType',
	   'orig_country_iso:string,orig_zip_code:string,dest_country_iso:string,dest_zip_code:string,shipment_value:string,value_currency_code:string,shipment_weight:string,weight_unit_of_measure:string'
);

select acs_sc_msg_type__new (
           'ShippingGateway.RatesAndServicesSelection.OutputType',
	   'rates_and_services:string'
);

select acs_sc_operation__new (
           'ShippingGateway',			  			-- contract_name
           'RatesAndServicesSelection',		  			-- operation_name
	   'Select shipping rates and services',  			-- operation_desc
	   'f',					  			-- operation_iscachable_p
	    8,					  			-- operation_nargs
	   'ShippingGateway.RatesAndServicesSelection.InputType',  	-- operation_inputtype
	   'ShippingGateway.RatesAndServicesSelection.OutputType'  	-- operation_outputtype
);

-- ServiceDescription retrieves the description of a service level
-- code (service_code). The description is returned as a string.

select acs_sc_msg_type__new (
           'ShippingGateway.ServiceDescription.InputType',
	   'service_code:string'
);

select acs_sc_msg_type__new (
           'ShippingGateway.ServiceDescription.OutputType',
	   'service_description:string'
);

select acs_sc_operation__new (
           'ShippingGateway',					-- contract_name
           'ServiceDescription',				-- operation_name
	   'Get service level description',			-- operation_desc
	   'f',							-- operation_iscachable_p
	    1,							-- operation_nargs
	   'ShippingGateway.ServiceDescription.InputType',  	-- operation_inputtype
	   'ShippingGateway.ServiceDescription.OutputType'  	-- operation_outputtype
);
