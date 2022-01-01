function ask(msg, default)
	if default == "y" then
		printFormated("%{bright}%{white}" .. msg .. "%{bright}%{white}? [%{green}Yes%{white}/%{red}No%{white}]");
	else
		printFormated("%{bright}%{white}" .. msg .. "%{bright}%{white}? [%{red}Yes%{white}/%{green}No%{white}]");
	end
	
	local yn = io.stdin:read("*line");
	
	if yn == "yes" or yn == "y" or (default == "y" and yn == "") then
		return true;
	end
	
	return false;
end

function trim(str)
	return str:gsub("^%s*(.-)%s*$", "%1");
end

function errorIf(what, when, msg)
	if what == when then
		printFormated("%{bright}%{red}ERROR%{white}: " .. msg);
		return true;
	end
	
	return false;
end