// 13 june 2021

state("RiverCityGirls", "Steam 1.1")
{
	string64 scene :				"mono.dll", 0x501AC8, 0x20, 0x480, 0x10, 0x30, 0x14; // MapDataManager
	string64  mainmenu :			"UnityPlayer.dll", 0x151E2E0, 0x8, 0x0, 0x30, 0x8, 0x158, 0x38, 0x20, 0x14;
	string64  music :				"mono.dll", 0x2685E0, 0xA0, 0x2D0, 0x0, 0x18, 0x14; // MusicManager
	int start :						"mono.dll", 0x265110, 0xCE8, 0x0, 0x18, 0x8; // unused
	
	uint PlayerGlobalInventoryPtr : "mono.dll", 0x268698, 0x70, 0x478;
	uint PersistentDataPtr :		"UnityPlayer.dll", 0x14F1F48, 0x148, 0x178, 0x60;
	uint EventManagerPtr :			"mono.dll", 0x265110, 0xDD0, 0xA0, 0x48;
	
	byte1 Boss_health_check :		"mono.dll", 0x2691D0, 0x18, 0x360, 0x10, 0x158, 0x198, 0x348; // UI_HUD_Boss
	int Boss_health :				"mono.dll", 0x2691D0, 0x18, 0x360, 0x10, 0x158, 0x198, 0x348;
	
	float p1_vel_x :				"mono.dll", 0x265A28, 0x170, 0xC20, 0x18, 0x20, 0x50, 0x10, 0x50, 0x18; // PlayerManager
	float p1_vel_y :				"mono.dll", 0x265A28, 0x170, 0xC20, 0x18, 0x20, 0x50, 0x10, 0x50, 0x20;
	float p2_vel_x :				"mono.dll", 0x265A28, 0x170, 0xC20, 0x18, 0x28, 0x50, 0x10, 0x50, 0x18;
	float p2_vel_y :				"mono.dll", 0x265A28, 0x170, 0xC20, 0x18, 0x28, 0x50, 0x10, 0x50, 0x20;
	
	float p1_coord_x : 				"mono.dll", 0x265A28, 0x170, 0xC20, 0x18, 0x20, 0x50, 0x10, 0x350;
	float p1_coord_y : 				"mono.dll", 0x265A28, 0x170, 0xC20, 0x18, 0x20, 0x50, 0x10, 0x358;
	bool p1_coord_grounded :		"mono.dll", 0x265A28, 0x170, 0xC20, 0x18, 0x20, 0x50, 0x10, 0x35C;
	float p2_coord_x : 				"mono.dll", 0x265A28, 0x170, 0xC20, 0x18, 0x28, 0x50, 0x10, 0x350;
	float p2_coord_y : 				"mono.dll", 0x265A28, 0x170, 0xC20, 0x18, 0x28, 0x50, 0x10, 0x358;
	bool p2_coord_grounded :		"mono.dll", 0x265A28, 0x170, 0xC20, 0x18, 0x28, 0x50, 0x10, 0x35C;
}

state("RiverCityGirls", "Not supported")
{
}

