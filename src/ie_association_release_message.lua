function ie_handler_association_release_message(loffset, lbuffer, lpinfo, lmac_mux_header)
    print("Inside association release message")
    local association_release_msg = lmac_mux_header:add("Association Release Message")
    association_release_msg:add("Release Cause", lbuffer(loffset, 1):bitfield(0, 4))
    loffset = loffset + 1

    return loffset
end