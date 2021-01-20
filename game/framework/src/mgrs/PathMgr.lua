--[[
    author:{thinkingingame}
    time:2021-01-20 17:36:02
    desc:
]]
local GameObject = require("core.GameObject")
local PathMgr = class("PathMgr", GameObject)

function PathMgr:onCreate()
    PathMgr.super.onCreate(self)
end

return PathMgr
