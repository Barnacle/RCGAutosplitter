state("RiverCityGirls", "Steam 1.1")
{
	// int unkn: "UnityPlayer.dll", 0x148066C; // old.unkn == 210 && current.unkn == 190
	
	int mainmenu: "UnityPlayer.dll", 0x14CBF08, 0x8F8, 0x40, 0xFE0, 0x34;
	
	int start: "UnityPlayer.dll", 0x014D0618, 0xD8, 0x78;
	// start button
	// "UnityPlayer.dll"+014D91D0 808 118 78
	// "UnityPlayer.dll"+01510CA0 240 A98 78
	// "UnityPlayer.dll"+01510CA0 100 A18 78
	
	int lvl: "UnityPlayer.dll", 0x1560760;
	
	//byte1 Boss_health_check : "UnityPlayer.dll", 0x14D63A8, 0x120, 0x4A0, 0x20, 0x348;
	byte1 Boss_health_check : "UnityPlayer.dll", 0x014D0618, 0xC10, 0x78, 0x980, 0x230, 0x348;
	int Boss_health : "UnityPlayer.dll", 0x014D0618, 0xC10, 0x78, 0x980, 0x230, 0x348;
}

state("RiverCityGirls", "Not supported")
{
}

startup {
	settings.Add("NoSplits", false, "No Splits");
	
	vars.currentSplit = 0;
	vars.splitInfo = "";
	vars.canSplit = false;
	
	vars.Boss_health_exits = false;
	vars.Boss_fight_failed = 0; // Boss-Health left, Yamada Fix
}

init
{
	// Detects current game version.
	if (modules.First().ModuleMemorySize == 671744)
	{
		print("Steam 1.1");
		version = "Steam 1.1";
		
		if(settings["NoSplits"])
			vars.currentSplit = 5;
		else
			vars.currentSplit = 0;
	}
	else
	{
		version = "Not supported";
	}
}

update
{
	//if (current.unkn != old.unkn)
	//	print("unk " + current.unkn + " " + old.unkn + " " + current.start + " " + old.start);
		
	if (current.lvl != old.lvl)
	{
		vars.splitInfo = "split " + vars.currentSplit + " " + current.lvl + " " + old.lvl;
		print(vars.splitInfo);
	}
	
	// split additional checks
	try {
		var test = current.Boss_health_check[0].ToString();
		vars.Boss_health_exits = true;
	}
	catch {
		vars.Boss_health_exits = false;
		vars.canSplit = false;
	}
	
	if (vars.Boss_health_exits == true && current.Boss_health > 0)
	{
		if (vars.splitInfo == "split 0 3 5") // 400 hp - normal
			vars.canSplit = true;
		else if (vars.splitInfo == "split 1 7 3") // 700 hp - normal
			vars.canSplit = true;
		else if (vars.splitInfo == "split 2 5 37") // 950 hp - normal
			vars.canSplit = true;
		else if (vars.splitInfo == "split 3 7 5") // 850 hp - normal
			vars.canSplit = true;
		else if (vars.splitInfo == "split 4 3 75") // 850 hp - normal
			vars.canSplit = true;
		else if (vars.splitInfo == "split 5 9 5") // 1000 hp - normal
			vars.canSplit = true;
		else
		{
			vars.canSplit = false;
			vars.Boss_fight_failed = 390; // Doesn't really matter the real last Boss-health value, cause it will refill anyway. Should be less than full though.
		}
	}
}

start
{
	if (current.start == 1 && old.start == 0 && current.mainmenu == 1)
	{
		if(settings["NoSplits"])
			vars.currentSplit = 5;
		else
			vars.currentSplit = 0;
		
		return true;
	}
}

split
{
	if (vars.canSplit)
	{
		if (vars.Boss_fight_failed == 0)
		{
			if (current.Boss_health == 0)
			{
				vars.currentSplit++;
				vars.canSplit = false;
				return true;
			}
		}
		else
		{
			if (current.Boss_health > vars.Boss_fight_failed)
				vars.Boss_fight_failed = 0;
		}
	}
}

reset
{

}
