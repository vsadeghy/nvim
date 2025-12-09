--- stylua: ignore
---@diagnostic disable: undefined-global
local ls = require "luasnip"
for _, ft in ipairs {"typescriptreact","javascript", "javascriptreact"} do
	ls.filetype_extend(ft, {"typescript"})
end

return {
	s({ trig = "([^%s]+)%.lg", snippetType = "autosnippet", regTrig = true },
		fmta([[console.log("<>: ", <>);]], {
			f(function(_, x) return x.captures[1] end),
			f(function(_, x) return x.captures[1] end),
		})
	),
	s({ trig = ";l", snippetType = "autosnippet" }, t "console.log();"),
	s({ trig = ";i", snippetType = "autosnippet"}, fmta([[import {<>} from "<>";<>]], {
		i(2), i(1), i(3)
	})),
	s({ trig = ";x", snippetType = "autosnippet"}, fmta([[const {<>} = <>;<>]], {
		i(2), i(1), i(3)
	}))
}
