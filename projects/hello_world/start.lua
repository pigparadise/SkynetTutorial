local Skynet    = require "skynet"
local Log = require "log"

local function __init__()
    Skynet.newservice('debug_console', Skynet.getenv("CONSOLE_PORT"))
    Skynet.newservice('hello_world')
    Skynet.exit()
end

Skynet.start(__init__)

