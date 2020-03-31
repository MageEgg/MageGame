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

        /*
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
        */
        /////////////////////等级赠送////////////////////////

        if  lv >= 18 //幻莲仙翼
            AddPlayerTechResearched(Player(pid),'RY2D',1)
        endif

        /*
        if  lv >= 24 //金鼠送福
            AddPlayerTechResearched(Player(pid),'RY4D',1)
        endif

        if  lv >= 32 //金鼠送福
            AddPlayerTechResearched(Player(pid),'RY3D',1)
        endif

        */
        /////////////////////载入属性////////////////////////



        if  GetPlayerTechCount(Player(pid),'RY1D',true) == 1 //星月光环
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,2000)
            AddUnitRealState(Pu[1],47,10)
        endif
        if  GetPlayerTechCount(Player(pid),'RY2D',true) == 1 //幻莲仙翼
            UnitAddItemEx(Pu[1],'CS01')
            AddUnitRealState(Pu[1],49,300)
            AddUnitRealState(Pu[1],18,12)
            AddUnitRealState(Pu[1],9,30)
            
            if  lv >= 18 and DzShop(Player(pid),"CB1") == true
                AddUnitRealState(Pu[1],49,150)
                AddUnitRealState(Pu[1],18,6)
                AddUnitRealState(Pu[1],9,15)
            endif
        endif 
        if  GetPlayerTechCount(Player(pid),'RY3D',true) == 1 //戮仙剑
            UnitAddItemEx(Pu[1],'CS02')
            AddUnitRealState(Pu[1],20,50)
            AddUnitRealState(Pu[1],19,10)
            AddUnitRealState(Pu[1],17,30)

            if  lv >= 32 and DzShop(Player(pid),"WQ1") == true
                AddUnitRealState(Pu[1],20,25)
                AddUnitRealState(Pu[1],19,5)
                AddUnitRealState(Pu[1],17,15)
            endif
        endif
        if  GetPlayerTechCount(Player(pid),'RY4D',true) == 1 //金鼠送福
            UnitAddItemEx(Pu[2],'I015')
            AddUnitRealState(Pu[1],64,10)
            AddUnitRealState(Pu[1],17,20)
            AddUnitRealState(Pu[1],52,20000)

            if  lv >= 24 and DzShop(Player(pid),"CH1") == true
                AddUnitRealState(Pu[1],64,5)
                AddUnitRealState(Pu[1],17,10)
                AddUnitRealState(Pu[1],52,10000)
            endif
        endif 
        if  GetPlayerTechCount(Player(pid),'RK1A',true) == 1 //小狐妖
            UnitAddItemEx(Pu[1],'IP01')
            AddUnitRealState(Pu[1],33,20)
            AddUnitRealState(Pu[1],48,20)
            CreatePet.execute(pid)
        endif
        if  GetPlayerTechCount(Player(pid),'RJ1U',true) == 1 //封神礼包
            AddUnitRealState(Pu[1],64,10)
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


