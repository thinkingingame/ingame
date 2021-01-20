cc.FileUtils:getInstance():setPopupNotify(false)

require "init"

local function main()
    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    LOG_ERROR(msg)
end
