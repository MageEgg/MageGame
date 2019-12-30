
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
        unit u = null
        if  max > 0
            for i = 1,max
                NowReviveUnitTime = NowReviveUnitTime - 1
                if  NowReviveUnitTime == 0
                    u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),NowReviveUnitType,NowReviveUnitX,NowReviveUnitY,GetRandomReal(0,360))

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
    func AddReviveWildMonster(unit wu,int time,real x,real y)
        int max = ReviveUnitMax + 1
        ReviveUnitMax = max
        MaxReviveUnitType = GetUnitTypeId(wu)
        MaxReviveUnitTime = time
        MaxReviveUnitX = x
        MaxReviveUnitY = y
    end
    func RevivePlayerHeroTimer()
        int pid = GetHandleData(GetExpiredTimer())
        BJDebugMsg(I2S(pid)+"fh"+GetUnitName(Pu[1]))
        ReviveHero(Pu[1],10816,12864,true)
        if  Player(pid)==GetLocalPlayer()
            ClearSelection()
            SelectUnit(Pu[1],true)
            PanCameraToTimed(GetUnitX(Pu[1]),GetUnitY(Pu[1]),0)
        endif
        PlayerDeathBool = false
        DestroyTimerDialog(Pdia[0])
        PauseTimer(GetExpiredTimer())
        DestroyTimer(GetExpiredTimer())
    end
    func RevivePlayerHero(int pid)
        timer wt = CreateTimer()
        PlayerDeathBool = true
        SetHandleData(wt,pid)
        Pdia[0] = CreateTimerDialog(wt)
        TimerDialogSetTitle(Pdia[0],GetPN(pid)+GetUnitName(Pu[1])+"复活时间:" )
        TimerDialogDisplay(Pdia[0], true)
        TimerStart(wt,8,false,function RevivePlayerHeroTimer)
        wt = null
    end
    
    func PlayerItemGrowFunc(int pid,item it)
        int id = GetItemTypeId(it)
        int num = GetItemCharges(it)
        
        if  num > 1
            SetItemCharges(it,num-1)
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：恭喜您成功炼化" + GetObjectName(id))
            RemoveItem(it)
            
            
        endif
    end

    
    func PlayerItemWRTFunc(int pid,item it,int exp)
        int id = GetItemTypeId(it)
        int num = GetItemCharges(it)
        
        if  num-exp > 1
            SetItemCharges(it,num-exp)
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：恭喜您成功将" + GetObjectName(id) + "晋升为" + GetObjectName(id+1))
            RemoveItem(it)
            UnitAddItem(Pu[1],CreateItem(id+1,0,0))
            
        endif
    end

    
    func PlayerItemGrow(int pid)
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
                    
    end
    
   func PlayerHeroAddState(int pid,int uid,unit wu)
        int index = 0
        int value = 0
        real gold = 0
        real wood = 0
        real jq = 0
        real zq = 0
        int exp = 0
        
        if  uid >= 'g001' and uid <= 'g023'
            if  uid == 'g001'
                gold = 50
            elseif  uid == 'g002'
                gold = 300
            elseif  uid == 'g003'
                gold = 1000
            elseif  uid == 'g004'
                wood = 1
            elseif  uid == 'g005'
                wood = 5
            elseif  uid == 'g006'
                wood = 15
            elseif  uid == 'g007'
                wood = 30
            elseif  uid == 'g008'
                wood = 50
            elseif  uid == 'g009'
                jq = 20
            elseif  uid == 'g010'
                jq = 40
            endif
        endif
        
        
        exp = GetHeroLevel(Pu[1])*10
        
        
        if  gold > 0
            gold = gold * (1+GetUnitRealState(Pu[1],66)*0.01)
            AdjustPlayerStateBJ( R2I(gold) ,Player(pid), PLAYER_STATE_RESOURCE_GOLD )
            UnitAddTextPlayer(wu,Player(pid),"+"+I2S(R2I(gold)),255,202,0,255,90,0.023)
        endif
        if  wood > 0
            wood = wood * (1+GetUnitRealState(Pu[1],67)*0.01)
            AdjustPlayerStateBJ( R2I(wood) ,Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
            UnitAddTextPlayer(wu,Player(pid),"+"+I2S(R2I(wood)),0x66,0xCD,0x00,255,90,0.023)
        endif
        
        if  jq > 0
            jq = jq * (1+GetUnitRealState(Pu[1],69)*0.01)
            AddUnitIntState(Pu[1],102,R2I(jq))
            UnitAddTextPlayer(wu,Player(pid),"+"+I2S(R2I(jq)),100,100,255,255,90,0.023)
        endif
        
        
        jq = GetUnitRealState(Pu[1],36)
        if  jq > 0
            AddUnitIntState(Pu[1],102,R2I(jq))
            UnitAddTextPlayer(wu,Player(pid),"+"+I2S(R2I(jq)),100,100,255,255,115,0.023)
        endif
        
        wood = GetUnitRealState(Pu[1],37)
        if  wood > 0
            AdjustPlayerStateBJ( R2I(wood) ,Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
            UnitAddTextPlayer(wu,Player(pid),"+"+I2S(R2I(wood)),0x66,0xCD,0x00,255,65,0.023)
        endif
        
        
        zq = GetUnitRealState(Pu[1],48)
        if  zq > 0
            AddUnitRealState(Pu[1],39,zq)
        endif
        
        
        if  exp > 0
            AddHeroXP(Pu[1],exp,true)//额外经验
        endif
        
        for i = 1,5
            value = R2I(GetUnitRealState(Pu[1],30+i))
            if  value > 0
                if  i >= 1 and i <= 4
                    AddUnitRealState(Pu[1],i,value)
                elseif  i == 5
                    AddUnitRealState(Pu[1],7,value)
                endif
            endif
        end
        

        
    end
    
   
    
  
   
    
    

    
  
    
    
    
    
    func KillBossFunc(int index)
        
        real min = 0
        int hat = 0
        real ch = 0
        int b = 1
        int maxpid = -1
        int num = 0
        for n = 1,6
            min = 0
            hat = -1
            for pid = 0,3
                ch = GetUnitRealState(Pu[1],99)
                if  ch > min and ch > 0
                    hat = pid
                    min = ch
                endif
            end
            if  hat != -1
                if  maxpid == -1
                    maxpid = hat
                endif
                SetUnitRealState(PlayerUnit[hat][1],99,0)
                if  b == 1
                    num = index * 8 
                elseif  b == 2
                    num = index * 6
                elseif  b == 3
                    num = index * 4
                elseif  b == 4
                    num = index * 2
                endif
                
                num = R2I(I2R(num) * GetRandomReal(0.8,1.2) * (1 + I2R(GameLevel) * 0.1))
                if  num <= 0
                    num = 1
                endif
                
                AddUnitRealState( PlayerUnit[hat][1] ,31,num)
                
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[BOSS伤害排行]:|r第"+I2S(b)+"名 "+ GetPN(hat) +" 伤害值:"+R2S1(min)+" 奖励杀敌属性+"+I2S(num))
                b = b + 1
            endif
        end
    end
    
    
    
    
    
    function HeroKillMoster(unit wu,unit tu)
        //wu是凶手 tu是死亡单位
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int uid = GetUnitTypeId(tu)
        int value = 0
        
        
        
        if  uid >= 'uE01' and uid <= 'uE99'
            IncEquipKillUnitFunc(wu,tu)
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
        
        AddUnitIntState(Pu[1],101,1+R2I(GetUnitRealState(wu,70)))
        
        
        //成长类物品
        PlayerItemGrow(pid)
        
        //增加类
        PlayerHeroAddState(pid,uid,tu)


    end
    
    function EndGameTimerTimerFunc()
    endfunction

    function GameOverToast()
        
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
            if  IsUnitType(u1, UNIT_TYPE_HERO) == true//玩家死亡  复活英雄
                if  u1 == Pu[1]
                    RevivePlayerHero(pid)
                    BJDebugMsg("复活准备"+GetUnitName(Pu[1]))
                endif
            endif
        endif
        /*
        if  u1 == gg_unit_np01_0001
            GameOverToast()
        endif
        */
        
        if  pid > 7 
            
            RanDropItem.execute(u1,pid2)//非玩家单位死亡，掉落物品
            
            if  u2 != null
                //小怪死亡的资源类结算
                PlayerHeroKillUnit(u2,u1)
                
                //小怪死亡的其他功能
                HeroKillMoster(u2,u1)
                
                if  uid >= 'mb01' and uid <= 'mb09'
                    /*BossNum = BossNum - 1
                    if  BossNum <= 0
                        
                        
                        if  uid == 'mb08'
                            GameWin()
                        else
                            KillBossFunc(uid - 'mb00')
                        endif
                    endif*/
                endif
                
                if  uid >= 'm000' and uid <= 'mzzz'//野怪复活
                    
                    if  GetUnitPointValueByType(uid) == 1
                        AddReviveWildMonster(u1,3,GetUnitPointX(u1),GetUnitPointY(u1))
                    endif
                endif
            else    
                //BJDebugMsg(GetUnitName(u1)+"死亡时无来源")
            endif
            

            
            //if  IsUnitInGroup(u1,AttackUnitGroup)==true//用于进攻怪刷新单位组
                
            //    GroupRemoveUnit(AttackUnitGroup,u1)
            //4endif
            
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
