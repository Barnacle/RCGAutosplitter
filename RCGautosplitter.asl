state("RiverCityGirls", "Steam 1.1")
{
	// int mainmenu: "UnityPlayer.dll", 0x14CBF08, 0x8F8, 0x40, 0xFE0, 0x34;
	
	int mainmenu: "fmodstudio.dll", 0x2B4820, 0x6C8, 0x7B8, 0x420, 0x28;
	
	//int start: "UnityPlayer.dll", 0x014D0618, 0xD8, 0x78;
	int start: "UnityPlayer.dll", 0x014D0618, 0xE8, 0x418, 0x0, 0x18;
	int lvl: "UnityPlayer.dll", 0x1560760;
	
	byte1 Boss_health_check : "UnityPlayer.dll", 0x014D0618, 0xC10, 0x78, 0x980, 0x230, 0x348;
	int Boss_health : "UnityPlayer.dll", 0x014D0618, 0xC10, 0x78, 0x980, 0x230, 0x348;
}

state("RiverCityGirls", "Not supported")
{
}

startup {
	settings.Add("NoSplits", false, "No Splits");
	
	vars.currentSplit = 0; // add. split checker, will not split if game crashed
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
	if (current.lvl != old.lvl)
	{
		vars.splitInfo = "split" + vars.currentSplit + " " + current.lvl + " " + old.lvl;
		print(vars.splitInfo);
	}
	
	// split additional checks
	try {
		var str = current.Boss_health_check[0].ToString();
		vars.Boss_health_exits = true;
	}
	catch {
		vars.Boss_health_exits = false;
		vars.canSplit = false;
	}
	
	if (vars.Boss_health_exits == true && current.Boss_health > 0)
	{
		if (vars.splitInfo.StartsWith("split0 3")) // 400 hp - normal, old = 5
			vars.canSplit = true;
		else if (vars.splitInfo.StartsWith("split1 7")) // 700 hp - normal, old = 3
			vars.canSplit = true;
		else if (vars.splitInfo.StartsWith("split2 5")) // 950 hp - normal, old = 37
			vars.canSplit = true;
		else if (vars.splitInfo.StartsWith("split3 7")) // 850 hp - normal, old = 5
			vars.canSplit = true;
		else if (vars.splitInfo.StartsWith("split4 3")) // 850 hp - normal, old = 75
			vars.canSplit = true;
		else if (vars.splitInfo.StartsWith("split5 9")) // 1000 hp - normal, old = 5 29?
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
