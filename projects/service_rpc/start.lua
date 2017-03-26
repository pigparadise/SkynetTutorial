local Skynet    = require "skynet"
local Log = require "log"

local function __init__()
    Skynet.newservice('debug_console', Skynet.getenv("CONSOLE_PORT"))
    Skynet.newservice('test_rpc', 'srv_a')
    local srv_b = Skynet.newservice('test_rpc')
    
    local ret = Skynet.call("srv_a", "lua", "test_call", 1, 2)
    Log.info('call_srv_a, code<%s> sum<%s>', ret.code, ret.sum)
    
    local ret = Skynet.call(srv_b, "lua", "test_call", 1, 2)
    Log.info('call_srv_b, code<%s> sum<%s>', ret.code, ret.sum)

    Log.info('send_srv_a')
    Skynet.send("srv_a", "lua", "test_send", "aaaaa")

    Log.info('send_srv_b')
    Skynet.send(srv_b, "lua", "test_send", "bbbbb")    

    Skynet.exit()
end

Skynet.start(__init__)

