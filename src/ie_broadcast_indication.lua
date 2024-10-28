function ie_handler_broadcast_indication(loffset, lbuffer, lpinfo, lmac_mux_header)
    local nw_broadcast_indication_msg_header = lmac_mux_header:add("Broadcast Indication IE Message Header")

    local flag_indication_type = lbuffer(loffset, 1):bitfield(0, 3)
    nw_broadcast_indication_msg_header:add("Flag Indication type: ", lbuffer(loffset, 1):bitfield(0, 3))
    local flag_ID_type = lbuffer(loffset, 1):bitfield(3, 1)
    nw_broadcast_indication_msg_header:add("Flag ID type: ", lbuffer(loffset, 1):bitfield(3, 1))

    if (flag_indication_type == 1) then
        local flag_ACK_NACK = lbuffer(loffset, 1):bitfield(4, 1)
        nw_broadcast_indication_msg_header:add("Flag ACK/NACK: ", lbuffer(loffset, 1):bitfield(4, 1))
    end

    local flag_feedback = 0
    if (flag_indication_type == 1) then
        flag_feedback = lbuffer(loffset, 1):bitfield(5, 2)
        nw_broadcast_indication_msg_header:add("Feeback: ", lbuffer(loffset, 1):bitfield(5, 2))
    end

    local flag_resource_allocation = lbuffer(loffset, 1):bitfield(7, 1)
    nw_broadcast_indication_msg_header:add("Flag Resource allocation: ", lbuffer(loffset, 1):bitfield(7, 1))
    loffset = loffset + 1

    if (flag_ID_type == 1 and flag_indication_type ~= 1) then
        nw_broadcast_indication_msg_header:add("Long RD-ID: ", lbuffer(loffset, 4):bitfield(0, 32))
        loffset = loffset + 4
    else
        nw_broadcast_indication_msg_header:add("Short RD-ID: ", lbuffer(loffset, 2):bitfield(0, 16))
        loffset = loffset + 2
    end

    if (flag_feedback == 1) then
        nw_broadcast_indication_msg_header:add("Channel quality: ", lbuffer(loffset, 1):bitfield(4, 4))
    
    elseif (flag_feedback == 2) then
        nw_broadcast_indication_msg_header:add("Single layer = 0, Dual layer = 1: ", lbuffer(loffset, 1):bitfield(4, 1))
        nw_broadcast_indication_msg_header:add("Codebook index: ", lbuffer(loffset, 1):bitfield(5, 3))

    elseif (flag_feedback == 3) then
        nw_broadcast_indication_msg_header:add("Single layer = 0, Dual layer = 1, Four layer = 2: ", lbuffer(loffset, 1):bitfield(0, 2))
        nw_broadcast_indication_msg_header:add("Codebook index: ", lbuffer(loffset, 1):bitfield(2, 5))
    end

    return loffset
    
end