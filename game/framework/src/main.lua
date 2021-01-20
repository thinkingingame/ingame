cc.FileUtils:getInstance():setPopupNotify(false)

require "init"
LOGI("main=================")
local function main()
    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    LOGE(msg)
end
