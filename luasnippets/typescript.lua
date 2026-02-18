--- stylua: ignore
---@diagnostic disable: undefined-global
local ls = require "luasnip"
for _, ft in ipairs {"typescriptreact","javascript", "javascriptreact"} do
	ls.filetype_extend(ft, {"typescript"})
end

local function first(_, x) return x.captures[1] end

return {
	s({ trig = "([^%s]+)%.L", snippetType = "autosnippet", regTrig = true },
		fmta([[console.log({ <> });]], { f(first) })
	),
	s({ trig = "([^%s]+)%.lg", snippetType = "autosnippet", regTrig = true },
		fmta([[console.log("<>: ", <>);]], { f(first), f(first) })
	),
	s({ trig = "([^%s]+)%.db", snippetType = "autosnippet", regTrig = true },
		fmta([[console.debug("<>: ", <>);]], { f(first), f(first) })
	),
	s({ trig = ";l", snippetType = "autosnippet" }, t "console.log();"),
	s({ trig = ";i", snippetType = "autosnippet"}, fmta([[import {<>} from "<>";<>]], {
		i(2), i(1), i(3)
	})),
	s({ trig = ";x", snippetType = "autosnippet"}, fmta([[const {<>} = <>;<>]], {
		i(2), i(1), i(3)
	}))
}
