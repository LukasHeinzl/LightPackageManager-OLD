local function run(f1, f2, diff, op)
	for line in io.lines(f1) do
		local found = false;
		
		for line2 in io.lines(f2) do
			if line == line2 then
				found = true;
				break;
			end
		end
		
		if not found then
			diff:write(op .. line .. "\n");
		end
	end
end

-- used to work out differences in files
-- f1 the path to the file to scan
-- f2 the path to the file to compare to
-- diff path to the file to write the difference to
-- op the 'diff operation' to write to the diff file (eg +/-)
-- returns nothing
function doDiff(f1, f2, diff)
	local d = io.open(diff, "w");
	
	run(f1, f2, d, "+");
	run(f2, f1, d, "-");
	
	d:close();
end