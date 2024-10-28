function ie_handler_random_access_resource(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Random Access Resources")
    local nw_random_access_resource_msg_hdr = lmac_mux_header:add("Random Access Resources IE Message Header")

    -- Hardcoding the radio_device_class_mu FOR NOW!
    -- TODO: Find a way to track BOTH the device and the class variables with that device.
    local radio_device_class_mu = 0


    --local flag_reserved = lbuffer(loffset, 1):bitfield(0, 3)
    --nw_random_access_resource_msg_hdr:add("Flag Reserved: ", lbuffer(loffset, 1):bitfield(0, 3))
--    local flag_protime = lbuffer(loffset, 1):bitfield(2, 1)
--    nw_random_access_resource_msg_hdr:add("Flag ProTime: ", lbuffer(loffset, 1):bitfield(2, 1))
    local flag_repeat = lbuffer(loffset, 1):bitfield(3, 2)
    nw_random_access_resource_msg_hdr:add("Flag Repeat: ", lbuffer(loffset, 1):bitfield(3, 2))
    local flag_SFN = lbuffer(loffset, 1):bitfield(5, 1)
    nw_random_access_resource_msg_hdr:add("Flag SFN: ", lbuffer(loffset, 1):bitfield(5, 1))
    local flag_channel = lbuffer(loffset, 1):bitfield(6, 1)
    nw_random_access_resource_msg_hdr:add("Flag Channel: ", lbuffer(loffset, 1):bitfield(6, 1))
    local flag_chan_2 = lbuffer(loffset, 1):bitfield(7, 1)
    nw_random_access_resource_msg_hdr:add("Flag Chan_2: ", lbuffer(loffset, 1):bitfield(7, 1))
    loffset = loffset + 1

    if(radio_device_class_mu > 4) then -- Variable radio_device_class_mu has to be accessibe here in someway, ask Jaakko and Harikumar
        nw_random_access_resource_msg_hdr:add("Start subslot (16-bit): ", lbuffer(loffset, 2):bitfield(0, 16))
        loffset = loffset + 2
    else
        nw_random_access_resource_msg_hdr:add("Start subslot (8-bit): ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    nw_random_access_resource_msg_hdr:add("Length type: ", lbuffer(loffset, 1):bitfield(0, 1))
    nw_random_access_resource_msg_hdr:add("Length: ", lbuffer(loffset, 1):bitfield(1, 7))
    loffset = loffset + 1

    nw_random_access_resource_msg_hdr:add("Length type: ", lbuffer(loffset, 1):bitfield(0, 1))
    nw_random_access_resource_msg_hdr:add("MAX RACH Length: ", lbuffer(loffset, 1):bitfield(1, 4))
    nw_random_access_resource_msg_hdr:add("CW Min sig: ", lbuffer(loffset, 1):bitfield(5, 3))
    loffset = loffset + 1

    nw_random_access_resource_msg_hdr:add("DECT delay: ", lbuffer(loffset, 1):bitfield(0, 1))
    nw_random_access_resource_msg_hdr:add("Response window: ", lbuffer(loffset, 1):bitfield(1, 4))
    nw_random_access_resource_msg_hdr:add("CW Max sig: ", lbuffer(loffset, 1):bitfield(5, 3))
    loffset = loffset + 1

--    if(flag_protime == 1) then
--        nw_random_access_resource_msg_hdr:add("dectProtime: ", lbuffer(loffset, 1):bitfield(0, 8))
--        loffset = loffset + 1
--    end

    if (flag_repeat ~= 0) then
        nw_random_access_resource_msg_hdr:add("Repetition: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1

        nw_random_access_resource_msg_hdr:add("Validity: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    if(flag_SFN == 1) then
        nw_random_access_resource_msg_hdr:add("SFN offset: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    if(flag_channel == 1) then
        nw_random_access_resource_msg_hdr:add("Channel: ", lbuffer(loffset, 2):bitfield(3, 13))
        loffset = loffset + 2
    end

    if(flag_chan_2 == 1) then
        nw_random_access_resource_msg_hdr:add("Chan_2: ", lbuffer(loffset, 2):bitfield(3, 13))
        loffset = loffset + 2
    end

    return loffset

end
