function ie_handler_reconfiguration_response_message(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Reconfiguration response")
    local nw_reconfiguration_request_msg_hdr = lmac_mux_header:add("Reconfiguration Response Message Header")

    local tx_harq = lbuffer(loffset, 1):bitfield(0, 1)
    nw_reconfiguration_request_msg_hdr:add("TX HARQ: ", lbuffer(loffset, 1):bitfield(0, 1))
    local rx_harq = lbuffer(loffset, 1):bitfield(1, 1)
    nw_reconfiguration_request_msg_hdr:add("RX HARQ: ", lbuffer(loffset, 1):bitfield(1, 1))
    nw_reconfiguration_request_msg_hdr:add("RD Capability: ", lbuffer(loffset, 1):bitfield(2, 1))
    local n_flows = lbuffer(loffset, 1):bitfield(3, 3)
    nw_reconfiguration_request_msg_hdr:add("Number of Flows: ", lbuffer(loffset, 1):bitfield(3, 3))
    nw_reconfiguration_request_msg_hdr:add("Radio Resources: ", lbuffer(loffset, 1):bitfield(6, 2))
    loffset = loffset + 1

    if (tx_harq == 1) then
        nw_reconfiguration_request_msg_hdr:add("HARQ Processes TX: ", lbuffer(loffset, 1):bitfield(0, 3))
        nw_reconfiguration_request_msg_hdr:add("MAX HARQ RE-TX ", lbuffer(loffset, 1):bitfield(3, 5))
        loffset = loffset + 1
    end

    if (rx_harq == 1) then
        nw_reconfiguration_request_msg_hdr:add("HARQ Processes RX: ", lbuffer(loffset, 1):bitfield(0, 3))
        nw_reconfiguration_request_msg_hdr:add("MAX HARQ RE-RX ", lbuffer(loffset, 1):bitfield(3, 5))
        loffset = loffset + 1
    end

    if (n_flows > 1) then
        for i = 1,n_flows,1
        do
            nw_reconfiguration_request_msg_hdr:add("Setup/Release " .. i .. ": ", lbuffer(loffset, 1):bitfield(0, 1))
            nw_reconfiguration_request_msg_hdr:add("Flow ID  " .. i .. ": ", lbuffer(loffset, 1):bitfield(2, 6))
            loffset = loffset + 1
        end
    end

    return loffset

end