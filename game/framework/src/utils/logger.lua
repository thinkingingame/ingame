--[[
    @desc:日志相关操作
    author:{thinkingingame}
    time:2021-01-20 14:24:44
]]
-- 日志等级
LOG_INFO = 0
LOG_DEBUG = 1
LOG_WARNING = 2
LOG_ERROR = 3

local function log(tag, fmt, ...)
    print(tag .. string.format(tostring(fmt), ...))
end

--[[
    @desc: info日志
    author:{thinkingingame}
    time:2021-01-20 14:54:13
    --@fmt:
	--@args: 
    @return:
]]
function LOGI(fmt, ...)
    if LOG_LEVEL > LOG_INFO then
        return
    end
    log("[INFO]", fmt, ...)
end

--[[
    @desc: debug日志
    author:{thinkingingame}
    time:2021-01-20 14:31:41
    --@fmt:
	--@args: 
    @return:
]]
function LOGD(fmt, ...)
    if LOG_LEVEL > LOG_DEBUG then
        return
    end
    log("[DEBUG]", fmt, ...)
end

--[[
    @desc: warning日志
    author:{thinkingingame}
    time:2021-01-20 14:54:13
    --@fmt:
	--@args: 
    @return:
]]
function LOGW(fmt, ...)
    if LOG_LEVEL > LOG_WARNING then
        return
    end
    log("[WARNING]", fmt, ...)
end

--[[
    @desc: error日志
    author:{thinkingingame}
    time:2021-01-20 14:31:41
    --@fmt:
	--@args: 
    @return:
]]
function LOGE(fmt, ...)
    if LOG_LEVEL > LOG_ERROR then
        return
    end
    log("[ERROR]", fmt, ...)
end

local function dump_value_(v)
    if type(v) == "string" then
        v = '"' .. v .. '"'
    end
    return tostring(v)
end

--[[
    @desc: 打印table,从functions里移到这里
    author:{thinkingingame}
    time:2021-01-20 15:37:33
    --@value:
	--@description:
	--@nesting: 
    @return:
]]
local function dump(tag, value, description, nesting)
    if type(nesting) ~= "number" then
        nesting = 3
    end

    local lookupTable = {}
    local result = {}

    local traceback = string.split(debug.traceback("", 2), "\n")
    log(tag, "dump from: " .. string.trim(traceback[3]))

    local function dump_(value, description, indent, nest, keylen)
        description = description or "<var>"
        local spc = ""
        if type(keylen) == "number" then
            spc = string.rep(" ", keylen - string.len(dump_value_(description)))
        end
        if type(value) ~= "table" then
            result[#result + 1] = string.format("%s%s%s = %s", indent, dump_value_(description), spc, dump_value_(value))
        elseif lookupTable[tostring(value)] then
            result[#result + 1] = string.format("%s%s%s = *REF*", indent, dump_value_(description), spc)
        else
            lookupTable[tostring(value)] = true
            if nest > nesting then
                result[#result + 1] = string.format("%s%s = *MAX NESTING*", indent, dump_value_(description))
            else
                result[#result + 1] = string.format("%s%s = {", indent, dump_value_(description))
                local indent2 = indent .. "    "
                local keys = {}
                local keylen = 0
                local values = {}
                for k, v in pairs(value) do
                    keys[#keys + 1] = k
                    local vk = dump_value_(k)
                    local vkl = string.len(vk)
                    if vkl > keylen then
                        keylen = vkl
                    end
                    values[k] = v
                end
                table.sort(
                    keys,
                    function(a, b)
                        if type(a) == "number" and type(b) == "number" then
                            return a < b
                        else
                            return tostring(a) < tostring(b)
                        end
                    end
                )
                for i, k in ipairs(keys) do
                    dump_(values[k], k, indent2, nest + 1, keylen)
                end
                result[#result + 1] = string.format("%s}", indent)
            end
        end
    end
    dump_(value, description, "- ", 1)

    for i, line in ipairs(result) do
        log(tag, line)
    end
end

--[[
    @desc: info等级打印table
    author:{thinkingingame}
    time:2021-01-20 15:42:11
    --@args: 
    @return:
]]
function DumpI(...)
    if LOG_LEVEL < LOG_INFO then
        return
    end
    dump(...)
end

--[[
    @desc: debug等级打印table
    author:{thinkingingame}
    time:2021-01-20 15:42:11
    --@args: 
    @return:
]]
function DumpD(...)
    if LOG_LEVEL < LOG_DEBUG then
        return
    end
    dump(...)
end

--[[
    @desc: warning等级打印table
    author:{thinkingingame}
    time:2021-01-20 15:42:11
    --@args: 
    @return:
]]
function DumpW(...)
    if LOG_LEVEL < LOG_WARNING then
        return
    end
    dump(...)
end

--[[
    @desc: error等级打印table
    author:{thinkingingame}
    time:2021-01-20 15:42:11
    --@args: 
    @return:
]]
function DumpE(...)
    if LOG_LEVEL < LOG_ERROR then
        return
    end
    dump(...)
end

-- 所有的日志都要使用log方法，禁止print
print = nil
release_print = nil
