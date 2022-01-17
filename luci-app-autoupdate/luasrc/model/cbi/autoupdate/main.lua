m = Map("autoupdate", translate("AutoUpdate"),
translate("AutoUpdate LUCI supports scheduled upgrade & one-click firmware upgrade")
.. [[<br /><br /><a href="https://github.com/Hyy2001X/AutoBuild-Actions">]]
.. translate("Powered by AutoBuild-Actions")
.. [[</a>]]
)

s = m:section(TypedSection, "autoupdate")
s.anonymous = true

local default_url = luci.sys.exec("bash /bin/AutoUpdate.sh --var Github")
local default_flag = luci.sys.exec("bash /bin/AutoUpdate.sh --var TARGET_FLAG")

enable = s:option(Flag, "enable", translate("Enable"), translate("Automatically update firmware during the specified time when Enabled"))
enable.default = 0
enable.optional = false

proxy = s:option(Flag, "proxy", translate("Preference Mirror Speedup"), translate("Preference Mirror for speeding up downloads while upgrading (For Mainland)"))
proxy.default = 1
proxy:depends("enable", "1")
proxy.optional = false

proxy_type = s:option(ListValue, "mirror", translate("Mirror Station"))
proxy_type.default = "A"
proxy_type:value("A", translate("Automatic selection (Recommend)"))
proxy_type:value("G", translate("Ghproxy (Maybe faster)"))
proxy_type:value("F", translate("FastGit"))
proxy_type:depends("proxy", "1")
proxy_type.optional = false

forceflash = s:option(Flag, "forceflash", translate("Preference Force Flashing"), translate("Preference Force Flashing while firmware upgrading (DANGEROUS)"))
forceflash.default = 0
forceflash:depends("enable", "1")
forceflash.optional = false

week = s:option(ListValue, "week", translate("Update Day"), translate("Recommend to set AUTOUPDATE time at an idle time"))
week:value(7, translate("Everyday"))
week:value(1, translate("Monday"))
week:value(2, translate("Tuesday"))
week:value(3, translate("Wednesday"))
week:value(4, translate("Thursday"))
week:value(5, translate("Friday"))
week:value(6, translate("Saturday"))
week:value(0, translate("Sunday"))
week.default = 0
week:depends("enable", "1")

hour = s:option(Value, "hour", translate("Hour"))
hour.datatype = "range(0,23)"
hour.rmempty = true
hour.default = 0
hour:depends("enable", "1")

minute = s:option(Value, "minute", translate("Minute"))
minute.datatype = "range(0,59)"
minute.rmempty = true
minute.default = 30
minute:depends("enable", "1")

github = s:option(Value,"github", translate("Github Url"), translate("For detecting cloud version and downloading firmware"))
github.default = default_url
github.rmempty = false

flag = s:option(Value,"flag", translate("Firmware Flag"))
flag.default = default_flag
flag.rmempty = false

return m
