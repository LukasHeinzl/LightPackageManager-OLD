-- used to parse command line arguments
-- args the command line arguments
-- nonVal table of options that do not require a value
-- val table of options that do require a value
-- returns a table with key=option, value=value of option, true for no-value options and false for non-options
function doOpts(args, nonVal, val)
	local opts = {};
	local skip = false;
	
	for i = 1, #args do
		if skip then
			skip = false;
		else
			local arg = args[i];
			
			if nonVal[arg] ~= nil then
				opts[arg:gsub("-", "")] = true;
			elseif val[arg] ~= nil then
				if i + 1 > #args then
					print("Argument is missing value: " .. arg);
					return false;
				end
				
				opts[arg:gsub("-", "")] = args[i + 1];
				skip = true;
			else
				opts[arg] = false;
			end
		end
	end
	
	return opts;
end