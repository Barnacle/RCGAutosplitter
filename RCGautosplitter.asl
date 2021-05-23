// 23 may 2021

state("RiverCityGirls", "Steam 1.1")
{
	string64 scene :			"mono.dll", 0x0501AC8, 0x20, 0x480, 0x10, 0x30, 0x14;
	int mainmenu :				"fmodstudio.dll", 0x2B4820, 0x6C8, 0x7B8, 0x420, 0x28;
	int start :					"UnityPlayer.dll", 0x1510Ca0, 0x240, 0xA98, 0x78;
	
	byte1 Boss_health_check :	"UnityPlayer.dll", 0x1542750, 0x648, 0x28, 0x88, 0x288, 0x58, 0x348;
	int Boss_health :			"UnityPlayer.dll", 0x1542750, 0x648, 0x28, 0x88, 0x288, 0x58, 0x348;
	
	float p1_vel_x :			"mono.dll",  0x0265A28, 0x170, 0xC20, 0x18, 0x20, 0x50, 0x10, 0x50, 0x18;
	float p1_vel_y :			"mono.dll",  0x0265A28, 0x170, 0xC20, 0x18, 0x20, 0x50, 0x10, 0x50, 0x20;
	float p2_vel_x :			"mono.dll",  0x0265A28, 0x170, 0xC20, 0x18, 0x28, 0x50, 0x10, 0x50, 0x18;
	float p2_vel_y :			"mono.dll",  0x0265A28, 0x170, 0xC20, 0x18, 0x28, 0x50, 0x10, 0x50, 0x20;
	
	float p1_coord_x : 			"mono.dll",  0x0265A28, 0x170, 0xC20, 0x18, 0x20, 0x50, 0x10, 0x350;
	float p1_coord_y : 			"mono.dll",  0x0265A28, 0x170, 0xC20, 0x18, 0x20, 0x50, 0x10, 0x358;
	bool p1_coord_grounded :	"mono.dll",  0x0265A28, 0x170, 0xC20, 0x18, 0x20, 0x50, 0x10, 0x35C;
	float p2_coord_x : 			"mono.dll",  0x0265A28, 0x170, 0xC20, 0x18, 0x28, 0x50, 0x10, 0x350;
	float p2_coord_y : 			"mono.dll",  0x0265A28, 0x170, 0xC20, 0x18, 0x28, 0x50, 0x10, 0x358;
	bool p2_coord_grounded :	"mono.dll",  0x0265A28, 0x170, 0xC20, 0x18, 0x28, 0x50, 0x10, 0x35C;
}

state("RiverCityGirls", "Not supported")
{
}

startup
{
	vars.canSplit = false;
	vars.Player1_Speed = 0;
	vars.Player1_X = "";
	vars.Player1_Y = "";
	vars.Player2_Speed = 0;
	vars.Player2_X = "";
	vars.Player2_Y = "";
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
	}
	else
	{
		version = "Not supported";
	}
}

update
{	
	current.speed_xpow = (float)Math.Pow(current.p1_vel_x, 2);
	current.speed_ypow = (float)Math.Pow(current.p1_vel_y, 2);
	current.speed = Math.Round((Decimal)(float)Math.Sqrt(current.speed_xpow + current.speed_ypow), 2, MidpointRounding.AwayFromZero);
	vars.Player1_Speed = vars.clamp((float)current.speed, 0, 100);
	vars.Player1_X = String.Format("{0:0.00}", vars.clamp(current.p1_coord_x, -1000, 1000));
	vars.Player1_Y = String.Format("{0:0.00}", vars.clamp(current.p1_coord_y, -1000, 1000));
	
	current.speed2_xpow = (float)Math.Pow(current.p2_vel_x, 2);
	current.speed2_ypow = (float)Math.Pow(current.p2_vel_y, 2);
	current.speed2 = Math.Round((Decimal)(float)Math.Sqrt(current.speed2_xpow + current.speed2_ypow), 2, MidpointRounding.AwayFromZero);
	vars.Player2_Speed = vars.clamp((float)current.speed2, 0, 100);
	vars.Player2_X = String.Format("{0:0.00}", vars.clamp(current.p2_coord_x, -1000, 1000));
	vars.Player2_Y = String.Format("{0:0.00}", vars.clamp(current.p2_coord_y, -1000, 1000));
}

start
{
	if (current.mainmenu == 1 && current.start == 1 && old.start == 0)
	{
		vars.canSplit = false;
		return true;
	}
}

split
{
	if (current.scene == "World_1_Lobby" ||
		current.scene == "World_2_ConstructionSite" ||
		current.scene == "World_3_FashionFactory" ||
		current.scene == "World_4_UndergroundTemple" ||
		current.scene == "World_5_YachtConcert" ||
		current.scene == "World_6_Penthouse" )
	{
		try {
			var try_str = current.Boss_health_check[0].ToString();
			vars.Boss_exits = true;
		}
		catch {
			vars.Boss_exits = false;
		}
		
		if (vars.Boss_exits == true &&
			current.Boss_health > 0)
		{
			vars.canSplit = true;
		}
	}
	else
	{
		vars.canSplit = false;
	}
	
	if (vars.canSplit && current.Boss_health == 0)
	{
		vars.canSplit = false;
		return true;
	}
}

reset
{

}
