function ie_handler_association_response_message(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Inside association response message")
    local association_resp_msg = lmac_mux_header:add("Association Response Message")
    local ack_nack = lbuffer(loffset, 1):bitfield(0, 1)
    association_resp_msg:add("ACK/NACK", ack_nack)
    local harq_mode = lbuffer(loffset, 1):bitfield(2, 1)
    association_resp_msg:add("HARQ-mod", harq_mode)
    association_resp_msg:add("Number of Flows", lbuffer(loffset, 1):bitfield(3, 3))
    local group = lbuffer(loffset, 1):bitfield(6, 1)
    association_resp_msg:add("Group", group)
    association_resp_msg:add("TX Power", lbuffer(loffset, 1):bitfield(7,1))
    loffset = loffset + 1

    if (ack_nack == 0) then
        association_resp_msg:add("Reject Cause", lbuffer(loffset, 1):bitfield(0, 4))
        association_resp_msg:add("Reject Time", lbuffer(loffset, 1):bitfield(4, 4))
        loffset = loffset + 1
    end

    if (harq_mode == 1) then
        association_resp_msg:add("HARQ Process RX", lbuffer(loffset, 1):bitfield(0, 3))
        association_resp_msg:add("MAX HARQ RE-RX", lbuffer(loffset, 1):bitfield(3, 5))
        loffset = loffset + 1
        association_resp_msg:add("HARQ Process TX", lbuffer(loffset, 1):bitfield(0, 3))
        association_resp_msg:add("MAX HARQ RE-TX", lbuffer(loffset, 1):bitfield(3, 5))
        loffset = loffset + 1
    end

    association_resp_msg:add("Flow ID", lbuffer(loffset, 1):bitfield(2, 6))
    loffset = loffset + 1

    if (group == 1) then
        association_resp_msg:add("Group ID", lbuffer(loffset, 1):bitfield(1, 7))
        loffset = loffset + 1
        association_resp_msg:add("Resource TAG", lbuffer(loffset, 1):bitfield(1, 7))
        loffset = loffset + 1
    end

    return loffset
end