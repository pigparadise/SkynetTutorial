local Skynet = require "skynet"
require "skynet.manager"

local Log = require "log"
local CMD = {}

function CMD.test_send(s)
    Log.info("test_send:<%s>", s)
end

function CMD.test_call(a, b)
    Log.info("test_call:a<%s> b<%s>", a, b)
    Skynet.retpack({code = 200, sum = a + b})
end

Skynet.dispatch(
    "lua",
    function(session, source, cmd, ...)
        local f = assert(CMD[cmd])
        f(...)
    end
)


local srv_name = ...
local function __init__()
    if srv_name ~= nil then
        Skynet.register(srv_name)
    end
    
    Log.info("boot")
end

Skynet.start(__init__)
