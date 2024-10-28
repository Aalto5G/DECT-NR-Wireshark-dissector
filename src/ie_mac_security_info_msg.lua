function ie_handler_security_info(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("MAC Security Info")
    local nw_mac_security_info_msg_hdr = lmac_mux_header:add("MAC Security Info IE Message Header")

    nw_mac_security_info_msg_hdr:add("Version: ", lbuffer(loffset, 1):bitfield(0, 2))
    nw_mac_security_info_msg_hdr:add("Key Index: ", lbuffer(loffset, 1):bitfield(2, 2))
    nw_mac_security_info_msg_hdr:add("Security IV Type: ", lbuffer(loffset, 1):bitfield(4, 4))
    loffset = loffset + 1
    nw_mac_security_info_msg_hdr:add("HPC: ", lbuffer(loffset, 4):bitfield(0, 32))
    loffset = loffset + 4

    return loffset

end