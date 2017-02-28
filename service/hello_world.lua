local Skynet    = require "skynet"
local Log = require "log"

local function __init__()
    Log.info("hello world")
end

Skynet.start(__init__)

