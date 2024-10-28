function ie_handler_measurement_report(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Measurement Report IE")
    local nw_measurement_report_msg_hdr = lmac_mux_header:add("Measurement Report Message Header")

    local SNR = lbuffer(loffset, 1):bitfield(3, 1)
    nw_measurement_report_msg_hdr:add("SNR: ", lbuffer(loffset, 1):bitfield(3, 1))
    local RSSI_2 = lbuffer(loffset, 1):bitfield(4, 1)
    nw_measurement_report_msg_hdr:add("RSSI-2: ", lbuffer(loffset, 1):bitfield(4, 1))
    local RSSI_1 = lbuffer(loffset, 1):bitfield(5, 1)
    nw_measurement_report_msg_hdr:add("RSSI-1: ", lbuffer(loffset, 1):bitfield(5, 1))
    local tx_count = lbuffer(loffset, 1):bitfield(6, 1)
    nw_measurement_report_msg_hdr:add("Tx count: ", lbuffer(loffset, 1):bitfield(6, 1))
    nw_measurement_report_msg_hdr:add("RACH: ", lbuffer(loffset, 1):bitfield(7, 1))
    loffset = loffset + 1

    if (SNR == 1) then
        nw_measurement_report_msg_hdr:add("SNR result: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    if (RSSI_2 == 1) then
        nw_measurement_report_msg_hdr:add("RSSI-2 result: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    if (RSSI_1 == 1) then
        nw_measurement_report_msg_hdr:add("RSSI-1 result: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    if (tx_count == 1) then
        nw_measurement_report_msg_hdr:add("TX count result: ", lbuffer(loffset, 1):bitfield(0, 8))
        loffset = loffset + 1
    end

    return loffset

end