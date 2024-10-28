function ie_handler_cluster_beacon_message(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Inside ie_handler_cluster_beacon_message")
    local cluster_beacon_msg = lmac_mux_header:add("Cluster Beacon Message")
    local sfn = lbuffer(loffset, 1):bitfield(0, 8)
    cluster_beacon_msg:add("SFN: ", sfn)
    loffset = loffset + 1
    local tx_power = lbuffer(loffset, 1):bitfield(3, 1)
    cluster_beacon_msg:add("TX Power: ", tx_power)
    cluster_beacon_msg:add("Power Const: ", lbuffer(loffset, 1):bitfield(4, 1))
    local fo = lbuffer(loffset, 1):bitfield(5, 1)
    cluster_beacon_msg:add("FO: ", fo)
    local next_channel = lbuffer(loffset, 1):bitfield(6, 1)
    cluster_beacon_msg:add("Next Channel: ", next_channel)
    local time_to_next = lbuffer(loffset, 1):bitfield(7, 1)
    cluster_beacon_msg:add("TimeToNext: ", time_to_next)
    loffset = loffset + 1
    cluster_beacon_msg:add("Network Beacon period: ", lbuffer(loffset, 1):bitfield(0, 4))
    cluster_beacon_msg:add("Cluster Beacon period: ", lbuffer(loffset, 1):bitfield(4, 4))
    loffset = loffset + 1
    cluster_beacon_msg:add("CountToTrigger: ", lbuffer(loffset, 1):bitfield(0,4))
    local rel_quality = lbuffer(loffset, 1):bitfield(4, 2)
    cluster_beacon_msg:add("RelQuality: ", tostring(rel_quality) .. " dB")
    local min_quality = lbuffer(loffset, 1):bitfield(6, 2)
    cluster_beacon_msg:add("MinQuality: ", tostring(min_quality) .. " dB")
    loffset = loffset + 1

    if (tx_power == 1) then
        cluster_beacon_msg:add("Cluster Max Tx Power: ", lbuffer(loffset, 1):bitfield(4, 4))
        loffset = loffset + 1
    end

    if (fo == 1) then
        cluster_beacon_msg:add("Frame Offset: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    if (next_channel == 1) then
        cluster_beacon_msg:add("Next Cluster Channel: ", lbuffer(loffset, 2):bitfield(3, 13))
        loffset = loffset + 2
    end

    if (time_to_next == 1) then
        cluster_beacon_msg:add("Time to next: ", lbuffer(loffset, 4):bitfield(0, 32))
        loffset = loffset + 4
    end

    return loffset
end