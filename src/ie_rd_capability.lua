function ie_handler_rd_capability(loffset, lbuffer, lpinfo, lmac_mux_header)

    -- Values here are needed elsewhere, how to do that?
    print("RD Capability")
    local nw_rd_capability_msg_header = lmac_mux_header:add("RD Capability IE Message Header")

    -- Documentation actually indicates that there can be multiple repeats of the 4 subvalues in a class.
    local flag_number_of_PHY_capabilities = lbuffer(loffset, 1):bitfield(0, 3)
    nw_rd_capability_msg_header:add("Number of PHY capabilities: ", lbuffer(loffset, 1):bitfield(0, 3))
    local flag_release = lbuffer(loffset, 1):bitfield(3, 5)
    nw_rd_capability_msg_header:add("Release: ", lbuffer(loffset, 1):bitfield(3, 5))
    loffset = loffset + 1

    local flag_groupAS = lbuffer(loffset, 1):bitfield(2, 1)
    nw_rd_capability_msg_header:add("Group Assignment: ", lbuffer(loffset, 1):bitfield(2, 1))
    local flag_paging = lbuffer(loffset, 1):bitfield(3, 1)
    nw_rd_capability_msg_header:add("Paging: ", lbuffer(loffset, 1):bitfield(3, 1))
    local flag_operating_modes = lbuffer(loffset, 1):bitfield(4, 2)
    nw_rd_capability_msg_header:add("Operating Modes: ", lbuffer(loffset, 1):bitfield(4, 2))
    local flag_mesh = lbuffer(loffset, 1):bitfield(6, 1)
    nw_rd_capability_msg_header:add("Mesh: ", lbuffer(loffset, 1):bitfield(6, 1))
    local flag_schedul = lbuffer(loffset, 1):bitfield(7, 1)
    nw_rd_capability_msg_header:add("Schedule: ", lbuffer(loffset, 1):bitfield(7, 1))
    loffset = loffset + 1

    local flag_MAC_security = lbuffer(loffset, 1):bitfield(0, 3)
    nw_rd_capability_msg_header:add("MAC Security: ", lbuffer(loffset, 1):bitfield(0, 3))
    local flag_DLC_service_type = lbuffer(loffset, 1):bitfield(3, 3)
    nw_rd_capability_msg_header:add("DLC Service Type: ", lbuffer(loffset, 1):bitfield(3, 3))
    loffset = loffset + 1

    local flag_RD_power_class = lbuffer(loffset, 1):bitfield(1, 3)
    nw_rd_capability_msg_header:add("RD Power Class: ", lbuffer(loffset, 1):bitfield(1, 3))
    local flag_Max_NSS_for_RX = lbuffer(loffset, 1):bitfield(4, 2)
    nw_rd_capability_msg_header:add("Max NSS for RX: ", lbuffer(loffset, 1):bitfield(4, 2))
    local flag_RX_for_TX_diversity = lbuffer(loffset, 1):bitfield(6, 2)
    nw_rd_capability_msg_header:add("RX for TX Diveristy: ", lbuffer(loffset, 1):bitfield(6, 2))
    loffset = loffset + 1
            
    local flag_RX_gain = lbuffer(loffset, 1):bitfield(0, 4)
    nw_rd_capability_msg_header:add("RX Gain: ", lbuffer(loffset, 1):bitfield(0, 4))
    local flag_Max_MCS = lbuffer(loffset, 1):bitfield(4, 4)
    nw_rd_capability_msg_header:add("Max MCS: ", lbuffer(loffset, 1):bitfield(4, 4))
    loffset = loffset + 1

    local flag_soft_buffer_size = lbuffer(loffset, 1):bitfield(0, 4)
    nw_rd_capability_msg_header:add("Soft-buffer Size: ", lbuffer(loffset, 1):bitfield(0, 4))
    local flag_num_of_HARQ_proce = lbuffer(loffset, 1):bitfield(4, 2)
    nw_rd_capability_msg_header:add("Number of HARQ processes: ", lbuffer(loffset, 1):bitfield(4, 2))
    loffset = loffset + 1

    local flag_HARQ_feedback_delay = lbuffer(loffset, 1):bitfield(0, 4)
    nw_rd_capability_msg_header:add("HARQ Feedback Delay: ", lbuffer(loffset, 1):bitfield(0, 4))
    local flag_D_delay = lbuffer(loffset, 1):bitfield(4, 1)
    nw_rd_capability_msg_header:add("DECT Delay: ", lbuffer(loffset, 1):bitfield(4, 1))
    local flag_halfdup = lbuffer(loffset, 1):bitfield(5, 1)
    nw_rd_capability_msg_header:add("Half-Duplex: ", lbuffer(loffset, 1):bitfield(5, 1))
    loffset = loffset + 1
    
    local flag_radio_device_class_mu = lbuffer(loffset, 1):bitfield(0, 3)
    nw_rd_capability_msg_header:add("Radio Device Class Mu: ", lbuffer(loffset, 1):bitfield(0, 3))
    local flag_radio_device_class_beta = lbuffer(loffset, 1):bitfield(3, 4)
    nw_rd_capability_msg_header:add("Radio Device Class Beta: ", lbuffer(loffset, 1):bitfield(3, 4))
    loffset = loffset + 1

    local flag_RD_power_class2 = lbuffer(loffset, 1):bitfield(1, 3)
    nw_rd_capability_msg_header:add("RD Power Class 2: ", lbuffer(loffset, 1):bitfield(1, 3))
    local flag_Max_NSS_for_RX2 = lbuffer(loffset, 1):bitfield(4, 2)
    nw_rd_capability_msg_header:add("Max NSS for RX 2: ", lbuffer(loffset, 1):bitfield(4, 2))
    local flag_RX_for_TX_diversity2 = lbuffer(loffset, 1):bitfield(6, 2)
    nw_rd_capability_msg_header:add("RX for TX Diveristy 2: ", lbuffer(loffset, 1):bitfield(6, 2))
    loffset = loffset + 1
            
    local flag_RX_gain2 = lbuffer(loffset, 1):bitfield(0, 4)
    nw_rd_capability_msg_header:add("RX Gain 2: ", lbuffer(loffset, 1):bitfield(0, 4))
    local flag_Max_MCS2 = lbuffer(loffset, 1):bitfield(4, 4)
    nw_rd_capability_msg_header:add("Max MCS 2: ", lbuffer(loffset, 1):bitfield(4, 4))
    loffset = loffset + 1

    local flag_soft_buffer_size2 = lbuffer(loffset, 1):bitfield(0, 4)
    nw_rd_capability_msg_header:add("Soft-buffer Size 2: ", lbuffer(loffset, 1):bitfield(0, 4))
    local flag_num_of_HARQ_proce2 = lbuffer(loffset, 1):bitfield(4, 2)
    nw_rd_capability_msg_header:add("Number of HARQ processes 2: ", lbuffer(loffset, 1):bitfield(4, 2))
    loffset = loffset + 1

    local flag_HARQ_feedback_delay2 = lbuffer(loffset, 1):bitfield(0, 4)
    nw_rd_capability_msg_header:add("HARQ Feedback Delay 2: ", lbuffer(loffset, 1):bitfield(0, 4))
    loffset = loffset + 1

    return loffset

end