function ie_handler_neighbouring(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Neighbouring Devices")
    local nw_neighbouring_msg_header = lmac_mux_header:add("Neighbouring IE Message Header")


    local flag_ID = lbuffer(loffset, 1):bitfield(1, 1)
    nw_neighbouring_msg_header:add("ID: ", lbuffer(loffset, 1):bitfield(1, 1))
    local flag_mu = lbuffer(loffset, 1):bitfield(2, 1)
    nw_neighbouring_msg_header:add("Flag μ (Mu): ", lbuffer(loffset, 1):bitfield(2, 1))
    local flag_SNR = lbuffer(loffset, 1):bitfield(3, 1)
    nw_neighbouring_msg_header:add("Flag SNR: ", lbuffer(loffset, 1):bitfield(3, 1))
    local flag_RSSI_2 = lbuffer(loffset, 1):bitfield(4, 1)
    nw_neighbouring_msg_header:add("Flag RSSI-2 : ", lbuffer(loffset, 1):bitfield(4, 1))
    local flag_power_const = lbuffer(loffset, 1):bitfield(5, 1)
    nw_neighbouring_msg_header:add("Flag Power const: ", lbuffer(loffset, 1):bitfield(5, 1))
    local flag_next_channel = lbuffer(loffset, 1):bitfield(6, 1)
    nw_neighbouring_msg_header:add("Flag Next channel: ", lbuffer(loffset, 1):bitfield(6, 1))
    local flag_time_to_next = lbuffer(loffset, 1):bitfield(7, 1)
    nw_neighbouring_msg_header:add("Flag Time to next: ", lbuffer(loffset, 1):bitfield(7, 1))
    loffset = loffset + 1

    nw_neighbouring_msg_header:add("Network beacon period: ", lbuffer(loffset, 1):bitfield(0, 4))
    nw_neighbouring_msg_header:add("Cluster beacon period: ", lbuffer(loffset, 1):bitfield(4, 4))
    loffset = loffset + 1

    if (flag_ID == 1) then
        nw_neighbouring_msg_header:add("Long RD-ID: ", lbuffer(loffset, 4):bitfield(0, 32))
        loffset = loffset + 4
    end

    if(flag_next_channel == 1) then
        nw_neighbouring_msg_header:add("Next cluster channel: ", lbuffer(loffset, 2):bitfield(3, 13))
        loffset = loffset + 2
    end

    if(flag_time_to_next == 1) then
        nw_neighbouring_msg_header:add("Time to next: ", lbuffer(loffset, 4):bitfield(0, 32))
        loffset = loffset + 4
    end

    if(flag_RSSI_2 == 1) then
        nw_neighbouring_msg_header:add("RSSI-2: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    if(flag_SNR == 1) then
        nw_neighbouring_msg_header:add("SNR: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    if(flag_mu == 1) then
        nw_neighbouring_msg_header:add("Radio device class μ: ", lbuffer(loffset, 1):bitfield(0, 3))
        nw_neighbouring_msg_header:add("Radio device class β: ", lbuffer(loffset, 1):bitfield(3, 4))
        loffset = loffset + 1
    end

    return loffset

end