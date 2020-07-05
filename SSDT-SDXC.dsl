//DefinitionBlock ("", "SSDT", 2, "hack", "_XDCI", 0)
//{
    // No XDCI, yet it returns "present" for _STA
    // XDCI also has a _PRW. This can cause "instant wake"
    // Returning not-present for _STA is the fix
    // The original implementation of _STA is renamed to XSTA via config.plist
    //Name(_SB.PCI0.XDCI._STA, 0)
    External(_SB.PCI0.XDCI.DVID, FieldUnitObj)
    Method(_SB.PCI0.XDCI._STA) { If (DVID != 0xFFFF) { Return (0xf) } Else { Return (0) } }
//}
//EOF

#Patch for O2Micro SD Card Reader
into device label PXSX parent_label RP05 insert
begin
Method (_DSM, 4, NotSerialized)
{
    If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
    Return (Package()
    {
        "AAPL,slot-name",
        "Built-in",
        "device-type", Buffer() { "Media Controller" },
        "model", Buffer() { "O2 Micro SD Card Reader" },
        "compatible", Buffer() { "pci14e4,16bc" },
    })
}
end;?