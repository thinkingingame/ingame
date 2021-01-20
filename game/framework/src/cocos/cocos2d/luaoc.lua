local luaoc = {}

local callStaticMethod = LuaObjcBridge.callStaticMethod

function luaoc.callStaticMethod(className, methodName, args)
    local ok, ret = callStaticMethod(className, methodName, args)
    if not ok then
        local msg = string.format('luaoc.callStaticMethod("%s", "%s", "%s") - error: [%s] ', className, methodName, tostring(args), tostring(ret))
        if ret == -1 then
            LOG_ERROR(msg .. "INVALID PARAMETERS")
        elseif ret == -2 then
            LOG_ERROR(msg .. "CLASS NOT FOUND")
        elseif ret == -3 then
            LOG_ERROR(msg .. "METHOD NOT FOUND")
        elseif ret == -4 then
            LOG_ERROR(msg .. "EXCEPTION OCCURRED")
        elseif ret == -5 then
            LOG_ERROR(msg .. "INVALID METHOD SIGNATURE")
        else
            LOG_ERROR(msg .. "UNKNOWN")
        end
    end
    return ok, ret
end

return luaoc
