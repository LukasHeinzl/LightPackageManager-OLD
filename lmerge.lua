require("modules/vty");
require("modules/util");
require("modules/config");
readConfig();

VERSION = "1.0"

function printHelp()
	printFormated("%{bright}%{white}Usage [Version: " .. VERSION .. "]:");
	printFormated("\t%{bright}%{blue}lmerge %{magenta}[?]\t\t\t\t%{cyan}Shows this screen");
	printFormated("\t%{bright}%{blue}lmerge %{green}<package-name> %{magenta}[pkg2 ...]\t%{cyan}Installs the given package(s) and its/their dependencies");
	printFormated("\t%{bright}%{blue}lmerge %{green}info <package-name>\t\t%{cyan}Shows info about the given package");
	printFormated("\t%{bright}%{blue}lmerge %{green}delete <package-name>\t\t%{cyan}Uninstalls the given package but %{red}NOT%{cyan} its dependencies");
	printFormated("\t%{bright}%{blue}lmerge %{green}update %{magenta}[pkg1 [pkg2 ...]]\t\t%{cyan}Updates all packages or the given package(s)");
	printFormated("\t%{bright}%{blue}lmerge %{green}sync\t\t\t\t%{cyan}Synchronizes the available packages to the configured repository");
	printFormated("\t%{bright}%{blue}lmerge %{green}clean\t\t\t\t%{cyan}Cleans all installed but not used dependency-packages");
	printFormated("\t%{bright}%{blue}lmerge %{green}reset\t\t\t\t%{cyan}Deletes the repository file and all build-scripts but %{red}NOT%{cyan} installed packages");
end

if #arg < 1 or arg[1] == "?" then
	printHelp();
elseif #arg == 2 and arg[1] == "info" then
	print("TODO: info");
elseif #arg == 2 and arg[1] == "delete" then
	print("TODO: delete");
elseif #arg >= 1 and arg[1] == "update" then
	print("TODO: update");
elseif #arg == 1 and arg[1] == "sync" then
	require("modules/diff");
	require("modules/sync");
	syncRepo();
elseif #arg == 1 and arg[1] == "clean" then
	print("TODO: clean");
elseif #arg == 1 and arg[1] == "reset" then
	require("modules/reset");
	resetSystem();
else
	print("TODO: install");
end