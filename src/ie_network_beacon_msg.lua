function ie_handler_network_beacon_message(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Inside beacon message")
    local nw_beacon_msg_hdr = lmac_mux_header:add("Network Beacon Message Header")
    local tx_power = lbuffer(loffset, 1):bitfield(3, 1)
    nw_beacon_msg_hdr:add("TX Power: ", lbuffer(loffset, 1):bitfield(3, 1))
    local power_const = lbuffer(loffset, 1):bitfield(4, 1)
    nw_beacon_msg_hdr:add("Power Const: ", lbuffer(loffset, 1):bitfield(4, 1))
    local current = lbuffer(loffset, 1):bitfield(5, 1)
    nw_beacon_msg_hdr:add("Current: ", lbuffer(loffset, 1):bitfield(5, 1))
    local nw_beacon_channel = lbuffer(loffset, 1):bitfield(6,2)
    nw_beacon_msg_hdr:add("Network Beacon channels: ", lbuffer(loffset, 1):bitfield(6,2))
    loffset = loffset + 1
    nw_beacon_msg_hdr:add("Network Beacon period: ", lbuffer(loffset, 1):bitfield(0, 4))
    nw_beacon_msg_hdr:add("Cluster Beacon period: ", lbuffer(loffset, 1):bitfield(4, 4))
    loffset = loffset + 1
    local nxt_cluster_channel = lbuffer(loffset, 2):bitfield(3, 13)
    nw_beacon_msg_hdr:add("Next Cluster Channel: ", nxt_cluster_channel)
    loffset = loffset + 2
    nw_beacon_msg_hdr:add("Time to next: ", lbuffer(loffset, 4):bitfield(0, 32))
    loffset = loffset + 4
    if (tx_power == 1) then
        nw_beacon_msg_hdr:add("Clusters Max Tx Power: ", lbuffer(loffset, 1):bitfield(3, 5))
        loffset = loffset + 1
    end

    if (current == 1) then
        nw_beacon_msg_hdr:add("Current Cluster Channel: ", lbuffer(loffset, 2):bitfield(3, 13))
        loffset = loffset + 2
    else
        nw_beacon_msg_hdr:add("Current Cluster Channel: ", nxt_cluster_channel)
        loffset = loffset + 2
    end

    if (nw_beacon_channel == 1) then
        for i = nw_beacon_channel, 1, -1
        do 
            nw_beacon_msg_hdr:add("Additional Network Beacon Channles: ", lbuffer(loffset, 2):bitfield(3, 13))
            loffset = loffset + 2
        end
    end

    return loffset

end