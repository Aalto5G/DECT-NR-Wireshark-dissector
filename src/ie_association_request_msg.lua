function ie_handler_association_request_message(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Inside association request message")
    local association_req_msg = lmac_mux_header:add("Association Request Message")
    association_req_msg:add("Setup Cause: ", lbuffer(loffset, 1):bitfield(0,3))
    association_req_msg:add("Number of flows: ", lbuffer(loffset, 1):bitfield(3, 3))
    association_req_msg:add("Power Const: ", lbuffer(loffset, 1):bitfield(6, 1))
    local ft_mode = lbuffer(loffset, 1):bitfield(7,1)
    association_req_msg:add("FT mode: ", ft_mode)
    loffset = loffset + 1
    local current = lbuffer(loffset, 1):bitfield(0, 1)
    association_req_msg:add("Current: ", current)
    loffset = loffset + 1
    association_req_msg:add("HARQ Process Tx: ", lbuffer(loffset, 1):bitfield(0, 3))
    association_req_msg:add("MAX HARQ Re-Tx: ", lbuffer(loffset, 1):bitfield(3, 5))
    loffset = loffset + 1
    association_req_msg:add("HARQ Proess Rx: ", lbuffer(loffset, 1):bitfield(0, 3))
    association_req_msg:add("MAX HARQ Re-Rx: ", lbuffer(loffset, 1):bitfield(3, 5))
    loffset = loffset + 1
    association_req_msg:add("Flow ID: ", lbuffer(loffset, 1):bitfield(2, 6))
    loffset = loffset + 1

    if (ft_mode == 1) then
        association_req_msg:add("Network beacon period: ", lbuffer(loffset, 1):bitfield(0, 4))
        association_req_msg:add("Cluster beacon period: ", lbuffer(loffset, 1):bitfield(4, 4))
        loffset = loffset + 1
        local next_cluster_channel = lbuffer(loffset, 2):bitfield(3, 13)
        association_req_msg:add("Next Cluster Channel: ", next_cluster_channel)
        loffset = loffset + 2
        association_req_msg:add("Time to Next: ", lbuffer(loffset, 4):bitfield(0, 32))
        loffset = loffset + 4

        if (current == 1) then
            association_req_msg:add("Current Cluster Channel: ", lbuffer(loffset, 2):bitfield(3, 13))
            loffset = loffset + 2
        else
            association_req_msg:add("Current Cluster Channel: ", next_cluster_channel)
            loffset = loffset + 2
        end
    end

    return loffset

end