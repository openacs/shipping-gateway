begin
    acs_sc_operation.del('ShippingGateway','RatesAndServicesSelection');
    acs_sc_msg_type.del('ShippingGateway.RatesAndServicesSelection.InputType');
    acs_sc_msg_type.del('ShippingGateway.RatesAndServicesSelection.OutputType');
    acs_sc_operation.del('ShippingGateway','ServiceDescription');
    acs_sc_msg_type.del('ShippingGateway.ServiceDescription.InputType');
    acs_sc_msg_type.del('ShippingGateway.ServiceDescription.OutputType');
    acs_sc_contract.del('ShippingGateway');
end;
/
show errors
