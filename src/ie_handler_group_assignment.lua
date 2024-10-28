function ie_handler_group_assignment(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Group Assignment")
    local nw_group_assignment_msg_hdr = lmac_mux_header:add("Group Assignment Message Header")

    nw_group_assignment_msg_hdr:add("Single: ", lbuffer(loffset, 1):bitfield(0, 1))
    nw_group_assignment_msg_hdr:add("Group ID: ", lbuffer(loffset, 1):bitfield(1, 7))
    loffset = loffset + 1
    
    for i = 1,1,1 --TODO determine number of resource tags
    do
        nw_group_assignment_msg_hdr:add("Direct " .. i .. ": ", lbuffer(loffset, 1):bitfield(0, 1))
        nw_group_assignment_msg_hdr:add("Resource Tag  " .. i .. ": ", lbuffer(loffset, 1):bitfield(1, 7))
        loffset = loffset + 1
    end

    return loffset

end