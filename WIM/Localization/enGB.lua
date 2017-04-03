-- enUS and enGB use the same global strings, however
-- this is needed in order to format dates correctly.

WIM.AddLocale("enGB", {
    ["_DateFormat"] = "%d/%m/%Y"
});