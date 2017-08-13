local conf = {}
conf.args = args

-- Configuration
function love.conf(t)
	t.title = "Kiss The Girl" -- The title of the window the game is in (string)
	t.version = "0.10.0"         -- The LÖVE version this game was made for (string)
	t.window.width = 800        -- we want our game to be long and thin.
	t.window.height = 480

	-- For Windows debugging
	t.console = true
  conf.t = t
end

return conf
