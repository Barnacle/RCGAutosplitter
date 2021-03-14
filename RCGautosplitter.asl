state("RiverCityGirls", "Steam 1.1")
{
	int mainmenu: "fmodstudio.dll", 0x2B4820, 0x6C8, 0x7B8, 0x420, 0x28;
	
	int start: "UnityPlayer.dll", 0x1510Ca0, 0x240, 0xA98, 0x78;
	int lvl: "UnityPlayer.dll", 0x1560760;
	
	byte1 Boss_health_check : "mono.dll", 0x0265A28, 0x170, 0xC28, 0x20, 0x58, 0x348;
	int Boss_health : "mono.dll", 0x0265A28, 0x170, 0xC28, 0x20, 0x58, 0x348;
	
	float coord_x : "UnityPlayer.dll",  0x1529980, 0x90, 0x120, 0x0;
	float coord_y : "UnityPlayer.dll",  0x1529980, 0x90, 0x120, 0x8;
	float coord_x_2 : "UnityPlayer.dll",  0x1529980, 0x90, 0x120, 0xC0;
	float coord_y_2 : "UnityPlayer.dll",  0x1529980, 0x90, 0x120, 0xC8;
	
	int slot : "UnityPlayer.dll", 0x014CCCE8, 0x440, 0x6B0, 0x17C;
	int sabu_1 : "mono.dll",  0x26B120, 0x680, 0xC30, 0x310, 0x158, 0x20;
	int sabu_2 : "mono.dll",  0x26B120, 0x680, 0xC30, 0x310, 0x278, 0x20;
	int sabu_3 : "mono.dll",  0x26B120, 0x680, 0xC30, 0x310, 0x78, 0x20;
	
	float speed_x : "UnityPlayer.dll",  0x14D6398, 0x258, 0x28, 0x78, 0x70;
	float speed_y : "UnityPlayer.dll",  0x14D6398, 0x258, 0x28, 0x78, 0x78;
}

state("RiverCityGirls", "Not supported")
{
}

startup {
	settings.Add("NoSplits", false, "No Splits");
	
	vars.currentSplit = 0; // add. split checker, will not split if game crashed
	vars.splitInfo = "";
	vars.canSplit = false;
	
	vars.coord_x_temp = 0;
	vars.coord_y_temp = 0;
	vars.Player_X = "";
	vars.Player_Y = "";
	vars.Player_Speed = 0;
	vars.Sabu_statues = 0;
	
	vars.Boss_health_exits = false;
	vars.Boss_fight_failed = 0; // Boss-Health left, Yamada Fix
	
	vars.clamp = (Func<float, float, float, float>) ((val, min, max) => {
        return Math.Max(Math.Min(val, max), min);
    });
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
	current.speed_xpow = (float)Math.Pow(current.speed_x, 2);
	current.speed_ypow = (float)Math.Pow(current.speed_y, 2);
	current.speed = Math.Round((Decimal)(float)Math.Sqrt(current.speed_xpow + current.speed_ypow), 2, MidpointRounding.AwayFromZero);
	//current.speed = (int)(current.speed * 100);
	
	vars.Player_Speed = vars.clamp((float)current.speed, 0, 100);

	if (current.coord_x != old.coord_x)
	{
		vars.coord_x_temp = current.coord_x;
		vars.coord_y_temp = current.coord_y;
	}
	else if (current.coord_x_2 != old.coord_x_2)
	{
		vars.coord_x_temp = current.coord_x_2;
		vars.coord_y_temp = current.coord_y_2;
	}

	vars.Player_X = String.Format("{0:0.00}", vars.clamp(vars.coord_x_temp, -1000, 1000));
	vars.Player_Y = String.Format("{0:0.00}", vars.clamp(vars.coord_y_temp, -1000, 1000));
	
	//
	
	if (current.slot == 0)
	{
		vars.Sabu_statues = current.sabu_1;
	}
	else if (current.slot == 1)
	{
		vars.Sabu_statues = current.sabu_2;
	}
	else if (current.slot == 2)
	{
		vars.Sabu_statues = current.sabu_3;
	}
	
	//

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
		if (vars.splitInfo == "split0 3 5") // 400 hp - normal
			vars.canSplit = true;
		else if (vars.splitInfo == "split1 7 3") // 700 hp - normal
			vars.canSplit = true;
		else if (vars.splitInfo == "split2 5 37") // 950 hp - normal
			vars.canSplit = true;
		else if (vars.splitInfo == "split3 7 5") // 850 hp - normal
			vars.canSplit = true;
		else if (vars.splitInfo == "split4 3 75") // 850 hp - normal
			vars.canSplit = true;
		else if (vars.splitInfo == "split5 9 5" || vars.splitInfo == "split5 9 29") // 1000 hp - normal
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
				print(vars.splitInfo);
				print("health " + current.Boss_health + " " + vars.Boss_fight_failed);
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
