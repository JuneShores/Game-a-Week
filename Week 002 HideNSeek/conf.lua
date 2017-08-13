-- configuration for Hide & Seek
local conf = {}
conf.arg = args

function love.conf(t)
  t.title = "Hide & Seek"
  t.version = "0.10.0"
  t.window.width = 800
  t.window.height = 400

  conf.t = t
end

return conf
