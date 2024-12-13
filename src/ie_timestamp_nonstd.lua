f_timestamp_u64 = ProtoField.uint64(
    "dect_nr.sdu.timestamp",
    "Timestamp",
    base.DEC
)

function ie_handler_timestamp(loffset, lbuffer, lpinfo, tree)
    tree:add(f_timestamp_u64, lbuffer(loffset, 8))
end