
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
            SendPlayerUnit(pid,PlayerReviveX,PlayerReviveY)
            AddUnitStateExTimer(Pu[1],11,100,2)
            PlayerDeathBool = false
        endif
        DestroyTimerDialog(Pdia[0])
        PauseTimer(GetExpiredTimer())
        DestroyTimer(GetExpiredTimer())
    endfunction




    function RevivePlayerHero(int pid)
        timer wt = CreateTimer()
        PlayerDeathBool = true
        PetDeathPosition(pid)
        SetHandleData(wt,pid)
        Pdia[0] = CreateTimerDialog(wt)
        TimerDialogSetTitle(Pdia[0],GetPN(pid)+GetUnitName(Pu[1])+"复活时间:" )
        TimerDialogDisplay(Pdia[0], true)
        TimerStart(wt,8,false,function RevivePlayerHeroTimer)
        wt = null
    endfunction
    
    

    
    

    


    function PlayerUseGoldBox(int pid,int itemid)
        //使用聚宝盆
        int gold = 0
        int i1 = 0
        if  itemid == 'I011'
            gold = GetRandomInt(7000,12000)
            i1 = GetRandomInt(2000,5000)
            
        elseif  itemid == 'I012'
            gold = GetRandomInt(8000,13000)
            i1 = GetRandomInt(3000,6000)
        elseif  itemid == 'I013'
            gold = GetRandomInt(9000,14000)
            i1 = GetRandomInt(4000,7000)
        elseif  itemid == 'I014'
            gold = GetRandomInt(10000,15000)
            i1 = GetRandomInt(5000,8000)
        elseif  itemid == 'I014'
            gold = GetRandomInt(12000,17000)
            i1 = GetRandomInt(6000,9000)
        endif
        AddUnitRealState(Pu[1],2,i1)
        AdjustPlayerStateBJ( gold , Player(pid), PLAYER_STATE_RESOURCE_GOLD )
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r使用聚宝盆金币+"+I2S(gold)+" 业力+"+I2S(i1))

    endfunction

    function PlayerItemGrowFunc(int pid,item it,int exp)->bool
        int id = GetItemTypeId(it)
        int num = GetItemCharges(it)
        
        if  num - exp > 1
            SetItemCharges(it,num+-exp)
            return false
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：恭喜您成功炼化" + GetObjectName(id))
            RemoveItem(it)
            return true
        endif
    endfunction

    function PlayerItemIncFunc(int pid,item it,int exp)
        int id = GetItemTypeId(it)
        int num = GetItemCharges(it)
        int next = GetTypeIdData(id,106)
        int gl = 50

        if  GetPlayerTechCount(Player(pid),'RJ1U',true) > 0
            gl = 100
        else
            if  next == 'E102' or next == 'E103'
                gl = 100
            elseif  next >= 'E103' and next <= 'E106'
                gl = 80
            endif
        endif
        if  num-exp > 1
            SetItemCharges(it,num-exp)
        else
            RemoveItem(it)
            if  GetRandomInt(1,100)<= gl
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：恭喜您成功将" + GetObjectName(id) + "晋升为" + GetObjectName(next))
                UnitAddItem(Pu[1],CreateItem(next,GetUnitX(Pu[1]),GetUnitY(Pu[1])))
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffff0000[系统]：很遗憾" + GetObjectName(id) + "升级失败！")
                UnitAddItem(Pu[1],CreateItem(id,GetUnitX(Pu[1]),GetUnitY(Pu[1])))
            endif
        endif
    endfunction

    function PlayerItemGrow(int pid)
        int next = 0
        int id = 0
        int lv = 0
        for i1 = 0,5
            id = GetItemTypeId(UnitItemInSlot(Pu[1],i1))
            if  id >= 'I011' and id <= 'I015'
                if  PlayerItemGrowFunc(pid,UnitItemInSlot(Pu[1],i1),1) == true
                    PlayerUseGoldBox(pid,id)
                endif
                exitwhen true
            endif
        end
        for i2 = 0,5
            id = GetItemTypeId(UnitItemInSlot(Pu[1],i2))
            if  id >= 'E101' and id <= 'E124'
                PlayerItemIncFunc(pid,UnitItemInSlot(Pu[1],i2),1)
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
        AddUnitIntState(Pu[1],110,1)
        

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

        
        
        
        //杀敌金币
        
        if  gold > 0
            gold = gold * (1+GetUnitRealState(Pu[1],41)*0.01)+0.001

            gold = gold + GetUnitRealState(Pu[1],46)

            AdjustPlayerStateBJ( R2I(gold) ,Player(pid), PLAYER_STATE_RESOURCE_GOLD )
            UnitAddTextPlayer(wu,Player(pid),"+"+I2S(R2I(gold+0.0001)),255,202,0,255,90,0.023)
        endif
        //杀敌经验
        exp = 1
        if  exp > 0
            HeroAddExp( Pu[1],exp)
        endif


        if  GetUnitIntState(Pu[1],'FB17') > 0
            value = GetUnitIntState(Pu[1],'FC17')
            if  value < 400
                AddUnitRealState(Pu[1],17,0.1)
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
        if  GetUnitIntState(Pu[1],'FB03') > 0
            value = GetUnitIntState(Pu[1],'FC03')
            if  value < 60000
                AddUnitRealState(Pu[1],1,100)
                AddUnitIntState(Pu[1],'FC03',100)
            endif
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

    function CreateNewForg(int id1,int id2)
        int pid = id1
        int uid = id2
        TimerStart(30,false)
        {
            Pu[120]=CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),uid+1,AttackRoomPostion[pid][1] +256,AttackRoomPostion[pid][2]+512,225)
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
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r送宝金蟾逃跑啦！10秒后再来吧！")
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

    function ForgKillTimer(unit wu)
        unit u1 = wu
        int id = GetUnitTypeId(u1)
        SetUnitOwner(u1,Player(PLAYER_NEUTRAL_AGGRESSIVE),false)
        TimerStart(20,false)
        {
            int pid = GetUnitAbilityLevel(u1,'AZ99')

            if  pid > 0
                if  GetUnitTypeId(u1) == id
                    if  GetUnitState(u1,UNIT_STATE_LIFE) > 0
                        pid = pid - 1
                        ForgEscapeTimer(pid,u1)
                        if  Pu[6] == u1
                            Pu[6] = null
                        endif
                    endif
                endif
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    
    

    //星辰阵
    function KillXCUnitFunc(unit wu,unit tu,int uid)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int num = AttackRoomXCUnitNum
        KillXCUnitNum = KillXCUnitNum + 1
        AttackRoomXCUnitNum = AttackRoomXCUnitNum - 1
        if  uid == 'u0DF' or uid == 'u0DL' or uid == 'u0DR' or uid == 'u0DX'
            
            if  AttackRoomXCNum > 24
                AttackRoomXCNum = 1
            endif
            CreateItem(uid-'u0DA'+'INDA',GetUnitX(tu),GetUnitY(tu))
            AdjustPlayerStateBJ( 20 ,Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r"+GetObjectName(uid)+"挑战成功！奖励炽星魔盒*1 玄铁+20")
            /*
            if  uid == 'u0DF'
                SetPlayerTechResearched(Player(pid),'AM40',1)
                AddUnitRealState(Pu[1],9,25)
                CreateItem(uid-'u0DA'+'INDA',GetUnitX(tu),GetUnitY(tu))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r"+GetObjectName(uid)+"挑战成功！奖励攻速+25% 炽星魔盒*1")
            elseif  uid == 'u0DL'
                SetPlayerTechResearched(Player(pid),'AM40',1)
                AddUnitRealState(Pu[1],9,35)
                CreateItem(uid-'u0DA'+'INDA',GetUnitX(tu),GetUnitY(tu))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r"+GetObjectName(uid)+"挑战成功！奖励攻速+35% 炽星魔盒*1")
            elseif  uid == 'u0DR'
                SetPlayerTechResearched(Player(pid),'AM40',1)
                AddUnitRealState(Pu[1],9,45)
                CreateItem(uid-'u0DA'+'INDA',GetUnitX(tu),GetUnitY(tu))
                CreateItem(uid-'u0DA'+'INDA',GetUnitX(tu),GetUnitY(tu))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r"+GetObjectName(uid)+"挑战成功！奖励攻速+45% 炽星魔盒*2")
            elseif  uid == 'u0DX'
                SetPlayerTechResearched(Player(pid),'AM40',1)
                AddUnitRealState(Pu[1],9,55)
                CreateItem(uid-'u0DA'+'INDA',GetUnitX(tu),GetUnitY(tu))
                CreateItem(uid-'u0DA'+'INDA',GetUnitX(tu),GetUnitY(tu))
                CreateItem(uid-'u0DA'+'INDA',GetUnitX(tu),GetUnitY(tu))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r"+GetObjectName(uid)+"挑战成功！奖励攻速+55% 炽星魔盒*3")
            endif
            */
            
        else
            AttackRoomXCNum = AttackRoomXCNum + 1
            if  AttackRoomXCNum == 10
                AttackRoomXCNum = 0
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r星宿之灵(10/10)")
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r星宿之灵("+I2S(AttackRoomXCNum)+"/10)")
            endif

            if  AttackRoomXCUnitNum <= 0

                if  AttackRoomXCNum > 24
                    AttackRoomXCNum = 1
                endif
                CreateItem(uid-'u0DA'+'INDA',GetUnitX(tu),GetUnitY(tu))
                AdjustPlayerStateBJ( 10 ,Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r"+GetObjectName(uid)+"挑战成功！奖励幸运星盒*1 玄铁+10")
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
        
        
        if  uid >= 'uE01' and uid <= 'uE99'
            IncEquipKillUnitFunc(wu,tu)
        elseif  uid == 'u020'
            //妖媚数量
            KillYMUnitNum = KillYMUnitNum + 1
        elseif  uid >= 'u0DA' and uid <= 'u0DZ'
            KillXCUnitFunc(wu,tu,uid)
        elseif  uid >= 'u001' and uid <= 'u004'
            AttackRoomUid[pid]='g00A'+ (uid - 'u000')
            //AddUnitRealState(Pu[1],41,80)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r送宝金蟾挑战成功！练功房内资源怪提升！")
            if  uid == 'u001'//占星NPC
                Pu[28]=CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np03',x+512,y+256,270)
                UnitAddEffectOfNPC(Pu[28])
            endif
            if  uid != 'u004'
                CreateNewForg(pid,uid)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r金蟾它老豆生气了！30秒来找你报仇！")
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r金蟾家族一个不剩了......")
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
        int bossnum = 0
        int bossid = 0
        AttackBOSSDeathCos = AttackBOSSDeathCos + 1
        BJDebugMsg("AttackBOSSDeathCos "+I2S(AttackBOSSDeathCos)+"@@ AttackBOSSLastCos "+I2S(AttackBOSSLastCos))
        if  AttackBOSSDeathCos == PlayerNum//AttackBOSSLastCos
            AttackBOSSDeathCos = 0
            ShowBossDamageUI(false)
            ShowBossDamageString()
            bossnum = (AttackUnitWNOver/3)
            if  bossnum < 10
                bossid = 'mb00'+ bossnum
            else
                bossid = 'mb10'
            endif
            if  GetUnitTypeId(boss) == bossid
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
                        if  FB01Func(u1) == false
                            RevivePlayerHero(pid)
                            BJDebugMsg("复活准备"+GetUnitName(Pu[1]))
                            GameChallengPlayerDeathEvent(u1)

                            if  GetUnitIntState(Pu[1],'FB17') > 0
                                //清除法宝的伤害加成
                                AddUnitRealState(Pu[1],17,-I2R(GetUnitIntState(Pu[1],'FC17'))*0.1)
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
            AttackOperaBEnding(1)
        endif
        if  u1 == PlayerUnit[pid2][6]
            PlayerUnit[pid2][6] = null
        endif
        //剧情任务等
        GameChallengDeathEvent(u2,u1)

        if  pid > 3
            RanDropItem.execute(u1,pid2)//非玩家单位死亡，掉落物品
        
        
            if  IsPlayerAlly(GetOwningPlayer(u1),GetOwningPlayer(u2))==false
                
                if  u2 != null
                    //小怪死亡的资源类结算
                    PlayerHeroKillUnit(u2,u1)
                    //小怪死亡的其他功能
                    HeroKillMoster(u2,u1)
                    if  uid >= 'mb01' and uid <= 'mb20'
                        AttackBossDeathEvent(u1)
                    endif
                else
                    KillUnitNotHasKiller(u1,uid)
                
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

