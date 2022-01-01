local function backupOld()
	local old = io.open("lpm.repo", "r");
	
	if old ~= nil then
		old:close();
		os.remove("old.repo");
		os.rename("lpm.repo", "old.repo");
	else
		old = io.open("old.repo", "w");
		old:close();
	end
end

local function displayChanges()
	local i = 1;
	local new = {};
	
	printFormated("%{bright}%{white}These are the changes in the repo:");
	for line in io.lines("repo.diff") do
		if line:sub(1, 1) == "+" then
			printFormated("%{bright}%{green}" .. line);
			new[i] = line:sub(2);
			i = i + 1;
		elseif line:sub(1, 1) == "-" then
			printFormated("%{bright}%{red}" .. line);
		end
	end
	
	return new;
end

local function downloadBuilds(locs)
	local downloadUtil = getConfig("downloadUtil");
	local repoFile = getConfig("repo");
	local buildTree = getConfig("buildTreeLocation");
	
	for i = 1, #locs do
		printFormated("%{bright}%{white}[%{yellow}" .. i .. "%{white}/%{yellow}" .. #locs .. "%{white}] Downloading %{cyan}" .. locs[i]);
		os.execute(downloadUtil .. " " .. repoFile .. locs[i]:gsub("%$", "/") .. ".lua");
		os.execute("mkdir " .. buildTree:sub(3) .. locs[i]:sub(1, locs[i]:find("%$") - 1):gsub("/", "\\") .. " 1> NUL 2> NUL");
		os.rename(locs[i]:sub(locs[i]:find("%$") + 1, -1) .. ".lua", buildTree .. locs[i]:gsub("%$", "/") .. ".lua");
	end
end

local function doPackages()
	local new = displayChanges();
	
	if #new == 0 then
		printFormated("%{bright}%{white}No changes found!");
		os.remove("repo.diff");
		return true;
	end
	
	if ask("Would you like to download %{yellow}" .. #new .. "%{white} new packages", "y") then
		downloadBuilds(new);
		os.remove("repo.diff");
		return true;
	end
	
	return false, "abort";
end

function syncRepo()
	local downloadUtil = getConfig("downloadUtil");
	
	if errorIf(downloadUtil, nil, "No download-utility specified! Add %{cyan}downloadUtil= %{white}in config! Aborting...") then
		return false, "du";
	end
	
	local repoFile = getConfig("repo");
	
	if errorIf(repoFile, nil, "No repository specified! Add %{cyan}repo= %{white}in config! Aborting...") then
		return false, "repo";
	end
	
	local buildTree = getConfig("buildTreeLocation");
	
	if errorIf(buildTree, nil, "No build-tree location specified! Add %{cyan}buildTreeLocation= %{white}in config! Aborting...") then
		return false, "bt";
	end
	
	local d = io.open("repo.diff");
	
	if d ~= nil then
		d:close();
		
		if ask("You have pending packages to download! Would you like to sync them", "y") then
			return doPackages();
		end
		
		return false, "old-diff";
	end
	
	if ask("Would you like to sync to %{cyan}" .. repoFile, "y") then
		backupOld();
		
		os.execute(downloadUtil .. " " .. repoFile .. "/lpm.repo");
		
		doDiff("lpm.repo", "old.repo", "repo.diff");
		return doPackages();
	end

	return false, "abort";
end