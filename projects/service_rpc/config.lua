root = "./"
config_dir = root .. "projects/service_rpc/"

thread = 8
harbor = 0
start = "start" -- 启动服务
CONSOLE_PORT = 8421 -- 控制台服务监控端口
    
luaservice = root.."service/?.lua;"..root.."service/?/main.lua;"..root.."skynet/service/?.lua;"..root.."skynet/service/?/main.lua;" .. config_dir .. "?.lua"
lua_path = root .. "build/lualib/?.lua;" .. root .. "lualib/?.lua;"..root.."skynet/lualib/?.lua"
lua_cpath = root .. "build/clualib/?.so"
cpath = root .. "build/cservice/?.so"
lualoader = root.."skynet/lualib/loader.lua"
