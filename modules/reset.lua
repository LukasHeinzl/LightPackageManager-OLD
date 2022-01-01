function resetSystem()
	printFormated("%{bright}%{red}WARNING%{white}-  This will %{cyan}delete%{white} the repository file and all build-scripts!");
	printFormated("%{bright}%{yellow}* %{white}After running this command you will no longer be able to");
	printFormated("%{bright}%{yellow}* %{white}install, update or sync packages! You will still be able");
	printFormated("%{bright}%{yellow}* %{white}to delete installed packages as this command will not");
	printFormated("%{bright}%{yellow}* %{white}remove them.");
	printFormated("%{bright}%{yellow}*");
	printFormated("%{bright}%{yellow}* %{white}After running this command you should run the following:");
	printFormated("%{bright}%{yellow}* %{cyan}\tlmerge sync\n");
	
	if ask("Would you reset", "n") then
		os.remove("./lpm.repo");
		os.remove("./old.repo");
		
		local bf = getConfig("buildTreeLocation");
		
		if bf ~= nil then
			os.execute("rmdir /q /s " .. bf:gsub("/", "\\"));
		end
		
		printFormated("\n%{bright}%{white}Reset complete! Please run: %{cyan}lmerge sync");
		return true;
	end
	
	printFormated("\n%{bright}%{cyan}No%{white} changes were made!");
	return false;
end