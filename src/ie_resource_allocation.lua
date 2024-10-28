function ie_handler_resource_allocation(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Resource Allocation")

    -- Hardcoding the radio_device_class_mu FOR NOW!
    -- TODO: Find a way to track BOTH the device and the class variables with that device.
    local radio_device_class_mu = 0
    local linktype = "None"

    local nw_resource_allocation_msg_hdr = lmac_mux_header:add("Resource Allocation IE Message Header")
    
    local flag_allocation_type = lbuffer(loffset, 1):bitfield(0, 2)
    nw_resource_allocation_msg_hdr:add("Flag Allocation type: ", lbuffer(loffset, 1):bitfield(0, 2))

    if(flag_allocation_type == 0) then -- All resources release, no further action.
        loffset = loffset + 1
        return loffset
    end

    --local flag_add = lbuffer(loffset, 1):bitfield(2, 1)
    nw_resource_allocation_msg_hdr:add("Flag Add: ", lbuffer(loffset, 1):bitfield(2, 1))
    local flag_ID = lbuffer(loffset, 1):bitfield(3, 1)
    nw_resource_allocation_msg_hdr:add("Flag ID: ", lbuffer(loffset, 1):bitfield(3, 1))
    local flag_repeat = lbuffer(loffset, 1):bitfield(4, 3)
    nw_resource_allocation_msg_hdr:add("Flag Repeat: ", lbuffer(loffset, 1):bitfield(4, 3))
    local flag_SFN = lbuffer(loffset, 1):bitfield(7, 1)
    nw_resource_allocation_msg_hdr:add("Flag SFN: ", lbuffer(loffset, 1):bitfield(7, 1))
    loffset = loffset + 1
    local flag_channel = lbuffer(loffset, 1):bitfield(0, 1)
    nw_resource_allocation_msg_hdr:add("Flag Channel: ", lbuffer(loffset, 1):bitfield(0, 1))
    local flag_RLF = lbuffer(loffset, 1):bitfield(1, 1)
    nw_resource_allocation_msg_hdr:add("Flag RLF: ", lbuffer(loffset, 1):bitfield(1, 1))
    loffset = loffset + 1

    if (flag_allocation_type == 3) then
        if(radio_device_class_mu > 4) then -- Variable radio_device_class_mu has to be accessibe here in someway, ask Jaakko and Harikumar
            nw_resource_allocation_msg_hdr:add("Start subslot DL (16-bit): ", lbuffer(loffset, 2):bitfield(0, 16))
            loffset = loffset + 2
        else
            nw_resource_allocation_msg_hdr:add("Start subslot DL (8-bit): ", lbuffer(loffset, 2):bitfield(0, 8))
            loffset = loffset + 1
        end

        nw_resource_allocation_msg_hdr:add("Length type DL: ", lbuffer(loffset, 1):bitfield(0, 1))
        nw_resource_allocation_msg_hdr:add("Length DL: ", lbuffer(loffset, 1):bitfield(1, 7))
        loffset = loffset + 1

        if(radio_device_class_mu > 4) then -- Variable radio_device_class_mu has to be accessibe here in someway, for not it is hardcoded
            nw_resource_allocation_msg_hdr:add("Start subslot UL (16-bit): ", lbuffer(loffset, 2):bitfield(0, 16))
            loffset = loffset + 2
        else
            nw_resource_allocation_msg_hdr:add("Start subslot UL (8-bit): ", lbuffer(loffset, 2):bitfield(0, 8))
            loffset = loffset + 1
        end

        nw_resource_allocation_msg_hdr:add("Length type UL: ", lbuffer(loffset, 1):bitfield(0, 1))
        nw_resource_allocation_msg_hdr:add("Length UL: ", lbuffer(loffset, 1):bitfield(1, 7))
        loffset = loffset + 1
    
    else
        
        if (flag_allocation_type == 1) then
            linktype = " downlink"
        else
            linktype = " uplink"
        end

        if(radio_device_class_mu > 4) then -- Variable radio_device_class_mu has to be accessibe here in someway, for now it is hardcoded
            nw_resource_allocation_msg_hdr:add("Start subslot ".. linktype .." (16-bit): ", lbuffer(loffset, 2):bitfield(0, 16))
            loffset = loffset + 2
        else
            nw_resource_allocation_msg_hdr:add("Start subslot".. linktype .." (8-bit): ", lbuffer(loffset, 2):bitfield(0, 8))
            loffset = loffset + 1
        end

        nw_resource_allocation_msg_hdr:add("Length type ".. linktype ..": ", lbuffer(loffset, 1):bitfield(0, 1))
        nw_resource_allocation_msg_hdr:add("Length ".. linktype ..": ", lbuffer(loffset, 1):bitfield(1, 7))
        loffset = loffset + 1
    end

    if(flag_ID == 1) then
        nw_resource_allocation_msg_hdr:add("RD-ID: ", lbuffer(loffset, 2):bitfield(0, 16))
        loffset = loffset + 2
    end
    if (flag_repeat ~= 0) then
        nw_resource_allocation_msg_hdr:add("Repetition: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1

        nw_resource_allocation_msg_hdr:add("Validity: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    if (flag_SFN ~= 0) then
        nw_resource_allocation_msg_hdr:add("SFN Value: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    if (flag_channel ~= 0) then
        nw_resource_allocation_msg_hdr:add("Channel: ", lbuffer(loffset, 2):bitfield(3, 13))
        loffset = loffset + 2
    end

    if (flag_RLF ~= 0) then
        nw_resource_allocation_msg_hdr:add("dectScheduledResourceFailure: ", lbuffer(loffset, 1):bitfield(4, 4))
        loffset = loffset + 1
    end

    return loffset

end