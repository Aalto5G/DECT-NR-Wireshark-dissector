function ie_handler_load_info(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Load Info")
    local nw_load_info_msg_hdr = lmac_mux_header:add("Load Info IE Message Header")

    local max_assoc = lbuffer(loffset, 1):bitfield(4, 1)
    nw_load_info_msg_hdr:add("Max assoc: ", lbuffer(loffset, 1):bitfield(4, 1))
    local rd_pt_load = lbuffer(loffset, 1):bitfield(5, 1)
    nw_load_info_msg_hdr:add("RD PT load: ", lbuffer(loffset, 1):bitfield(5, 1))
    local rach_load = lbuffer(loffset, 1):bitfield(6, 1)
    nw_load_info_msg_hdr:add("RACH load: ", lbuffer(loffset, 1):bitfield(6, 1))
    local channel_load = lbuffer(loffset, 1):bitfield(7, 1)
    nw_load_info_msg_hdr:add("Channel load: ", lbuffer(loffset, 1):bitfield(7, 1))
    loffset = loffset + 1

    nw_load_info_msg_hdr:add("Traffic Load percentage: ", lbuffer(loffset, 1):bitfield(0, 8))
    loffset = loffset + 1

    if (max_assoc == 0) then
        nw_load_info_msg_hdr:add("Max number of  associated RDs: ", lbuffer(loffset, 2):bitfield(0, 8))
        loffset = loffset + 1
    else
        nw_load_info_msg_hdr:add("Max number of  associated RDs: ", lbuffer(loffset, 1):bitfield(0, 16))
        loffset = loffset + 2
    end

    nw_load_info_msg_hdr:add("Currently associated RDs in FT mode percentage: ", lbuffer(loffset, 1):bitfield(0, 8))
    loffset = loffset + 1

    if (rd_pt_load == 1) then
        nw_load_info_msg_hdr:add("Currently associated RDs in PT mode percentage: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    if (rach_load == 1) then
        nw_load_info_msg_hdr:add("RACH Load in percentage: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    if (channel_load == 1) then
        nw_load_info_msg_hdr:add("Percentage of subslots detected \"free\": ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
        nw_load_info_msg_hdr:add("Percentage of subslots detected \"busy\": ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    return loffset

end