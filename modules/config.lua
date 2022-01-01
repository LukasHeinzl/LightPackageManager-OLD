local config = {};

-- used to read the config file (./lpm.conf)
function readConfig()
	local conf = {};
	
	for line in io.lines("./lpm.conf") do
		line:gsub("(.*)=(.*)", function(k, v) conf[k] = v end);
	end
	
	for k, v in pairs(conf) do
		config[trim(k)] = trim(v);
	end
end

-- used to get a value from the config
-- k the name of the value
-- returns the value
function getConfig(k)
	return config[k];
end