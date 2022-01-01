local codes = {
	reset = 0,
	bright = 1,
	dim = 2,
	underline = 3,
	blink = 4,
	reverse = 7,
	hidden = 8,
	
	-- fg colors
	black = 30,
	red = 31,
	green = 32,
	yellow = 33,
	blue = 34,
	magenta = 35,
	cyan = 36,
	white = 37,
	
	-- bg colors
	blackbg = 40,
	redbg = 41,
	greenbg = 42,
	yellowbg = 43,
	bluebg = 44,
	magentabg = 45,
	cyanbg = 46,
	whitebg = 47
};

local escape = string.char(27) .. "[%dm";

local function escapeNumber(nr)
	return escape:format(nr);
end

-- used to print formated text to the console
-- str the string to print, should contain %{FMT} for formatting
-- returns nothing
function printFormated(str)
	str = string.gsub(str, "(%%{)(%a*)(})", function(g1, g2, g3) return escapeNumber(codes[g2]) end);
	print(str .. escapeNumber(codes["reset"]));
end