startup
{
	settings.Add("P100", false, "Split on 100% Completion");
	vars.AllMaps = new List<string>{
		"world_1_gympool",
		"world_1_lobby",
		"world_1_cafeteria",
		"world_1_gymbasketball",
		"world_1_sexed",
		"world_1_chemistry",
		"world_1_detention",
		"world_1_freezer",
		"world_1_1stfloora",
		"world_1_1stfloorb",
		"world_1_2ndfloora",
		"world_1_2ndfloorb",
		"world_1_3rdfloor",
		"world_1_kitchen",
		"world_1_lockerroom",
		"world_1_restroom",
		"world_1_rooftop",
		"world_2_alleyway",
		"world_2_beanballcourt",
		"world_2_constructionpit",
		"world_2_constructionsite",
		"world_2_foodcourt",
		"world_2_frontgate",
		"world_2_mallentrance",
		"world_2_malllobby",
		"world_2_mallrear",
		"world_2_mallexit",
		"world_2_northravinelane",
		"world_2_pattinsonbackyard",
		"world_2_pattinsonhouse",
		"world_2_schoolentrance",
		"world_2_storeentrances",
		"world_2_windingway",
		"world_3_arcade",
		"world_3_backalley",
		"world_3_fashionfactory",
		"world_3_floor1",
		"world_3_floor2",
		"world_3_floor3",
		"world_3_floor4",
		"world_3_floor5",
		"world_3_floor6",
		"world_3_floor7",
		"world_3_floor8",
		"world_3_pawnshop",
		"world_3_runway",
		"world_3_shoppingentrance",
		"world_3_shoppingfashion",
		"world_3_shoppingtoys",
		"world_3_shoppingvideogames",
		"world_3_sweatshop",
		"world_4_backalley",
		"world_4_barinterior",
		"world_4_basketball",
		"world_4_citystreets1",
		"world_4_citystreets2",
		"world_4_junkyard",
		"world_4_park",
		"world_4_shantytown",
		"world_4_skidrow",
		"world_4_subway",
		"world_4_transitstation",
		"world_4_tunnel",
		"world_4_undergroundtemple",
		"world_5_beach",
		"world_5_aquarium",
		"world_5_beachhomes",
		"world_5_beachstorefront",
		"world_5_fancyhotellobby",
		"world_5_fishmarket",
		"world_5_piersboats",
		"world_5_publicpark",
		"world_5_restroom",
		"world_5_themepark",
		"world_5_yachtconcert",
		"world_6_balcony",
		"world_6_casino",
		"world_6_floor8",
		"world_6_floor13",
		"world_6_floor21",
		"world_6_floor50",
		"world_6_hotelroom",
		"world_6_lobby",
		"world_6_moneylaundering",
		"world_6_penthouse",
		"world_6_restroom",
		"world_6_scienceexperiments",
		"world_6_towerentrance",
		"world_6_weaponsroom"
	};

	vars.Total = 0;
	vars.clamp = (Func<float, float, float, float>) ((val, min, max) => {
		return Math.Max(Math.Min(val, max), min);
	});
	vars.canSplit = false;
		
	vars.Player1_Speed = 0;
	vars.Player1_X = "";
	vars.Player1_Y = "";
	vars.Player2_Speed = 0;
	vars.Player2_X = "";
	vars.Player2_Y = "";
	
	vars.Quests = "0/13";
	vars.Bosses = "0/7";
	vars.Areas = "0/89";
	vars.Items = "0/58";
	vars.Moves = "0/112";
	vars.Equips = "0/34";
	vars.Statues = "0/25";
	vars.Recruits = "0/12";
	vars.Completion = "0/326 0%";
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
	
	
	// Stats
	
	var questGameEvents = 0;
	var bossGameEvents = 0;
	var seenScenes = 0;
	var seenItems = 0;
	var acquiredMoves = 0;
	var seenEquips = 0;
	var sabuStatues = 0;
	var recruitTypes = 0;
	var recruitTypesExtra = 0;
	
	// EventManager
	var BasePtr = current.EventManagerPtr + 0x240;
	var _calledEventListPtr = game.ReadValue<uint>(new IntPtr(BasePtr + 0x40));
	var _eventItems = game.ReadValue<uint>(new IntPtr(_calledEventListPtr + 0x10));
	var _eventItemsCount = game.ReadValue<uint>(new IntPtr(_eventItems + 0x18));
	
	var EventItems = new List<uint>();	
	for (var i = 1; i < _eventItemsCount + 1; i++)
	{
		EventItems.Add(game.ReadValue<uint>(new IntPtr(_eventItems + (0x18 + 0x8 * i))));
	}
	
	foreach (var item in EventItems)
	{
		var EventNamePtr = game.ReadValue<uint>(new IntPtr(item + 0x18));
		var Length = game.ReadValue<int>(new IntPtr(EventNamePtr + 0x10));
		List<byte> str = new List<byte>();
		for (var i = 0; i < Length; i++)
		{
			str.Add(game.ReadValue<byte>(new IntPtr(EventNamePtr + 0x14 + 0x2 * i)));
		}
		var EventName = System.Text.Encoding.Default.GetString(str.ToArray());
		
		var Value = game.ReadValue<int>(new IntPtr(EventNamePtr + 0x14));
		
		var TimesFiredPtr = game.ReadValue<int>(new IntPtr(item + 0x20));
		var TimesFired = new IntPtr(TimesFiredPtr);
		
		var MaxFiresPtr = game.ReadValue<int>(new IntPtr(item + 0x24));
		var MaxFires = new IntPtr(MaxFiresPtr);
		
		if ((int)TimesFired == 1 && (
			EventName == "Complete Open for Business!" || 
			EventName == "Complete Zombie Crusher!" || 
			EventName == "Complete We're on the list!" || 
			EventName == "Complete Super Fans!" || 
			EventName == "Complete Gross Appetite!" || 
			EventName == "Complete Things that Make You Go BOOM!" || 
			EventName == "Complete Fashion Gold!" || 
			EventName == "Complete A Burger to Godai For!" || 
			EventName == "Complete A Ride Too Nice!" || 
			EventName == "Complete One-Hit Tommy in the Bathroom!" || 
			EventName == "Complete Lets Beat It!" || 
			EventName == "Complete Who is the Snitch" || 
			EventName == "Complete Mayor Statues be Golden!"
			))
		{
			questGameEvents++;
		}
		
		if ((int)TimesFired == 1 && (
			EventName == "Kill Misuzu" || 
			EventName == "Kill Yamada" || 
			EventName == "Kill Seamstress" || 
			EventName == "Kill Abobo" || 
			EventName == "Kill NOIZE" || 
			EventName == "Kill Sabuko" || 
			EventName == "Kill Hasebe&Mami"
			))
		{
			bossGameEvents++;
		}
		
		if (EventName == "RCG_Event_Sabu_Bust")
		{
			sabuStatues = (int)TimesFired;
		}	
	}
	
	// PlayerGlobalInventory
	var PlayerGlobalInventory = current.PlayerGlobalInventoryPtr + 0x120;
	var SeenItemsPtr = game.ReadValue<uint>(new IntPtr(PlayerGlobalInventory + 0x20));
	var _seenItems = game.ReadValue<uint>(new IntPtr(SeenItemsPtr + 0x10));
	var _seenItemsCount = game.ReadValue<uint>(new IntPtr(_seenItems + 0x18));
	
	var SeenItems = new List<uint>();	
	for (var i = 1; i < _seenItemsCount + 1; i++)
	{
		SeenItems.Add(game.ReadValue<uint>(new IntPtr(_seenItems + (0x18 + 0x8 * i))));
	}
	
	foreach (var item in SeenItems)
	{
		var cachedPtr = game.ReadValue<uint>(new IntPtr(item + 0x10));
		if (cachedPtr == 0)
			continue;
		
		var itemType = game.ReadValue<uint>(new IntPtr(item + 0x38));
		
		if (itemType == 0) // Useable
			seenItems++;
		
		if (itemType == 1) // Equips
			seenEquips++;
	}
	
	var SeenScenesPtr = game.ReadValue<uint>(new IntPtr(PlayerGlobalInventory + 0x28));
	var _seenScenes = game.ReadValue<uint>(new IntPtr(SeenScenesPtr + 0x10));
	var _seenScenesCount = game.ReadValue<uint>(new IntPtr(_seenScenes + 0x18));
	
	var SeenScenes = new List<uint>();	
	for (var i = 1; i < _seenScenesCount + 1; i++)
	{
		var ptr = game.ReadValue<uint>(new IntPtr(_seenScenes + (0x18 + 0x8 * i)));
		if (ptr == 0)
			continue;
		
		SeenScenes.Add(ptr);
	}
	
	foreach (var item in SeenScenes)
	{
		var Length = game.ReadValue<uint>(new IntPtr(item + 0x10));
		var str = new List<byte>();
		for (var i = 0; i < Length; i++)
		{
			str.Add(game.ReadValue<byte>(new IntPtr(item + 0x14 + 0x2 * i)));
		}
		var SceneName = System.Text.Encoding.Default.GetString(str.ToArray());
		
		if (SceneName == "")
			continue;
		
		if (vars.AllMaps.Contains(SceneName))
			seenScenes++;
	}
	
	var PlayerInventoriesPtr = game.ReadValue<uint>(new IntPtr(PlayerGlobalInventory + 0x18));
	for (var i = 0; i < 4; i++)
	{
		var _playerInventory = game.ReadValue<uint>(new IntPtr(PlayerInventoriesPtr + 0x20 + 0x8 * i));
		var MoveInventory = game.ReadValue<uint>(new IntPtr(_playerInventory + 0x20));
		
		var _items1 = game.ReadValue<uint>(new IntPtr(MoveInventory + 0x18));
		var _items2 = game.ReadValue<uint>(new IntPtr(_items1 + 0x10));
		var _MoveArrayCount = game.ReadValue<uint>(new IntPtr(_items2 + 0x18));
		
		for (var a = 1; a < _MoveArrayCount + 1; a++)
		{
			var _MoveItem = game.ReadValue<uint>(new IntPtr(_items2 + (0x18 + 0x8 * a)));
			var acquired = game.ReadValue<uint>(new IntPtr(_MoveItem + 0x82));
			
			if (acquired == 1)
				acquiredMoves++;
		}
	}
	
	// PersistentData
	var _recruitsListPtr = game.ReadValue<uint>(new IntPtr(current.PersistentDataPtr + 0x18));
	var _recruitsItems = game.ReadValue<uint>(new IntPtr(_recruitsListPtr + 0x10));
	var _recruitsItemsCount = game.ReadValue<uint>(new IntPtr(_recruitsItems + 0x18));
	
	var allRecruitsList = new List<string>();
	for (var i = 1; i < _recruitsItemsCount + 1; i++)
	{
		var EnemyType = game.ReadValue<uint>(new IntPtr(_recruitsItems + 0x18 + 0x8 * i));
		var VariantType = game.ReadValue<uint>(new IntPtr(_recruitsItems + 0x18 + (0x8 * i) + 0x4));
		
		if (EnemyType == 0)
			continue;
		
		switch(EnemyType)
		{
			case 1:
				allRecruitsList.Add("Georgios");
				break;
			case 5:
				allRecruitsList.Add("Reina");
				break;
			case 4:
				allRecruitsList.Add("Seirai");
				break;
			case 2:
				allRecruitsList.Add("Linnea");
				break;
			case 0xC:
				allRecruitsList.Add("Waver");
				break;
			case 0xD:
				allRecruitsList.Add("Linda");
				break;
			case 8:
				allRecruitsList.Add("Saito");
				break;
			case 3:
				allRecruitsList.Add("Dwayne");
				break;
			case 0xB:
				allRecruitsList.Add("Trash");
				break;
			case 6:
				allRecruitsList.Add("D4-V1D");
				break;
			case 7:
				allRecruitsList.Add("Fudo");
				break;
			case 9:
				allRecruitsList.Add("Akari");
				break;
		}
	}
	
	if (acquiredMoves == 0)
	{
		var PlayerInventoriesPtr2 = game.ReadValue<uint>(new IntPtr(current.PersistentDataPtr + 0x98));
		var _m_PropertyArray = game.ReadValue<uint>(new IntPtr(PlayerInventoriesPtr2 + 0x10));
		for (var i = 1; i < 4 + 1; i++)
		{
			var _playerInventory = game.ReadValue<uint>(new IntPtr(_m_PropertyArray + 0x18 + 0x8 * i));
			var MoveInventory = game.ReadValue<uint>(new IntPtr(_playerInventory + 0x10));
			var _MoveArrayCount = game.ReadValue<uint>(new IntPtr(MoveInventory + 0x18));
			
			for (var a = 1; a < _MoveArrayCount + 1; a++)
			{
				var _MoveItem = game.ReadValue<uint>(new IntPtr(MoveInventory + (0x18 + 0x8 * a)));
				
				if (_MoveItem != 0)
					acquiredMoves++;
			}
		}
	}
	
	recruitTypes = allRecruitsList.Distinct().Count();
	
	var duplicates = allRecruitsList.GroupBy(i => i).Where(g => g.Count() > 1).Select(g => g.Key);
	
	if (duplicates.Count() > 0)
	{
		foreach (var dup in duplicates)
		{
			recruitTypesExtra++;
			if(recruitTypesExtra == 3)
				break;
		}
	}
	
	var recruitExtra = "";
	if (recruitTypesExtra > 0)
		recruitExtra = "(+" + recruitTypesExtra.ToString() +")";
	
	vars.Quests = questGameEvents.ToString() + "/13";
	vars.Bosses = bossGameEvents.ToString() + "/7";
	vars.Areas = seenScenes.ToString() + "/89";
	vars.Items = seenItems.ToString() + "/58";
	vars.Moves = acquiredMoves.ToString() + "/112";
	vars.Equips = seenEquips.ToString() + "/34";
	vars.Statues = sabuStatues.ToString() + "/25"; 
	vars.Recruits = recruitTypes.ToString() + recruitExtra + "/12";
	
	var sabu = 0;
	if(sabuStatues == 25)
		sabu = 1;
	else
		sabu = 0;
	
	vars.Total = questGameEvents + bossGameEvents + seenScenes + seenItems + acquiredMoves + seenEquips + sabu + recruitTypes + recruitTypesExtra;
	float total = (float)(vars.Total) / (float)326;
	total = vars.clamp(total, 0f, 1f);	
	vars.Completion = vars.Total.ToString() + "/326 " + ((int)(total * 100)).ToString() + "%";
}

start
{
	if (current.mainmenu == "CharacterSelect" && current.music == "null")
	{
		vars.Quests = "0/13";
		vars.Bosses = "0/7";
		vars.Areas = "0/89";
		vars.Items = "0/58";
		vars.Moves = "0/112";
		vars.Equips = "0/34";
		vars.Statues = "0/25";
		vars.Recruits = "0/12";
		vars.Completion = "0/326 0%";
	
		vars.Total = 0;
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
			vars.canSplit = false;
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
	
	// 100%
	if (settings["P100"] && vars.Total >= 326)
		return true;
}

reset
{
}
