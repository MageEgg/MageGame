
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
        if  GameOverBoolJu == false
            //BJDebugMsg(I2S(pid)+"fh"+GetUnitName(Pu[1]))
            ReviveHero(Pu[1],PlayerReviveX,PlayerReviveY,true)
            if  Player(pid)==GetLocalPlayer()
                ClearSelection()
                SelectUnit(Pu[1],true)
                PanCameraToTimed(GetUnitX(Pu[1]),GetUnitY(Pu[1]),0)
            endif
            PlayerDeathBool = false
        endif
        DestroyTimerDialog(Pdia[0])
        PauseTimer(GetExpiredTimer())
        DestroyTimer(GetExpiredTimer())
    endfunction
    function RevivePlayerHero(int pid)
        timer wt = CreateTimer()
        PlayerDeathBool = true
        SetHandleData(wt,pid)
        Pdia[0] = CreateTimerDialog(wt)
        TimerDialogSetTitle(Pdia[0],GetPN(pid)+GetUnitName(Pu[1])+"复活时间:" )
        TimerDialogDisplay(Pdia[0], true)
        TimerStart(wt,8,false,function RevivePlayerHeroTimer)
        wt = null
    endfunction
    
    function PlayerItemGrowFunc(int pid,item it)
        int id = GetItemTypeId(it)
        int num = GetItemCharges(it)
        
        if  num > 1
            SetItemCharges(it,num-1)
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：恭喜您成功炼化" + GetObjectName(id))
            RemoveItem(it)
            
            
        endif
    endfunction

    
    function PlayerItemWRTFunc(int pid,item it,int exp)
        int id = GetItemTypeId(it)
        int num = GetItemCharges(it)
        
        if  num-exp > 1
            SetItemCharges(it,num-exp)
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：恭喜您成功将" + GetObjectName(id) + "晋升为" + GetObjectName(id+1))
            RemoveItem(it)
            UnitAddItem(Pu[1],CreateItem(id+1,0,0))
            
        endif
    endfunction

    
    function PlayerItemGrow(int pid)
        int id = 0
        int lv = 0
        for i1 = 0,5
            id = GetItemTypeId(UnitItemInSlot(Pu[1],i1))
            if  id >= 'EC01' and id <= 'EC08'
                PlayerItemGrowFunc(pid,UnitItemInSlot(Pu[1],i1))
                if  true
                    exitwhen true
                endif
            endif
        end
                    
    endfunction
    
   function PlayerHeroAddState(int pid,int uid,unit wu)
        int index = 0
        int value = 0
        real gold = 0
        real wood = 1
        int exp = 0
        

        gold = GetTypeIdData(uid,103)
        if  gold == 0
            if  uid != 'u020'
                gold = 10
            endif
        endif
        
        exp = 5
        
        if  gold > 0
            gold = gold * (1+GetUnitRealState(Pu[1],41)*0.01)
            AdjustPlayerStateBJ( R2I(gold) ,Player(pid), PLAYER_STATE_RESOURCE_GOLD )
            UnitAddTextPlayer(wu,Player(pid),"+"+I2S(R2I(gold)),255,202,0,255,90,0.023)
        endif
        if  wood > 0
            AdjustPlayerStateBJ( R2I(wood) ,Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
        endif

        if  exp > 0
            HeroAddExp( Pu[1],exp)
        endif


        if  GetUnitIntState(Pu[1],'FB17') > 0
            value = GetUnitIntState(Pu[1],'FC17')
            if  value < 30
                AddUnitRealState(Pu[1],17,1)
                AddUnitIntState(Pu[1],'FC17',1)
            endif
        endif
        if  GetUnitIntState(Pu[1],'FB32') > 0
            value = GetUnitIntState(Pu[1],'FC32')
            if  value < 60000
                AddUnitRealState(Pu[1],2,100)
                AddUnitIntState(Pu[1],'FC32',100)
            endif
        endif
    endfunction

    function CreateNewForg(int id1,int id2)
        int pid = id1
        int uid = id2
        TimerStart(30,false)
        {
            Pu[120]=CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),uid+1,AttackRoomPostion[pid][1] +384,AttackRoomPostion[pid][2]+192,225)
            //LocAddEffect(AttackRoomPostion[pid][1] +384,AttackRoomPostion[pid][2]+192,"effect_az_bw_lina_t1-2.mdl")
            flush locals
        }
        flush locals
    endfunction
    
    function HeroKillMoster(unit wu,unit tu)
        //wu是凶手 tu是死亡单位
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int uid = GetUnitTypeId(tu)
        int value = 0
        
        
        
        if  uid >= 'uE01' and uid <= 'uE99'
            IncEquipKillUnitFunc(wu,tu)
        elseif  uid >= 'u001' and uid <= 'u004'
            if  uid != 'u004'
                CreateNewForg(pid,uid)
            endif
        elseif  uid >= 'uJ00' and uid <= 'uJzz'
            if  uid == 'uJ00'
                AddPlayerImmortalFruit(Pu[1],'IJ01')
            elseif  uid == 'uJ10'
                AddPlayerImmortalFruit(Pu[1],'IJ02')
            elseif  uid == 'uJ20'
                AddPlayerImmortalFruit(Pu[1],'IJ03')
            elseif  uid == 'uJ30'
                AddPlayerImmortalFruit(Pu[1],'IJ04')
            elseif  uid == 'uJ40'
                AddPlayerImmortalFruit(Pu[1],'IJ05')
            elseif  uid == 'uJ50'
                AddPlayerImmortalFruit(Pu[1],'IJ06')
            elseif  uid == 'uJ60'
                AddPlayerImmortalFruit(Pu[1],'IJ07')
            elseif  uid == 'uJ70'
                AddPlayerImmortalFruit(Pu[1],'IJ08')
            elseif  uid == 'uJ80'
                AddPlayerImmortalFruit(Pu[1],'IJ09')
            elseif  uid == 'uJ90'
                AddPlayerImmortalFruit(Pu[1],'IJ10')
            endif
        elseif  uid >= 'u001' and uid <= 'u004'
            AddUnitRealState(Pu[1],41,80)
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
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r进攻怪击杀数量：("+I2S(KillAttackUnitNum)+"50)")
            endif
            if  KillAttackUnitNum >= 50
                KillAttackUnitNum = 0
                AddData(pid,1,2,2)
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]:|r玩家"+ GetPN(pid) +"击杀进攻怪数量达到50！奖励守家积分2点。")
            endif
        endif
        */
        
       
    endfunction
    
    func PlayerHeroKillUnit(unit wu,unit tu)
        int id = 0
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int slv = 0
        int uid = GetUnitTypeId(tu)
        
        //AddUnitIntState(Pu[1],101,1+R2I(GetUnitRealState(wu,70)))
        
        
        //成长类物品
        PlayerItemGrow(pid)
        
        //增加类
        PlayerHeroAddState(pid,uid,tu)


    end
    
    function AttackBossDeathEvent(unit boss)
        AttackBOSSDeathCos = AttackBOSSDeathCos + 1
        BJDebugMsg("AttackBOSSDeathCos "+I2S(AttackBOSSDeathCos)+"@@ AttackBOSSLastCos "+I2S(AttackBOSSLastCos))
        if  AttackBOSSDeathCos == PlayerNum//AttackBOSSLastCos
            AttackBOSSDeathCos = 0
            ShowBossDamageUI(false)
            ShowBossDamageString()
            if  GetUnitTypeId(boss) == 'mb00'+(AttackUnitWNOver/3)
                AttackUnitWin()
            endif
        endif
    endfunction

    function GameOver()
        GameOverBoolJu = true
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffff0000封神榜已经被摧毁！游戏失败!!")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffff0000封神榜已经被摧毁！游戏失败!!")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffff0000封神榜已经被摧毁！游戏失败!!")
        
        TimerStart(5,false)
        {
            for i = 0,5
                CustomDefeatBJ(Player(i), "游戏结束！" )
                
            end
            endtimer
        }
    endfunction

    
    
    function DeathEventFunc()
    
        unit u1 = GetTriggerUnit()
        unit u2 = GetKillingUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int pid2 = GetPlayerId(GetOwningPlayer(u2))
        int uid = GetUnitTypeId(u1)
        int uid2 = GetUnitTypeId(u2)
        if  pid <= 5//玩家类型死亡
            if  IsUnitInGroup(u1,SummonGroup[pid])==true//用于召唤物移出单位组
                SaveInteger(ht,GetHandleId(Pu[1]),GetUnitTypeId(u1),LoadInteger(ht,GetHandleId(Pu[1]),GetUnitTypeId(u1))-1)
                GroupRemoveUnit(SummonGroup[pid],u1)
            endif
            
            if  IsUnitType(u1, UNIT_TYPE_HERO) == true//玩家死亡  复活英雄
                if  u1 == Pu[1]
                    if  SpellS529Spell(u1) == false
                        if  FB47Func(u1) == false
                            RevivePlayerHero(pid)
                            BJDebugMsg("复活准备"+GetUnitName(Pu[1]))
                            GameChallengPlayerDeathEvent(u1)

                            if  GetUnitIntState(Pu[1],'FB17') > 0
                                //清除法宝的伤害加成
                                AddUnitRealState(Pu[1],17,-GetUnitIntState(Pu[1],'FC17'))
                                SetUnitIntState(Pu[1],'FC17',0)
                            endif

                        endif
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
        elseif  u1 == AttackUnitBoss[10] and uid == 'mc06'
            BJDebugMsg("闻太师！！！！")
            AttackOperaBEnding(0)
        endif
        
        if  pid > 7 
            
            RanDropItem.execute(u1,pid2)//非玩家单位死亡，掉落物品
            
            if  u2 != null
                //小怪死亡的资源类结算
                PlayerHeroKillUnit(u2,u1)
                
                //小怪死亡的其他功能
                HeroKillMoster(u2,u1)
                
                //剧情任务等
                GameChallengDeathEvent(u2,u1)

                if  uid >= 'mb01' and uid <= 'mb09'
                    AttackBossDeathEvent(u1)
                endif
            else    
                //BJDebugMsg(GetUnitName(u1)+"死亡时无来源")
            endif
            
            if  GetUnitPointValueByType(uid) <= 20 and GetOwningPlayer(u1) == Player(PLAYER_NEUTRAL_AGGRESSIVE)
                AddReviveWildMonster(u1,GetUnitPointValueByType(uid),GetUnitPointX(u1),GetUnitPointY(u1))
            endif

            if  IsUnitInGroup(u1,AttackUnitGroup)==true//用于进攻怪刷新单位组
                GroupRemoveUnit(AttackUnitGroup,u1)
            endif
            if  IsUnitInGroup(u1,AttackOperaGroup_B_1)==true//用于进攻怪刷新单位组
                GroupRemoveUnit(AttackOperaGroup_B_1,u1)
            endif
       
            if  IsUnitInGroup(u1,AttackOperaGroup_B_2)==true//用于进攻怪刷新单位组
                GroupRemoveUnit(AttackOperaGroup_B_2,u1)
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

