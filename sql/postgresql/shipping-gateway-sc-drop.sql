select acs_sc_operation__delete('ShippingGateway','RatesAndServicesSelection');
select acs_sc_msg_type__delete('ShippingGateway.RatesAndServicesSelection.InputType');
select acs_sc_msg_type__delete('ShippingGateway.RatesAndServicesSelection.OutputType');
select acs_sc_operation__delete('ShippingGateway','ServiceDescription');
select acs_sc_msg_type__delete('ShippingGateway.ServiceDescription.InputType');
select acs_sc_msg_type__delete('ShippingGateway.ServiceDescription.OutputType');
select acs_sc_contract__delete('ShippingGateway');