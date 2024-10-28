function ie_handler_radio_device_status(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Radio Device Status IE")
    local nw_radio_device_status_msg_hdr = lmac_mux_header:add("Measurement Report Message Header")

    nw_radio_device_status_msg_hdr:add("Status flag: ", lbuffer(loffset, 1):bitfield(2, 2))
    nw_radio_device_status_msg_hdr:add("Duration: ", lbuffer(loffset, 1):bitfield(4, 4))
    loffset = loffset + 1

    return loffset

end