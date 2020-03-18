library HeroStateFunc uses DamageCode


    function InitPlayerDzShopState(int pid)
        int lv = DzPlayerLv(Player(pid))
        /////////////////////额外给予////////////////////////
        if  DzAPI_Map_IsBlueVIP(Player(pid)) == true
            BJDebugMsg("DzAPI_Map_IsBlueVIP")
            if  GetPlayerTechCount(Player(pid),'RK1A',true) == 0 //小狐妖
                AddPlayerTechResearched(Player(pid),'RK1A',1)
            endif
        endif
        if  DzAPI_Map_GetGuildName(Player(pid)) == "星辰俱乐部" 
            BJDebugMsg("DzAPI_Map_GetGuildName")
            if  GetPlayerTechCount(Player(pid),'RK1A',true) == 0 //小狐妖
                AddPlayerTechResearched(Player(pid),'RK1A',1)
            endif
            if  GetPlayerTechCount(Player(pid),'RY2D',true) == 0 //幻莲仙翼
                AddPlayerTechResearched(Player(pid),'RY2D',1)
            endif 
        endif
        if  IsPlayerIn_MZRPG_Admin(pid) == true
            BJDebugMsg("IsPlayerIn_MZRPG_Admin")
            if  GetPlayerTechCount(Player(pid),'RY1D',true) == 0 //星月光环
                AddPlayerTechResearched(Player(pid),'RY1D',1)
            endif
            if  GetPlayerTechCount(Player(pid),'RY2D',true) == 0 //幻莲仙翼
                AddPlayerTechResearched(Player(pid),'RY2D',1)
            endif 
            if  GetPlayerTechCount(Player(pid),'RY3D',true) == 0 //戮仙剑
                AddPlayerTechResearched(Player(pid),'RY3D',1)
            endif
            if  GetPlayerTechCount(Player(pid),'RY4D',true) == 0 //金鼠送福
                AddPlayerTechResearched(Player(pid),'RY4D',1)
            endif 
            if  GetPlayerTechCount(Player(pid),'RK1A',true) == 0 //小狐妖
                AddPlayerTechResearched(Player(pid),'RK1A',1)
            endif
            if  GetPlayerTechCount(Player(pid),'RJ1U',true) == 0 //封神礼包
                AddPlayerTechResearched(Player(pid),'RJ1U',1)
            endif 
            if  GetPlayerTechCount(Player(pid),'RJ1V',true) == 0 //金币礼包
                AddPlayerTechResearched(Player(pid),'RJ1V',1)
            endif 
            if  GetPlayerTechCount(Player(pid),'RJ1W',true) == 0 //木材礼包
                AddPlayerTechResearched(Player(pid),'RJ1W',1)
            endif 
        endif
        /////////////////////载入属性////////////////////////
        if  GetPlayerTechCount(Player(pid),'RY1D',true) == 1 //星月光环
            AddUnitRealState(Pu[1],47,10)
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,2000)
        endif
        if  GetPlayerTechCount(Player(pid),'RY2D',true) == 1 //幻莲仙翼
            AddUnitRealState(Pu[1],31,30)
            AddUnitRealState(Pu[1],17,30)
            AddUnitRealState(Pu[1],9,30)
            AddUnitRealState(Pu[1],50,20)
        endif 
        if  GetPlayerTechCount(Player(pid),'RY3D',true) == 1 //戮仙剑
            AddUnitRealState(Pu[1],32,30)
            AddUnitRealState(Pu[1],33,30)
            AddUnitRealState(Pu[1],19,10)
            AddUnitRealState(Pu[1],17,30)
        endif
        if  GetPlayerTechCount(Player(pid),'RY4D',true) == 1 //金鼠送福
            UnitAddItemEx(Pu[1],'IP01')
            AddUnitRealState(Pu[1],18,20)
            AddUnitRealState(Pu[1],17,30)
            UnitAddItemEx(Pu[1],'I015')
        endif 
        if  GetPlayerTechCount(Player(pid),'RK1A',true) == 1 //小狐妖
            AddUnitRealState(Pu[1],28,1)
            AddUnitRealState(Pu[1],33,20)
            CreatePet.execute(pid)
        endif
        if  GetPlayerTechCount(Player(pid),'RJ1U',true) == 1 //封神礼包
            AddUnitRealState(Pu[1],31,10)
            AddUnitRealState(Pu[1],47,20)
            AddUnitRealState(Pu[1],48,20)
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,10)
        endif 
        if  GetPlayerTechCount(Player(pid),'RJ1V',true) == 1 //金币礼包
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,2000)
        endif 
        if  GetPlayerTechCount(Player(pid),'RJ1W',true) == 1 //木材礼包
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,5)
        endif 

    endfunction





endlibrary


