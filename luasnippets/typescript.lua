--- stylua: ignore
---@diagnostic disable: undefined-global
local ls = require "luasnip"
for _, ft in ipairs {"typescriptreact","javascript", "javascriptreact"} do
	ls.filetype_extend(ft, {"typescript"})
end

local function first(_, x) return x.captures[1] end

return {
	s({ trig = "([^%s]+)%;l", snippetType = "autosnippet", regTrig = true },
		fmta([[console.log({ <> });]], { f(first) })
	),
	s({ trig = "([^%s]+)%;g", snippetType = "autosnippet", regTrig = true },
		fmta([[console.log("<>: ", <>);]], { f(first), f(first) })
	),
	s({ trig = "([^%s]+)%;d", snippetType = "autosnippet", regTrig = true },
		fmta([[console.debug("<>: ", <>);]], { f(first), f(first) })
	),
	s({ trig = ";l", snippetType = "autosnippet"}, fmta([[console.log(<>);<>]], {
		i(1), i(2)
	})),
	s({ trig = ";i", snippetType = "autosnippet"}, fmta([[import {<>} from "<>";<>]], {
		i(2), i(1), i(3)
	})),
	s({ trig = ";x", snippetType = "autosnippet"}, fmta([[const {<>} = <>;<>]], {
		i(2), i(1), i(3)
	}))
}
