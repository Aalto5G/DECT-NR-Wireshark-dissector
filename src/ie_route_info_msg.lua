function ie_handler_route_info(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Route Info")
    local nw_route_info_msg_hdr = lmac_mux_header:add("Route Into IE Message Header")

    local sinkAdd = lbuffer(loffset, 4)
    local sinkAddHex = string.format( "%08X", sinkAdd:uint())
    local formattedSinkAdd = sinkAddHex:sub(1,2) .. ":" ..
                            sinkAddHex:sub(3,4) .. ":" ..
                            sinkAddHex:sub(5,6) .. ":" ..
                            sinkAddHex:sub(7,8)
    nw_route_info_msg_hdr:add("Sink Address: ", formattedSinkAdd)
    loffset = loffset + 4
    nw_route_info_msg_hdr:add("Route Cost: ", lbuffer(loffset, 1):bitfield(0, 8))
    loffset = loffset + 1
    nw_route_info_msg_hdr:add("Application Sequence Number: ", lbuffer(loffset, 1):bitfield(0, 8))
    loffset = loffset + 1

    return loffset

end