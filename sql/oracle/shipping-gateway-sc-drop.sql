begin
    acs_sc_operation.delete('ShippingGateway','RatesAndServicesSelection');
    acs_sc_msg_type.delete('ShippingGateway.RatesAndServicesSelection.InputType');
    acs_sc_msg_type.delete('ShippingGateway.RatesAndServicesSelection.OutputType');
    acs_sc_operation.delete('ShippingGateway','ServiceDescription');
    acs_sc_msg_type.delete('ShippingGateway.ServiceDescription.InputType');
    acs_sc_msg_type.delete('ShippingGateway.ServiceDescription.OutputType');
    acs_sc_contract.delete('ShippingGateway');
end;
/
show errors
