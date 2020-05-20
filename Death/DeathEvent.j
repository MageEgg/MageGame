
scope DeathEvent initializer InitDeathEvent

    int ReviveUnitMax = 0
    int array ReviveUnitType
    int array ReviveUnitTime
    real array ReviveUnitX
    real array ReviveUnitY
    #define NowReviveUnitType ReviveUnitType[i]
    #define NowReviveUnitTime ReviveUnitTime[i]
    #define NowReviveUnitX ReviveUnitX[i]
    #define NowReviveUnitY ReviveUnitY[i]
    #define MaxReviveUnitType ReviveUnitType[max]
    #define MaxReviveUnitTime ReviveUnitTime[max]
    #define MaxReviveUnitX ReviveUnitX[max]
    #define MaxReviveUnitY ReviveUnitY[max]
    
    int GameVictory = 0
    
    
    
    
    func ReviveWildMonsterTimer()
        int max = ReviveUnitMax
        real ang = 0
        unit u = null
        if  max > 0
            for i = 1,max
                NowReviveUnitTime = NowReviveUnitTime - 1
                if  NowReviveUnitTime == 0
                    if  NowReviveUnitType == 'uJ90'
                        ang = 270
                    else
                        ang = GetRandomReal(0,360)
                    endif
                    u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),NowReviveUnitType,NowReviveUnitX,NowReviveUnitY,ang)

                    SetUnitPointX(u,NowReviveUnitX)
                    SetUnitPointY(u,NowReviveUnitY)
                    //call LocAddEffect(NowReviveUnitX,NowReviveUnitY,"war3mapImported\\effect_az-blue-lizi-shangsheng.mdl" )
                    if  i == max
                        ReviveUnitMax = ReviveUnitMax - 1
                    else
                        NowReviveUnitType = MaxReviveUnitType
                        NowReviveUnitTime = MaxReviveUnitTime
                        NowReviveUnitX = MaxReviveUnitX
                        NowReviveUnitY = MaxReviveUnitY
                        ReviveUnitMax = ReviveUnitMax - 1
                        max = max - 1
                        i = i - 1
                    endif
                endif
            end
        endif
        u = null
    end
    function AddReviveWildMonster(unit wu,int time,real x,real y)
        int max = ReviveUnitMax + 1
        ReviveUnitMax = max
        MaxReviveUnitType = GetUnitTypeId(wu)
        MaxReviveUnitTime = time
        MaxReviveUnitX = x
        MaxReviveUnitY = y
    endfunction
    function RevivePlayerHeroTimer()
        int pid = GetHandleData(GetExpiredTimer())
        real x = PlayerReviveX
        real y = PlayerReviveY
        if  GameOverBoolJu == false
            //BJDebugMsg(I2S(pid)+"fh"+GetUnitName(Pu[1]))
            if  GameChallengePlayerBool[pid][4] == true and GetUnitAbilityLevel(Pu[1],'AZ96') != 5
                x = AttackRoomPostion[pid][1]
                y = AttackRoomPostion[pid][2]
            endif
            ReviveHero(Pu[1],x,y,true)
            if  GetUnitAbilityLevel(Pu[1],'AZ96') == 5
                if  GetLocalPlayer() == Player(pid)
                    SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
                    PanCameraToTimed( x, y, 0 )
                endif
            else
                SendPlayerUnit(pid,x,y)
            endif
            AddUnitStateExTimer(Pu[1],11,100,2)
            PlayerDeathBool = false
        endif
        DestroyTimerDialog(Pdia[0])
        PauseTimer(GetExpiredTimer())
        DestroyTimer(GetExpiredTimer())
    endfunction




    function RevivePlayerHero(int pid)
        timer wt = CreateTimer()
        int time = 8

        if  GameSaveClose == 0
            if  GetPlayerTechCount(Player(pid),'RDAU',true) > 0
                time = time - 1
            endif
            if  GetPlayerTechCount(Player(pid),'RG0H',true) > 0
                time = time - 1
            endif
            if  GetPlayerTechCount(Player(pid),'RGAJ',true) > 0
                time = time - 1
            endif
        endif

        PlayerDeathBool = true
        PetDeathPosition(pid)
        SetHandleData(wt,pid)
        Pdia[0] = CreateTimerDialog(wt)
        TimerDialogSetTitle(Pdia[0],GetPN(pid)+GetUnitName(Pu[1])+"复活时间:" )
        TimerDialogDisplay(Pdia[0], true)
        TimerStart(wt,time,false,function RevivePlayerHeroTimer)
        wt = null
    endfunction
    
    

    
    

    


    function PlayerUseGoldBox(int pid,int itemid)
        //使用招魂幡
        int gold = 0
        int exp = 0
        int i1 = 0
        int i2 = 0
        int i3 = 0

        if  itemid == 'I010'
            gold = GetRandomInt(3000,6000)
        elseif  itemid == 'I011'
            gold = GetRandomInt(7000,12000)
            exp = 1000
        elseif  itemid == 'I012'
            gold = GetRandomInt(8000,13000)
            exp = 2000
        elseif  itemid == 'I013'
            gold = GetRandomInt(9000,14000)
            exp = 4000
        elseif  itemid == 'I014'
            gold = GetRandomInt(10000,15000)
            exp = 7000
        elseif  itemid == 'I015'
            gold = GetRandomInt(12000,17000)
            exp = 10000
        elseif  itemid == 'I051'
            gold = 2000
            exp = 1000
        elseif  itemid == 'I052'
            gold = 2500
            exp = 1250
        elseif  itemid == 'I053'
            gold = 3000
            exp = 1500
        elseif  itemid == 'I054'
            gold = 3500
            exp = 1750
        elseif  itemid == 'I055'
            gold = 4500
            exp = 2000
        endif


        AdjustPlayerStateBJ( gold , Player(pid), PLAYER_STATE_RESOURCE_GOLD )
        if  exp > 0
            HeroAddExp( Pu[1], exp)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r使用"+GetObjectName(itemid)+" |cffffcc00金币+"+I2S(gold)+"|cff00ff7f经验+"+I2S(exp))
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r使用"+GetObjectName(itemid)+" |cffffcc00金币+"+I2S(gold))
        endif
        
        
        
    endfunction

    function PlayerItemGrowFunc(int pid,item it,int exp)->bool
        int id = GetItemTypeId(it)
        int num = GetItemCharges(it)
        
        if  num - exp >= 1
            SetItemCharges(it,num-exp)
            return false
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：恭喜您成功炼化" + GetObjectName(id))
            UnitRemoveItem(Pu[1],it)
            RemoveItem(it)
            return true
        endif
    endfunction

    function PlayerItemGrowSuperFunc(int pid,item it,int exp)->bool
        int id = GetItemTypeId(it)
        int num = GetItemCharges(it)
        
        if  num - exp >= 1
            SetItemCharges(it,num-exp)
            return false
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：恭喜您成功炼化" + GetObjectName(id))
            SetItemCharges(it,1000)
            return true
        endif
    endfunction

    function PlayerItemIncFunc(int pid,item it,int exp)
        int id = GetItemTypeId(it)
        int num = GetItemCharges(it)
        int next = GetTypeIdData(id,106)
        int gl = GetTypeIdData(id,104)
        int fmid = 0
        
            
        if  num-exp >= 1
            SetItemCharges(it,num-exp)
        else

            if  next == 'E102' or next == 'E103'
                gl = 100
            endif

            if  GameSaveClose == 0
                if  GetPlayerTechCount(Player(pid),'RG1B',true)>0
                    gl = gl + 5
                endif
                if  GetPlayerTechCount(Player(pid),'RG1D',true)>0
                    gl = gl + 5
                endif
                if  GetPlayerTechCount(Player(pid),'RG1E',true)>0
                    gl = gl + 5
                endif
            endif

            BJDebugMsg("项链成功率"+I2S(gl))
            if  gl < 40
                gl = 40
            endif

                


            if  GetRandomInt(1,100)<= gl
                SetItemDroppable(it,true)
                
                fmid = GetItemIntState(it,'FMID')
                UnitRemoveItem(Pu[1],it)
                RemoveItem(it)
                bj_lastCreatedItem = CreateItem(next,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetItemIntState(bj_lastCreatedItem,'FMID',fmid)
                UnitAddItem(Pu[1],bj_lastCreatedItem)
                UnitAddEffect(Pu[1],"effect_e_buffyellow2.mdx")
                bj_lastCreatedItem = null

                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cff00ff00[系统]：恭喜您！饰品升级成功！")
            else
                SetItemCharges(it,GetTypeIdData(id,100))
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffff0000[系统]：很遗憾！饰品升级失败！")
            endif
        endif
    endfunction

    function PlayerItemGrow(int pid)
        int next = 0
        int id = 0
        int lv = 0
        for i1 = 0,5
            id = GetItemTypeId(UnitItemInSlot(Pu[1],i1))
            if  id >= 'I010' and id <= 'I015'
                if  GameMode == 4
                    if  PlayerItemGrowFunc(pid,UnitItemInSlot(Pu[1],i1),2) == true
                        PlayerUseGoldBox(pid,id)
                    endif
                else
                    if  PlayerItemGrowFunc(pid,UnitItemInSlot(Pu[1],i1),1) == true
                        PlayerUseGoldBox(pid,id)
                    endif
                endif
                exitwhen true      
            endif
        end


        for i2 = 0,5
            id = GetItemTypeId(UnitItemInSlot(Pu[1],i2))
            if  id >= 'E101' and id <= 'E129'
                if  GameMode == 3 or GameMode == 4
                    PlayerItemIncFunc(pid,UnitItemInSlot(Pu[1],i2),2)
                else
                    PlayerItemIncFunc(pid,UnitItemInSlot(Pu[1],i2),1)
                endif
                exitwhen true
            endif
        end

        for i3 = 0,5
            id = GetItemTypeId(UnitItemInSlot(Pu[1],i3))
            if  id >= 'I051' and id <= 'I055'
                if  GameMode == 4
                    if  PlayerItemGrowSuperFunc(pid,UnitItemInSlot(Pu[1],i3),2) == true
                        PlayerUseGoldBox(pid,id)
                    endif
                else
                    if  PlayerItemGrowSuperFunc(pid,UnitItemInSlot(Pu[1],i3),1) == true
                        PlayerUseGoldBox(pid,id)
                    endif
                endif
                exitwhen true
            endif
        end
                    
    endfunction
    
    function PlayerHeroAddState(int pid,int uid,unit wu)
        int index = 0
        int value = 0
        real ste = 0
        real gold = 0
        real wood = 0
        int exp = 0
        
        //杀敌数
        //AddUnitIntState(Pu[1],108,1)
        
        exp = 10
        gold = GetTypeIdData(uid,103)
        if  gold == 0
            if  uid != 'u020'
                gold = 10
            endif
        else
            if  uid >= 'u0BA' and uid <= 'u0BZ'
                //山魈妖魅 60%收益
                gold = gold * GetRandomReal(0.6,1)
            endif
        endif

        if  uid == 'ut20'
            gold = 35
            exp = 10
        elseif  uid >= 'm10A' and uid <= 'm10C'
            gold = AttackUnitWN/5*2+6
            exp = 20
        elseif  uid >= 'm11A' and uid <= 'm11C'
            gold = AttackUnitWN/5*2+6
            exp = 20
        elseif  uid >= 'mf0A' and uid <= 'mf0H'
            gold = AttackUnitWN/10
            gold = gold * 2000
            exp = 500
        endif


        
        
        
        //杀敌金币
        
        if  gold > 0
            gold = gold * (1+GetUnitRealState(Pu[1],41)*0.01)+0.001

            gold = gold + GetUnitRealState(Pu[1],46)

            AdjustPlayerStateBJ( R2I(gold) ,Player(pid), PLAYER_STATE_RESOURCE_GOLD )
            if  wu != null
                UnitAddTextPlayer(wu,Player(pid),"+"+I2S(R2I(gold+0.0001)),255,202,0,255,90,0.023)
            endif
        endif

        //杀敌经验
        if  exp > 0
            exp = exp + R2I(I2R(exp) * GetUnitRealState(Pu[1],64)*0.01)
            HeroAddExp( Pu[1],exp)
        endif



        //杀敌属性
        ste = GetUnitRealState(Pu[1],43)
        if  ste > 0
            AddUnitRealState(Pu[1],1,ste)
        endif
        ste = GetUnitRealState(Pu[1],44)
        if  ste > 0
            AddUnitRealState(Pu[1],2,ste)
        endif
        ste = GetUnitRealState(Pu[1],45)
        if  ste > 0
            AddUnitRealState(Pu[1],5,ste)
        endif
        
    endfunction


    function ut20UnitDeath(int p,unit wu)
        real x = 0
        real y = 0
        for pid = 0,3
            if  p != pid
                x = GetUnitX(Pu[1])
                y = GetUnitY(Pu[1])

                if  GetRectMinX(gg_rct_ChallengeRctConE) <= x and x <= GetRectMaxX(gg_rct_ChallengeRctConE) and GetRectMinY(gg_rct_ChallengeRctConE) <= y and y <= GetRectMaxY(gg_rct_ChallengeRctConE)
                    PlayerHeroAddState(pid,'ut20',null)
                endif
            endif
        end
    endfunction

    function CreateNewForg(int id1,int id2)
        int pid = id1
        int uid = id2
        TimerStart(30,false)
        {
            Pu[120]=CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid+1,AttackRoomPostion[pid][1] +256,AttackRoomPostion[pid][2]+512,225)
            SetUnitOwner( Pu[120], Player(PLAYER_NEUTRAL_PASSIVE), true )
            SetPlayerOnlyDamage(Pu[120],pid)
            UnitAddAbility(Pu[120],'Awan')
            //LocAddEffect(AttackRoomPostion[pid][1] +384,AttackRoomPostion[pid][2]+192,"effect_az_bw_lina_t1-2.mdl")
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function ForgEscapeTimer(int id,unit wu)
        int pid = id
        unit u1 = wu
        
        SetUnitOwner(u1,Player(PLAYER_NEUTRAL_PASSIVE),false)
        SetUnitState(u1,UNIT_STATE_LIFE,GetUnitState(u1,UNIT_STATE_MAX_LIFE))
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：送宝金蟾逃跑啦！10秒后再来吧！|r")
        SetUnitPosition(u1,AttackRoomPostion[pid][1] +256,AttackRoomPostion[pid][2]+512)
        UnitAddAbility(u1,'Avul')
        ShowUnit(u1,false)
        TimerStart(10,false)
        {
            UnitRemoveAbility(u1,'Avul')
            ShowUnit(u1,true)
            endtimer
            flush locals
        }
        flush locals
        
    endfunction

    function ForgKillTimer(unit wu,int ppid)
        unit u1 = wu
        int id = GetUnitTypeId(u1)
        int time = 20
        int pid = ppid
        
        SetUnitOwner(u1,Player(PLAYER_NEUTRAL_AGGRESSIVE),false)
        SetUnitIntState(u1,'Forg',20)
        SetUnitIntState(u1,'Fort',20)
        //UnitAddAbility(u1,'AZ31')
        TimerStart(1,true)
        {
            
            time = time - 1
            if  time <= 0 or GetUnitTypeId(u1) == 0 or PlayerDeathBool == true  or IsLocInRect(PlayerAttackRoomRect[pid],GetUnitX(Pu[1]),GetUnitY(Pu[1])) == false
                
                if  GetUnitTypeId(u1) == id
                    if  GetUnitState(u1,UNIT_STATE_LIFE) > 0
                        //UnitRemoveAbility(u1,'AZ31')
                        ForgEscapeTimer(pid,u1)
                        if  Pu[6] == u1
                            Pu[6] = null
                        endif
                    endif
                endif
                
                endtimer
            else
                SetUnitIntState(u1,'Fort',time)
            endif
            flush locals
        }
        flush locals
    endfunction

    
    

    //星辰阵
    function KillXCUnitFunc(unit wu,unit tu,int uid)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int num = AttackRoomXCUnitNum
        
        AttackRoomXCUnitNum = AttackRoomXCUnitNum - 1
        if  uid == 'u0DF' or uid == 'u0DL' or uid == 'u0DR' or uid == 'u0DX'
            
            AttackRoomXCNum = AttackRoomXCNum + 1

            CreateItem('IN31',GetUnitX(tu),GetUnitY(tu))
            if  AttackRoomXCNum > 23
                AdjustPlayerStateBJ( 10 ,Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r"+GetObjectName(uid)+"挑战成功！奖励幸运星盒x1 玄铁+10")
            else
                AdjustPlayerStateBJ( 20 ,Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r"+GetObjectName(uid)+"挑战成功！奖励幸运星盒x1 玄铁+20")
            endif
            SetBoardText(5,pid+2,"第|cff00ff00"+I2S(AttackRoomXCNum)+"|r星宿")
        else

            if  AttackRoomXCUnitNum <= 0
                AttackRoomXCNum = AttackRoomXCNum + 1

                CreateItem('IN30',GetUnitX(tu),GetUnitY(tu))
                AdjustPlayerStateBJ( 5 ,Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r星宿之灵挑战成功！奖励幸运星盒x1 玄铁+5")
                SetBoardText(5,pid+2,"第|cff00ff00"+I2S(AttackRoomXCNum)+"|r星宿")
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r星宿之灵("+I2S(10-AttackRoomXCUnitNum)+"/10)")
            endif
        endif

        
    endfunction
    
   
    function DropChallengeUnit(unit tu)
        int pid = 0
        int gold = 0
        int fbid = 0
        int id = 0
        

        for i = 0,2
            id = GetItemTypeId(UnitItemInSlot(tu,i))
            if  id >= 'IF01' and id <= 'IF52'
                fbid = id - 'IF00' + 'FB00'
            elseif  id == 'IC02'
                gold = GetItemCharges(UnitItemInSlot(tu,i))
            else
                SetItemPosition(UnitItemInSlot(tu,i),GetUnitX(tu),GetUnitY(tu))
            endif
        end

        pid = GetUnitAbilityLevel(tu,'AZ99')
        if  pid > 0
            pid = pid - 1

            if  fbid > 0
                GivePlayerMagicItem(pid,fbid)
            endif
            if  gold > 0
                AdjustPlayerStateBJ(gold ,Player(pid), PLAYER_STATE_RESOURCE_GOLD )
                UnitAddTextPlayer(tu,Player(pid),"+"+I2S(gold),255,202,0,255,90,0.023)
                
            endif
        endif


    endfunction 
    

    function HeroKillMoster(unit wu,unit tu)
        //wu是凶手 tu是死亡单位
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int uid = GetUnitTypeId(tu)
        int value = 0
        real x = AttackRoomPostion[pid][1] 
        real y = AttackRoomPostion[pid][2] 

        
        
        
        MissionKillUnit(pid,uid)

        if  uid >= 'mg0A' and uid <= 'mg0H'
            
            DropChallengeUnit(tu)
        endif


        if  uid >= 'uE01' and uid <= 'uE99'
            IncEquipKillUnitFunc(wu,tu)
        elseif  uid == 'u020'
            //妖媚数量
            KillYMUnitNum = KillYMUnitNum + 1
        elseif  uid >= 'u0DA' and uid <= 'u0DZ'
            KillXCUnitFunc(wu,tu,uid)
        elseif  uid >= 'u001' and uid <= 'u004'
            SetAttackRoomUnitId(pid,'g00A'+ (uid - 'u000'))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r送宝金蟾挑战成功！练功房内资源怪提升！")
            

            if  uid == 'u001'//占星NPC
                Pu[28]=CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np03',x-512,y,270)//兽魂神通
                CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'nc03',x-512,y,270)//兽魂神通
                if  GameSaveClose == 0
                    if  GetPlayerTechCount(Player(pid),'RSHD',true) > 0
                        if  GetLocalPlayer() == Player(pid)
                            YDWESetItemDataString('IS13',3,"|cfff0f0f0白色强化价格：|r|cffffd24d2500\n|r|cff00ff7f绿色|r|cfff0f0f0强化价格：|r|cffffd24d5000\n|r|cff00bfff蓝色|r|cfff0f0f0强化价格：|r|cffffd24d10000\n|r|cffbf00ff紫色|r|cfff0f0f0强化价格：|r|cffffd24d20000\n黄色|r|cfff0f0f0强化价格：|r|cffffd24d30000\n|r|cffff0000红色|r|cfff0f0f0强化价格：|r|cffffd24d50000\n\n|r|cff00ff7f消耗金币，100%几率提高饰品1级。|r")
                        endif
                    endif
                endif

                UnitAddEffectOfNPC(Pu[28])

                
                
            endif
            if  uid != 'u004'
                CreateNewForg(pid,uid)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r金蟾它老豆生气了！30秒来找你报仇！")
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r金蟾家族一个不剩了......")
            endif
        elseif  uid >= 'uJ00' and uid <= 'uJzz'
            int num =  GetUnitIntState(Pu[1],150)
            if  uid == 'uJA0'
                if  num == 10
                AddPlayerImmortalFruit(Pu[1],'IJ11',1)
                endif
            else
                if  num < 10
                    if  uid == 'uJ00'
                        AddPlayerImmortalFruit(Pu[1],'IJ01',1)
                    elseif  uid == 'uJ10'
                        AddPlayerImmortalFruit(Pu[1],'IJ02',1)
                    elseif  uid == 'uJ20'
                        AddPlayerImmortalFruit(Pu[1],'IJ03',1)
                    elseif  uid == 'uJ30'
                        AddPlayerImmortalFruit(Pu[1],'IJ04',1)
                    elseif  uid == 'uJ40'
                        AddPlayerImmortalFruit(Pu[1],'IJ05',1)
                    elseif  uid == 'uJ50'
                        AddPlayerImmortalFruit(Pu[1],'IJ06',1)
                    elseif  uid == 'uJ60'
                        AddPlayerImmortalFruit(Pu[1],'IJ07',1)
                    elseif  uid == 'uJ70'
                        AddPlayerImmortalFruit(Pu[1],'IJ08',1)
                    elseif  uid == 'uJ80'
                        AddPlayerImmortalFruit(Pu[1],'IJ09',1)
                    elseif  uid == 'uJ90'
                        AddPlayerImmortalFruit(Pu[1],'IJ10',1)
                    endif 
                endif
            endif
        elseif  uid >= 'm11A' and uid <= 'm11C'
            AdjustPlayerStateBJ(1, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r击杀精英怪，玄铁+1！")
        elseif  uid >= 'mf0A' and uid <= 'mf0H'
            if  GetRandomInt(1,100) <= 40
                CreateItem('IN31',GetUnitX(tu),GetUnitY(tu))
            elseif  GetRandomInt(1,100) <= 66
                CreateItem(GetRandomInt('IK01','IK08'),GetUnitX(tu),GetUnitY(tu))
            else
                CreateItem(GetRandomInt('IK91','IK98'),GetUnitX(tu),GetUnitY(tu))
            endif
        endif

        if  (uid >= 'm001' and uid <= 'm050') or (uid >= 'ma01' and uid <= 'ma0z') or (uid >= 'mb01' and uid <= 'mb0z')
            DzHeroMedalDeathCos = DzHeroMedalDeathCos + 1
            if  ModuloInteger(DzHeroMedalDeathCos,100) == 0
                if  GetDzPlayerData(pid,16,2) < 896//MaxHeroBaseMedal*MaxGameLevel
                    if  DzHeroMedalGameExp < GameLevel*32
                        DzHeroMedalGameExp = DzHeroMedalGameExp + GameLevel
                        AddDzPlayerData(pid,16,1,GameLevel)
                        AddDzPlayerData(pid,16,2,GameLevel)
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[战勋]：|r|cffff8000累积击杀100只进攻怪，战勋点+"+I2S(GameLevel)+"！|R")
                    endif
                endif
            endif
            if  (uid >= 'mb01' and uid <= 'mb0z')
                if  GetDzPlayerData(pid,16,2) < 896//MaxHeroBaseMedal*MaxGameLevel
                    if  DzHeroMedalGameExp < GameLevel*32
                        DzHeroMedalGameExp = DzHeroMedalGameExp + GameLevel
                        AddDzPlayerData(pid,16,1,GameLevel)
                        AddDzPlayerData(pid,16,2,GameLevel)
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[战勋]：|r|cffff8000成功击杀进攻BOSS，战勋点+"+I2S(GameLevel)+"！|R")
                    endif
                endif
            endif
        elseif  uid == 'uh02'//狂欢活动恶霸
            for jfpid = 0,3
                DisplayTimedTextToPlayer(Player(jfpid),0,0,5,"|cffffcc00[51狂欢]：|r|cffff8000成功击杀好吃懒做的恶徒！狂欢积分+10，玄铁+2|r")
                if  IsPlaying(jfpid) == true 
                    if  GetDzPlayerData(jfpid,18,3) <= 1990
                        AddDzPlayerData(jfpid,18,1,10)
                        AddDzPlayerData(jfpid,18,3,10)
                    else
                        DisplayTimedTextToPlayer(Player(jfpid),0,0,5,"|cffffcc00[51狂欢]：|r狂欢积分今日已达上限!")
                    endif
                    AdjustPlayerStateBJ( 2 ,Player(jfpid), PLAYER_STATE_RESOURCE_LUMBER )
                endif
                
            end
        elseif  uid == 'uh01'//山
            for spid = 0,3
                if  IsPlaying(spid) == true
                    if  tu == PlayerUnit[spid][40]
                        if  GetDzPlayerData(spid,18,4) < 4
                            AddDzPlayerData(spid,18,2,1)
                            AddDzPlayerData(spid,18,4,1)
                            
                            DisplayTimedTextToPlayer(Player(spid),0,0,5,"|cffffcc00[51狂欢]：|r|cffff8000成功移走大山！祖传矿铲+1！|r")
                        else
                            DisplayTimedTextToPlayer(Player(spid),0,0,5,"|cffffcc00[51狂欢]：|r|cffff8000成功移走大山！(祖传矿铲今日已达上限)|r")
                        endif
                    endif
                endif
            end
            if  GetPlayerTechCount(GetOwningPlayer(wu),'RJ1Y',true) > 0
                CreateItem('CS53',GetUnitX(tu),GetUnitY(tu))
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：拥有商城道具劳动节礼包，必定掉落高级附魔石！")
            else
                if  GetRandomInt(1,100) <= 30
                    CreateItem('CS53',GetUnitX(tu),GetUnitY(tu))
                else
                    CreateItem('CS52',GetUnitX(tu),GetUnitY(tu))
                endif
            endif
        endif

        /*
        if  uid >= 'mR61' and uid <= 'mR79'//轮回
            if  KillTechMosterFunc(Pu[1],uid-0x22000000,CalculationNewId('KR60',GetTypeIdIndex(uid,'mR60')-1)) == true
                SetUnitIntState(Pu[1],'KR60',GetTypeIdIndex(uid,'mR60'))
                SetPlayerUnitPostionSelectUnit(Pu[1],518 ,-5441 ,Pu[1])
            endif
        elseif  uid >= 'm001' and uid <= 'm099'
            KillAttackUnitNum = KillAttackUnitNum + 1
            if  KillAttackUnitNum - (KillAttackUnitNum / 10) * 10 == 0
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r进攻怪击杀数量：("+I2S(KillAttackUnitNum)+"50)")
            endif
            if  KillAttackUnitNum >= 50
                KillAttackUnitNum = 0
                AddData(pid,1,2,2)
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|r玩家"+ GetPN(pid) +"击杀进攻怪数量达到50！奖励守家积分2点。")
            endif
        endif
        */
        
       
    endfunction
    
    func PlayerHeroKillUnit(unit wu,unit tu)
        int id = 0
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int slv = 0
        int uid = GetUnitTypeId(tu)
        real ran = 0
        
        //AddUnitIntState(Pu[1],101,1+R2I(GetUnitRealState(wu,70)))
        
        
        //成长类物品
        if  PlayerDeathBool == false
            PlayerItemGrow(pid)
        endif
        //增加类
        PlayerHeroAddState(pid,uid,tu)


        if  uid >= 'g00A' and uid <= 'g00Z'
            if  GetRandomReal(1,10000)<=5
                CreateItem('IN30',GetUnitX(tu),GetUnitY(tu))
            endif
        elseif  uid == 'ut20'
            if  GetPlayerTechCount(Player(pid),'RY4S',true) > 0
                ran = 60*1.3
            else
                ran = 60
            endif
            if  GetRandomReal(1,10000)<=ran
                CreateItem('CS51',GetUnitX(tu),GetUnitY(tu))
            endif
        endif


        if  uid == 'uJA1'//风神
            UnitAddAbility(Pu[1],'A00E')
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r成功击杀风神，获得免疫罡风伤害效果！")
        elseif  uid == 'uJA2'//火神
            UnitAddAbility(Pu[1],'A00F')
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r成功击杀火神，获得免疫熔岩地面效果效果！")
        elseif  uid == 'uJA3'//雷神
            UnitAddAbility(Pu[1],'A00D')
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r成功击杀雷神，获得免疫天雷眩晕效果！")
        endif


    end
    function KillUnitNotHasKiller(unit wu,int uid)
        if  GetUnitAbilityLevel(wu,'AZ99') > 0
            int pid = GetUnitAbilityLevel(wu,'AZ99') - 1
        endif
        if  uid >= 'u0DA' and uid <= 'u0DZ'
            if  pid >= 0
                AttackRoomXCUnitNum = AttackRoomXCUnitNum - 1
                if  AttackRoomXCUnitNum == 0
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[周天星辰阵]:激活星宿失败！")
                endif
            endif
        endif

    endfunction
    
    function AttackBossDeathEvent(unit boss)
        AttackBOSSDeathCos = AttackBOSSDeathCos + 1
        BJDebugMsg("AttackBOSSDeathCos "+I2S(AttackBOSSDeathCos)+"@@ AttackBOSSLastCos "+I2S(AttackBOSSLastCos))
        if  AttackBOSSDeathCos == AttackBOSSLastCos
            AttackBOSSDeathCos = 0
            AttackBOSSLastCos = 0
            if  GameLevel >= 5 and GameMode != 4
                if  GetUnitTypeId(boss) == LastAttackBossId
                    if  LastBOSSOpera == false
                        CreateOperaLastBoss()
                    else
                        ShowBossDamageUI(false)
                        ShowBossDamageString()
                        AttackUnitWin()
                    endif
                else
                    ShowBossDamageUI(false)
                    ShowBossDamageString()
                endif
            else
                ShowBossDamageUI(false)
                ShowBossDamageString()
                if  GetUnitTypeId(boss) == LastAttackBossId
                    AttackUnitWin()
                endif
            endif
        endif
        CreateItem('IN30',GetUnitX(boss),GetUnitY(boss))
        LocAddEffect(GetUnitX(boss),GetUnitY(boss),"effect_az_gift02.mdx")
        LocAddEffect(GetUnitX(boss),GetUnitY(boss),"effect_az_gift02.mdx")
        PingMinimap(GetUnitX(boss),GetUnitY(boss),5)
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,6,"|cffffcc00[系统]:|cffff0000"+GetUnitName(boss)+"死亡，掉落了"+GetObjectName('IN30')+"！|r")
    endfunction

    function GameOverEx()
        GameOverBoolJu = true
        
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffff0000怪物超过上限！游戏失败!!")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffff0000怪物超过上限！游戏失败!!")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffff0000怪物超过上限！游戏失败!!")

        for pid = 0,3
            if  IsPlaying(pid) == true 
                if  AttackUnitWN >= 20
                    AddDzHeroExp(Pu[1],2)
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|cff00ff00增加"+GetUnitName(Pu[1])+"20点熟练度！|r")
                endif
            endif
        end
        
        TimerStart(1,false)
        {
            for pid = 0,3
                CustomDefeatBJ(Player(pid), "游戏结束！" )
            end
            endtimer
        }
    endfunction

    function GameOver()
        GameOverBoolJu = true
        
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffff0000封神榜已经被摧毁！游戏失败!!")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffff0000封神榜已经被摧毁！游戏失败!!")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffff0000封神榜已经被摧毁！游戏失败!!")

        for pid = 0,3
            if  IsPlaying(pid) == true 
                if  AttackUnitWN >= 15
                    AddDzHeroExp(Pu[1],2)
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|cff00ff00增加"+GetUnitName(Pu[1])+"20点熟练度！|r")
                endif
            endif
        end
        
        TimerStart(5,false)
        {
            for pid = 0,3
                CustomDefeatBJ(Player(pid), "游戏结束！" )
            end
            endtimer
        }
    endfunction

    
    function SpellRY3F(unit wu)->bool
        real gl = 0
        if  GameSaveClose == 0
            if  GetPlayerTechCount(GetOwningPlayer(wu),'RY3F',true) > 0
                gl = gl + 20
            endif
            if  GetPlayerTechCount(GetOwningPlayer(wu),'RX4E',true) > 0
                gl = gl + 5
            endif
        endif
        
        if  GetRandomReal(1,100) <= gl

            ReviveHero(wu,GetUnitX(wu),GetUnitY(wu),true)
            LocAddEffectTimer(GetUnitX(wu),GetUnitY(wu),"effect_SetItems_N4_Immortal.mdx",1.0)
            if  GetOwningPlayer(wu)==GetLocalPlayer()
                ClearSelection()
                SelectUnit(wu,true)
                PanCameraToTimed(GetUnitX(wu),GetUnitY(wu),0)
            endif
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|r玩家"+GetPlayerNameOfColor(GetPlayerId(GetOwningPlayer(wu)))+"原地重生了！")
            return true
        endif
        
        return false
    endfunction

    function DeathEventFunc()
    
        unit u1 = GetTriggerUnit()
        unit u2 = GetKillingUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int pid2 = GetPlayerId(GetOwningPlayer(u2))
        int uid = GetUnitTypeId(u1)
        int uid2 = GetUnitTypeId(u2)
        if  pid <= 3//玩家类型死亡
            if  IsUnitType(u1, UNIT_TYPE_HERO) == true//玩家死亡  复活英雄
                if  u1 == Pu[1]
                    if  SpellS529Spell(u1) == false and SpellRY3F(u1) == false
                        
                        RevivePlayerHero(pid)
                        BJDebugMsg("复活准备"+GetUnitName(Pu[1]))

                        GameChallengPlayerDeathEvent(u1)

                        AttackSummonUnitGroupDeathEvent(pid,u2)
                        WMSummonUnitGroupDeathEvent(pid,u2)
                    endif

                    
                    
                endif
            else
                if  uid == 'H005'
                    SpellS505Damage(u1)
                endif
            endif
        endif
        
        if  u1 == GameDefendUnit
            GameOver()
        elseif  u1 == AttackUnitBoss[10] and uid == 'mc06' //闻太师
            AttackOperaBEnding(1)
            if  GetUnitTypeId(u2) == 'H028' //彩蛋
                if  DzPlayerLv(Player(pid2)) >= 2
                    if  GetPlayerTechCount(Player(pid2),'RDAW',true) == 0
                        SetDzPlayerData(pid2,15,23,23)
                        SetPlayerTechResearchedEx(Player(pid2),'RDAW')
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid2)+"激活|cffffcc00【彩蛋】|cffff8000打自己人怎么了？|r（永久存档）！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid2),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000打自己人怎么了？|r，但可惜难度不够要求！")
                endif
            endif
        elseif  uid == 'mb09'//通天教主

            if  GetUnitTypeId(u2) == 'H003' //彩蛋
                if  DzPlayerLv(Player(pid2)) >= 6
                    if  GameLevel >= 3
                        if  GetPlayerTechCount(Player(pid2),'RDAT',true) == 0
                            SetDzPlayerData(pid2,15,20,20)
                            SetPlayerTechResearchedEx(Player(pid2),'RDAT')
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid2)+"激活|cffffcc00【彩蛋】|cffff8000师弟，你不行|r（永久存档）！")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid2),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000师弟，你不行|r，但可惜难度不够要求！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid2),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000师弟，你不行|r，但可惜地图等级不够要求！")
                endif
            elseif  GetUnitTypeId(u2) == 'H005' //彩蛋
                if  DzPlayerLv(Player(pid2)) >= 6
                    if  GameLevel >= 3
                        if  GetPlayerTechCount(Player(pid2),'RDAU',true) == 0
                            SetDzPlayerData(pid2,15,21,21)
                            SetPlayerTechResearchedEx(Player(pid2),'RDAU')
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid2)+"激活|cffffcc00【彩蛋】|cffff8000师弟，你真不行|r（永久存档）！")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid2),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000师弟，你真不行|r，但可惜难度不够要求！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid2),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000师弟，你真不行|r，但可惜地图等级不够要求！")
                endif
            endif
            
        endif
        if  u1 == PlayerUnit[pid2][6]
            PlayerUnit[pid2][6] = null
        endif
        //剧情任务等
        GameChallengeDeathEvent(u2,u1)

        if  pid > 3
            RanDropItem.execute(u1,pid2)//非玩家单位死亡，掉落物品


            if  uid == 'mb55'
                AttackUnitWin()
            endif


            //特殊判断无伤害来源可触发
            if  (uid >= 'mb01' and uid <= 'mb20') or ( uid >='mf0A' and uid <= 'mf0Z')
                AttackBossDeathEvent(u1)
            elseif  uid == 'ut20'
                ut20UnitDeath(pid2,u1)
            endif
            if  GetUnitAbilityLevel(u1,'AXAG') > 0
                SpellAXAG(u1)
            endif
            if  GetUnitAbilityLevel(u1,'AXAI') > 0
                SpellAXAI(u1)
            endif
            if  GetUnitAbilityLevel(u1,'AXCA') > 0 and GetRandomReal(1,100) > 40
                SpellAXAI(u1)
            endif
            if  GetUnitAbilityLevel(u1,'AXBB') > 0
                SpellAXBB(u1)
            endif

            if  IsPlayerAlly(GetOwningPlayer(u1),GetOwningPlayer(u2))==false
                
                if  u2 != null
                    //小怪死亡的资源类结算
                    PlayerHeroKillUnit(u2,u1)
                    //小怪死亡的其他功能
                    HeroKillMoster(u2,u1)

                    if  uid == 'utJA'
                        MeridiansChallengeDeath()
                    elseif  uid == 'utJE'
                        DragonKingChallengeDeath1()
                    elseif  uid == 'utJD'
                        DragonKingChallengeDeath2()
                    endif
                    if  uid >= 'uT0A' and uid <= 'uTZZ'
                        AttackUnitChallengeStateDeathEvent(pid2,u1)
                    endif
                else
                    KillUnitNotHasKiller(u1,uid)
                
                    //BJDebugMsg(GetUnitName(u1)+"死亡时无来源")
                endif
                
                if  GetUnitPointValueByType(uid) <= 20 and GetOwningPlayer(u1) == Player(PLAYER_NEUTRAL_AGGRESSIVE)
                    AddReviveWildMonster(u1,GetUnitPointValueByType(uid),GetUnitPointX(u1),GetUnitPointY(u1))
                endif

                if  GetUnitAbilityLevel(u1,'AZ99') > 0
                    if  IsUnitInGroup(u1,AttackSummonUnitGroup[GetUnitAbilityLevel(u1,'AZ99')-1]) == true //刷新单位组
                        RemoveAttackSummonUnit(GetUnitAbilityLevel(u1,'AZ99')-1,u1)
                    endif
                endif
                if  GetUnitAbilityLevel(u1,'AZ99') > 0
                    if  IsUnitInGroup(u1,WMSummonUnitGroup[GetUnitAbilityLevel(u1,'AZ99')-1]) == true //刷新单位组
                        RemoveWMSummonUnit(GetUnitAbilityLevel(u1,'AZ99')-1,u1)
                    endif
                endif
            endif

            if  IsUnitInGroup(u1,AttackUnitGroup) == true//刷新单位组
                GroupRemoveUnit(AttackUnitGroup,u1)
            endif

            if  IsUnitInGroup(u1,AttackOperaGroup_B_1) == true//刷新单位组
                GroupRemoveUnit(AttackOperaGroup_B_1,u1)
            endif
        
            if  IsUnitInGroup(u1,AttackOperaGroup_B_2) == true//刷新单位组
                GroupRemoveUnit(AttackOperaGroup_B_2,u1)
                if  ModuloInteger(43-CountUnitsInGroup(AttackOperaGroup_B_2),5) == 0 or 43-CountUnitsInGroup(AttackOperaGroup_B_2) == 40 or 43-CountUnitsInGroup(AttackOperaGroup_B_2) == 41 or 43-CountUnitsInGroup(AttackOperaGroup_B_2) == 42 or 43-CountUnitsInGroup(AttackOperaGroup_B_2) == 43
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[西征]：|r击杀闻太师大军("+I2S(43-CountUnitsInGroup(AttackOperaGroup_B_2))+"/43)")
                endif
                if  CountUnitsInGroup(AttackOperaGroup_B_2) == 1
                    OpenOperaB_Boss()
                endif
            endif

            FlushChildHashtable(ht,GetHandleId(u1))
            RemoveUnitTimer(u1,2)

        endif
        flush locals
    endfunction
    function InitDeathEvent()
        trigger trig = CreateTrigger()
        for i = 0,15
            TriggerRegisterPlayerUnitEvent(trig, Player(i), EVENT_PLAYER_UNIT_DEATH, null)
        end
        TriggerAddCondition(trig,Condition(function DeathEventFunc))
        TimerStart(CreateTimer(),1,true,function ReviveWildMonsterTimer)
        trig = null
    endfunction
endscope

