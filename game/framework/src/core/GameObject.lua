local GameObject = class("GameObject")

function GameObject:onCreate(...)
    LOGI("GameObject onCreate")
end

function GameObject:onDestory()
    LOGI("GameObject onDestory")
end

return GameObject
