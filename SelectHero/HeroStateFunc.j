library HeroStateFunc uses DamageCode


    function InitPlayerDzShopState(int pid)
        int lv = DzPlayerLv(Player(pid))
        /////////////////////额外给予////////////////////////
        if  DzAPI_Map_IsBlueVIP(Player(pid)) == true
            if  GetPlayerTechCount(Player(pid),'RK1A',true) == 0 //小狐妖
                AddPlayerTechResearched(Player(pid),'RK1A',1)
            endif
        endif
        if  DzAPI_Map_GetGuildName(Player(pid)) == "星辰俱乐部" 
            if  GetPlayerTechCount(Player(pid),'RK1A',true) == 0 //小狐妖
                AddPlayerTechResearched(Player(pid),'RK1A',1)
            endif
            if  GetPlayerTechCount(Player(pid),'RY2D',true) == 0 //幻莲仙翼
                AddPlayerTechResearched(Player(pid),'RY2D',1)
            endif 
        endif
        if  IsPlayerIn_MZRPG_Admin(pid) == true
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

        if  GetPlayerTechCount(Player(pid),'RY1D',true) == 0 //星月光环
            AddUnitRealState(Pu[1],46,(1*lv))
            AddUnitRealState(Pu[1],45,(5*lv))
            UnitAddItemEx(Pu[1],'CS01')
            BJDebugMsg("光环")
        endif
        if  GetPlayerTechCount(Player(pid),'RY2D',true) == 0 //幻莲仙翼
            AddUnitRealState(Pu[1],45,100+(20*lv))
            AddUnitRealState(Pu[1],47,100+(20*lv))
            AddUnitRealState(Pu[1],15,50)
            AddUnitRealState(Pu[1],16,50)
        endif 
        if  GetPlayerTechCount(Player(pid),'RY3D',true) == 0 //戮仙剑
            AddUnitRealState(Pu[1],43,30+(5*lv))
            AddUnitRealState(Pu[1],48,100+(20*lv))
            AddUnitRealState(Pu[1],19,10)
            AddUnitRealState(Pu[1],21,10)
        endif
        if  GetPlayerTechCount(Player(pid),'RY4D',true) == 0 //金鼠送福
            
        endif 
        if  GetPlayerTechCount(Player(pid),'RK1A',true) == 0 //小狐妖
            AddUnitRealState(Pu[1],49,100+(20*lv))
            AddUnitRealState(Pu[1],48,50+(20*lv))
            CreatePet.execute(pid)
        endif
        if  GetPlayerTechCount(Player(pid),'RJ1U',true) == 0 //封神礼包
            AddUnitRealState(Pu[1],50,10+(3*lv))
            AddUnitRealState(Pu[1],49,50+(20*lv))
        endif 
        if  GetPlayerTechCount(Player(pid),'RJ1V',true) == 0 //金币礼包
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,2000)
        endif 
        if  GetPlayerTechCount(Player(pid),'RJ1W',true) == 0 //木材礼包
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,1)
        endif 

    endfunction





endlibrary


