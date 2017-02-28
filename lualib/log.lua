local Skynet = require "skynet"
local M = {}

M.CRITICAL = 1
M.ERROR    = 2
M.INFO     = 3
M.WARNING  = 4
M.DEBUG    = 5

M.log_map = {
    [M.CRITICAL] = "CRITICAL",
    [M.ERROR]    = "ERROR",
    [M.INFO]     = "INFO",
    [M.WARNING]  = "WARNING",
    [M.DEBUG]    = "DEBUG",
}

function M._log(log_lv, fmt, ...)
    local t = Skynet.now() + Skynet.starttime() * 100
    local t_str = string.format("%s.%02d", os.date("%Y-%m-%d %H:%M:%S", math.floor(t/100)), t%100)
    
    local lv_str = assert(M.log_map[log_lv], log_lv)
    local addr = Skynet.self()
    
    local msg = string.format(fmt, ...)

    local info = debug.getinfo(3, "Sl")
    local src = info.source .. ":" .. info.currentline .. ":"
    local log_str = string.format(
        "[%08x] [%s %s] %s: %s", addr, t_str, lv_str, src, msg
    )
    print(log_str)
end

function M.debug(fmt, ...)
    M._log(M.DEBUG, fmt, ...)
end

function M.warning(fmt, ...)
    M._log(M.WARNING, fmt, ...)
end

function M.info(fmt, ...)
    M._log(M.INFO, fmt, ...)
end

function M.error(fmt, ...)
    M._log(M.ERROR, fmt, ...)
end

function M.critical(fmt, ...)
    M._log(M.CIRTICAL, fmt, ...)
end

return M
