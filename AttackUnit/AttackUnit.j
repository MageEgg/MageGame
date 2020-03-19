library AttackUnit uses DamageCode,PassCheckMission
    
    group AttackUnitGroup = CreateGroup()
    unit array AttackUnitBoss
    int array AttackUnitInt[60][300]
    real array AttackUnitReal[60][300]
    bool array AttackUnitBool
    string AttackTimerUIText
    timer array AttackArrayTimer
    
    int AttackBOSSLastCos = 0
    int AttackBOSSDeathCos = 0
    
    #define AttackUnitOperaBoss         AttackUnitBoss[10]    //剧情BOSS
    
    #define AttackUnitOrderNum          AttackUnitInt[0][1]     //序号
    #define AttackUnitWN                AttackUnitInt[0][2]     //波数
    #define AttackUnitWNOver            AttackUnitInt[0][3]     //最终波数
    #define AttackUnitTXWN              AttackUnitInt[0][3]     //偷袭波数
    #define AttackUnitStopNum           AttackUnitInt[0][4]     //停怪次数
    #define LastAttackBossId            AttackUnitInt[0][5]     //最终BOSS
    
    #define AttackUnitWNBoss            AttackUnitInt[0][10]    //Boss次数
    
    #define AttackUnitArray             AttackUnitInt[1]        //序号
    #define AttackUnitRoad              AttackUnitInt[2]        //进攻线路
    #define AttackUnitType              AttackUnitInt[3]        //进攻类型

    #define AttackUnitID(num)           AttackUnitInt[10+num]   //单位id
    
    #define AttackUnitNum(num)          AttackUnitInt[20+num]   //单位数量

    #define AttackUnitFlushNum(num)     AttackUnitInt[30+num]   //单位生成次数
    
    #define StopAttackTime              AttackUnitReal[0][0]    //停怪时间
    
    #define AttackUnitNextTime          AttackUnitReal[1]       //下一波时间
    
    #define AttackUnitIntervalTime(num) AttackUnitReal[10+num]  //刷新间隔

    #define AttackUnitStartX(num)       AttackUnitReal[20+num]  //开始X
    #define AttackUnitStartY(num)       AttackUnitReal[30+num]  //开始Y
    
    #define AttackUnitEndX(num)         AttackUnitReal[40+num]  //目标X
    #define AttackUnitEndY(num)         AttackUnitReal[50+num]  //目标X
    
    #define StopAttackBool              AttackUnitBool[0]       //停怪
    #define CrazyAttackBool             AttackUnitBool[1]       //疯狂
    #define AttackGroupNumBool          AttackUnitBool[2]       //单位组数量
    #define InfiniteAttackBool          AttackUnitBool[5]       //无尽
    
    #define AttackUnitWinBool           AttackUnitBool[20]      //胜利

    #define IsChangeGodStage            AttackUnitBool[30]       //封神台
    #define IsGameOperaA                AttackUnitBool[31]       //剧情bool
    #define IsGameOperaB                AttackUnitBool[32]       //剧情bool
    #define IsGameOperaC                AttackUnitBool[33]       //剧情bool

    #define AttackTimer                 AttackArrayTimer[0]
    #define AttackElseTimer             AttackArrayTimer[1]
    #define CreateAttackUnitTimer       AttackArrayTimer[2]
    #define CreateAttackBossTimer       AttackArrayTimer[3]
    #define OperaTimer                  AttackArrayTimer[4]
    
    private int array puid
    private real array psx
    private real array psy
    private real array pex
    private real array pey
    
    function ReflushAttackTimerUI()
        int cos = 0
        if  AttackTimer != null
            if  InfiniteAttackBool == false
                if  AttackUnitWN == 0
                    if  StopAttackBool == true
                        if  TimerGetRemaining(AttackElseTimer) > 0
                            AttackTimerTextUI.SetText("|cffffe100暂停进攻|r")
                            AttackTimerTextExUI.SetText("|cffffe100"+I2S(R2I(TimerGetRemaining(AttackElseTimer)))+"秒|r")
                        else
                            AttackTimerTextUI.SetText("|cffffcc00"+AttackTimerUIText+"|r")
                            AttackTimerTextExUI.SetText("")
                        endif
                    else 
                        if  TimerGetRemaining(AttackTimer) > 0
                            if  TimerGetRemaining(AttackTimer) < 11
                                AttackTimerTextUI.SetText("|cffff0000"+AttackTimerUIText+"|r")
                                AttackTimerTextExUI.SetText("|cffff0000"+I2S(R2I(TimerGetRemaining(AttackTimer)))+"秒|r")
                            else
                                AttackTimerTextUI.SetText("|cff00ff00"+AttackTimerUIText+"|r")
                                AttackTimerTextExUI.SetText("|cff00ff00"+I2S(R2I(TimerGetRemaining(AttackTimer)))+"秒|r")
                            endif
                        else
                            AttackTimerTextUI.SetText("|cffffcc00"+AttackTimerUIText+"|r")
                            AttackTimerTextExUI.SetText("")
                        endif
                    endif
                else
                    if  StopAttackBool == true
                        if  TimerGetRemaining(AttackElseTimer) > 0
                            AttackTimerTextUI.SetText("|cffffe100暂停进攻|r")
                            AttackTimerTextExUI.SetText("|cffffe100"+I2S(R2I(TimerGetRemaining(AttackElseTimer)))+"秒|r")
                        else
                            AttackTimerTextUI.SetText("|cffffcc00"+AttackTimerUIText+"|r")
                            AttackTimerTextExUI.SetText("")
                        endif
                    else
                        if  TimerGetRemaining(AttackTimer) > 0
                            if  TimerGetRemaining(AttackTimer) < 11
                                AttackTimerTextUI.SetText("|cffff0000"+AttackTimerUIText+"|r")
                                AttackTimerTextExUI.SetText("|cffff0000"+I2S(R2I(TimerGetRemaining(AttackTimer)))+"秒|r")
                            else
                                AttackTimerTextUI.SetText("|cff00ff00"+AttackTimerUIText+"|r")
                                AttackTimerTextExUI.SetText("|cff00ff00"+I2S(R2I(TimerGetRemaining(AttackTimer)))+"秒|r")
                            endif
                        else
                            AttackTimerTextUI.SetText("|cffffcc00"+AttackTimerUIText+"|r")
                            AttackTimerTextExUI.SetText("")
                        endif
                    endif
                endif
            endif
        else
            AttackTimerTextUI.SetText("|cffffcc00"+AttackTimerUIText+"|r")
            AttackTimerTextExUI.SetText("")
        endif
    endfunction
    
    function OpenAttackTimerUI(int time)
        AttackTimerUIText = "进攻波 1/"+I2S(AttackUnitWNOver)
        AttackTimerTextUI.SetText("|cff00ff00"+AttackTimerUIText+"|r")
        AttackTimerTextExUI.SetText("|cffffcc00"+I2S(time)+"秒")
        ShowAttackTimerUI(true)
    endfunction
    
    //序号 进攻类型（事件） 下一波时间 创建数量 创建次数 刷新时间 进攻坐标 单位id 1-4 创建坐标1-4
    function InitAttackUnitData(int num,int attt,real nexttime,int attacknum,int flushnum,real flushtime,real ex,real ey,int uid0,int uid1,int uid2,int uid3,real sx0,real sy0,real sx1,real sy1,real sx2,real sy2,real sx3,real sy3)                                 
        if  num > 0
            AttackUnitArray[num] = num
            AttackUnitType[num] = attt
            
            AttackUnitNextTime[num] = nexttime
            AttackUnitNum(0)[num] = attacknum
            AttackUnitFlushNum(0)[num] = flushnum
            AttackUnitIntervalTime(0)[num] = flushtime
            
            AttackUnitID(0)[num] = uid0
            AttackUnitID(1)[num] = uid1
            AttackUnitID(2)[num] = uid2
            AttackUnitID(3)[num] = uid3
            
            AttackUnitStartX(0)[num] = sx0
            AttackUnitStartY(0)[num] = sy0
            AttackUnitStartX(1)[num] = sx1
            AttackUnitStartY(1)[num] = sy1
            AttackUnitStartX(2)[num] = sx2
            AttackUnitStartY(2)[num] = sy2
            AttackUnitStartX(3)[num] = sx3
            AttackUnitStartY(3)[num] = sy3
            
            AttackUnitEndX(0)[num] = ex
            AttackUnitEndY(0)[num] = ey
            AttackUnitEndX(1)[num] = ex
            AttackUnitEndY(1)[num] = ey
            AttackUnitEndX(2)[num] = ex
            AttackUnitEndY(2)[num] = ey
            AttackUnitEndX(3)[num] = ex
            AttackUnitEndY(3)[num] = ey
        endif
    endfunction
    
    function InitAttackUnitOfLevel()
        InitAttackUnitData(1,0,120,2,30,0.6,-6910,-6912,'m001','m001','m001','m001',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(2,0,120,2,30,0.6,-6910,-6912,'m002','m002','m002','m002',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(3,0,120,2,30,0.6,-6910,-6912,'m003','m003','m003','m003',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(4,0,120,2,30,0.6,-6910,-6912,'m004','m004','m004','m004',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(5,0,120,2,30,0.6,-6910,-6912,'m005','m005','m005','m005',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(6,0,120,2,30,0.6,-6910,-6912,'m006','m006','m006','m006',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(7,0,120,2,30,0.6,-6910,-6912,'m007','m007','m007','m007',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(8,0,120,2,30,0.6,-6910,-6912,'m008','m008','m008','m008',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(9,0,120,2,30,0.6,-6910,-6912,'m009','m009','m009','m009',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(10,0,120,2,30,0.6,-6910,-6912,'m010','m010','m010','m010',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(11,0,120,2,30,0.6,-6910,-6912,'m011','m011','m011','m011',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(12,0,120,2,30,0.6,-6910,-6912,'m012','m012','m012','m012',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(13,0,120,2,30,0.6,-6910,-6912,'m013','m013','m013','m013',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(14,0,120,2,30,0.6,-6910,-6912,'m014','m014','m014','m014',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(15,0,120,2,30,0.6,-6910,-6912,'m015','m015','m015','m015',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(16,0,120,2,30,0.6,-6910,-6912,'m016','m016','m016','m016',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(17,0,120,2,30,0.6,-6910,-6912,'m017','m017','m017','m017',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(18,0,180,2,30,0.6,-6910,-6912,'m018','m018','m018','m018',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(19,0,15,3,25,0.6,-1664,-7440,'m019','m019','m019','m019',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
        InitAttackUnitData(20,0,15,3,25,0.6,-1664,-7440,'m020','m020','m020','m020',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
        InitAttackUnitData(21,0,0,3,200,0.6,-1664,-7440,'m021','m021','m021','m021',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
        InitAttackUnitData(22,0,15,3,25,0.6,-1664,-7440,'m022','m022','m022','m022',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
        InitAttackUnitData(23,0,15,3,25,0.6,-1664,-7440,'m023','m023','m023','m023',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
        InitAttackUnitData(24,0,0,3,200,0.6,-1664,-7440,'m024','m024','m024','m024',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)

        InitAttackUnitData(101,0,0,1,1,1,-6910,-6912,'mb01','mb01','mb01','mb01',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(102,0,0,1,1,1,-6910,-6912,'mb02','mb02','mb02','mb02',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(103,0,0,1,1,1,-6910,-6912,'mb03','mb03','mb03','mb03',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(104,0,0,1,1,1,-6910,-6912,'mb04','mb04','mb04','mb04',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(105,0,0,1,1,1,-6910,-6912,'mb05','mb05','mb05','mb05',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(106,0,0,1,1,1,-6910,-6912,'mb06','mb06','mb06','mb06',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
        InitAttackUnitData(107,0,0,1,1,1,-1664,-7440,'mb07','mb07','mb07','mb07',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
        InitAttackUnitData(108,0,0,1,1,1,-1664,-7440,'mb08','mb08','mb08','mb08',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
    endfunction
    
    function InitAttackUnitOfLevelEx(int lv)
        ExecuteFunc("InitGameChallengeLeagueUnit")
        if  lv > 1
            InitAttackUnitData(18,0,120,2,30,0.6,-6910,-6912,'m018','m018','m018','m018',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
            InitAttackUnitData(19,0,120,3,30,0.6,-6910,-6912,'m019','m019','m019','m019',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
            InitAttackUnitData(20,0,120,3,30,0.6,-6910,-6912,'m020','m020','m020','m020',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
            InitAttackUnitData(21,0,180,3,30,0.6,-6910,-6912,'m021','m021','m021','m021',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
            InitAttackUnitData(22,0,15,3,25,0.6,-1664,-7440,'m022','m022','m022','m022',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
            InitAttackUnitData(23,0,15,3,25,0.6,-1664,-7440,'m023','m023','m023','m023',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
            InitAttackUnitData(24,0,0,3,200,0.6,-1664,-7440,'m024','m024','m024','m024',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)

            InitAttackUnitData(107,0,0,1,1,1,-6910,-6912,'mb07','mb07','mb07','mb07',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
            InitAttackUnitData(108,0,0,1,1,1,-1664,-7440,'mb08','mb08','mb08','mb08',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
        endif
        ExecuteFunc("InitAttackUnitChallengeState")
    endfunction
    
    function InitAttackUnit()
        real sx0 = 0
        real sy0 = 0
        real sx1 = 0
        real sy1 = 0
        real sx2 = 0
        real sy2 = 0
        real sx3 = 0
        real sy3 = 0
        real ex = 0
        real ey = 0
        AttackUnitWN = 0
        AttackUnitWNBoss = 0
        AttackBOSSLastCos = 1
        if  GameLevel > 1
            AttackUnitWNOver = 24  //最终波
            LastAttackBossId = 'mb08'
        else
            AttackUnitWNOver = 21  //最终波
            LastAttackBossId = 'mb07'
        endif
        
        //序号 进攻类型（事件） 下一波时间 创建数量 创建次数 刷新时间 进攻坐标 单位id 1-4 创建坐标1-4
        InitAttackUnitOfLevel()
        InitAttackUnitOfLevelEx(GameLevel)
        
        BJDebugMsg("InitAttackUnit")
    endfunction
    
    function AttackUnitGroupFunc()
        if  GetUnitCurrentOrder(GetEnumUnit()) == 0
            IssuePointOrderById(GetEnumUnit(),851983,GetUnitX(GameDefendUnit),GetUnitY(GameDefendUnit))
        endif
    endfunction
    
    function AttackUnitGroupTimer()
        ForGroup(AttackUnitGroup,function AttackUnitGroupFunc)
    endfunction

    function AddBossAttachUnitState(unit u,int id)
        int uid = 'ma11'+id-'mb01'
        SetUnitRealStateOfOtherId(u,uid)
    endfunction
    
    function CreateBossAttachUnitFunc(unit wu,real ex,real ey)
        real x = GetUnitX(wu)
        real y = GetUnitY(wu)
        real sx = 0
        real sy = 0 
        unit u = null
        for num = 1,4
            sx = x + 20*Cos((90*num+45)*0.01745)
            sy = y + 20*Sin((90*num+45)*0.01745)
            u = CreateUnit(Player(11),'ma01'+GetRandomInt(0,8),ex,ey,GetUnitFacing(wu))
            AddBossAttachUnitState(u,GetUnitTypeId(wu))
            SetUnitXY(u,sx,sy)
            IssuePointOrderById(u,851983,ex,ey)
            GroupAddUnit(AttackUnitGroup,u)
        end
        BJDebugMsg("CreateBossAttachUnit")
        u = null
    endfunction
 
    function CreateBossAttachUnit(unit wu,real x,real y,real time)
        unit u = wu
        real ex = x
        real ey = y
        TimerStart(time,false)
        {
            CreateBossAttachUnitFunc(u,ex,ey)
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function AddBossAnger(unit wu)
        unit u = wu
        int time = 0
        int nuqi = 0
        TimerStart(1,true)
        {
            time = time + 1
            if  time <= 90 and GetUnitTypeId(u) != 0 and u != null
                if  ModuloInteger(time,10) == 0
                    nuqi = nuqi + 1
                    if  GetUnitAbilityLevel(u,'AZ80'+nuqi-1) > 0
                        UnitRemoveAbility(u,'AZ80'+nuqi-1)
                    endif
                    AddUnitRealState(u,9,10)
                    AddUnitRealState(u,9,1.7)
                    UnitAddAbility(u,'AZ80'+nuqi)
                endif
                if  time == 90
                    UnitAddAbility(u,'AZ80')
                    AddUnitRealState(u,1,GetUnitRealState(u,1))
                endif
            else
                BJDebugMsg("end计时器")
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenCreateBossTimer()
        timer t = GetExpiredTimer()
        int FlushNum = LoadInteger(ht,GetHandleId(t),1)
        int ordernum = LoadInteger(ht,GetHandleId(t),2)
        int num = LoadInteger(ht,GetHandleId(t),3)
        int unitnum = AttackUnitNum(0)[ordernum]
        unit u = null
        int bossnum = 0
        int bossid = 0
        bossnum = (AttackUnitWNOver/3)
        if  bossnum < 10
            bossid = 'mb00'+ bossnum
        else
            bossid = 'mb10'
        endif
        if  FlushNum > 0
            for k = 0,3
                if  IsPlaying(k) == true
                    puid[k] = AttackUnitID(k)[ordernum]
                    psx[k] = AttackUnitStartX(k)[ordernum]
                    psy[k] = AttackUnitStartY(k)[ordernum]
                    pex[k] = AttackUnitEndX(k)[ordernum]
                    pey[k] = AttackUnitEndY(k)[ordernum]
                    if  puid[k] != 0
                        for j = 1,unitnum
                            u = CreateUnit(Player(11),puid[k],pex[k],pey[k],0)
                            UnitAddAbility(u,'AZ01')
                            SetUnitXY(u,psx[k],psy[k])
                            PingMinimap(psx[k],psy[k],5)
                            IssueImmediateOrderById(u,852076)
                            IssuePointOrderById(u,851983,pex[k],pey[k])
                            GroupAddUnit(AttackUnitGroup,u)
                            CreateBossAttachUnit(u,pex[k],pey[k],0.1)
                            if  puid[k] == bossid
                                AddBossAnger(u)
                            endif
                        end
                    endif
                endif
            end
            if  num == FlushNum
                //DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|cffff0000BOSS进攻！！！|r")
                //DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|cffff0000BOSS进攻！！！|r")
                //DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[系统]：|cffff0000BOSS进攻！！！|r")
            endif
            if  FlushNum == 1
                ExecuteFunc("ClearDamageRanking")
                ShowBossDamageUI.execute(true)
            endif
            FlushNum = FlushNum - 1
            SaveInteger(ht,GetHandleId(t),1,FlushNum)
        else
            FlushChildHashtable(ht,GetHandleId(t))
            DestroyTimer(t)
            CreateAttackBossTimer = null
        endif
        t = null
        u = null
    endfunction
    
    function CreateBossTimerFunc(int ordernum)
        real time = AttackUnitIntervalTime(0)[ordernum]
        int FlushNum = AttackUnitFlushNum(0)[ordernum]
        int num = FlushNum
        if  FlushNum > 0
            CreateAttackBossTimer = CreateTimer()
            SaveInteger(ht,GetHandleId(CreateAttackBossTimer),1,FlushNum)
            SaveInteger(ht,GetHandleId(CreateAttackBossTimer),2,ordernum)
            SaveInteger(ht,GetHandleId(CreateAttackBossTimer),3,num)
            TimerStart(CreateAttackBossTimer,time,true,function OpenCreateBossTimer)
        endif
    endfunction
    
    function CreateBossTimer(int i,real time)
        int ordernum = i
        TimerStart(time,false)
        {
            CreateBossTimerFunc(ordernum)
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function OpenCreateUnitTimer()
        timer t = GetExpiredTimer()
        int FlushNum = LoadInteger(ht,GetHandleId(t),1)
        int ordernum = LoadInteger(ht,GetHandleId(t),2)
        int unitnum = AttackUnitNum(0)[ordernum]
        unit u = null
        if  FlushNum > 0 and GameWinBoolJu == false
            for k = 0,3
                if  IsPlaying(k) == true
                    puid[k] = AttackUnitID(k)[ordernum]
                    psx[k] = AttackUnitStartX(k)[ordernum]
                    psy[k] = AttackUnitStartY(k)[ordernum]
                    pex[k] = AttackUnitEndX(k)[ordernum]
                    pey[k] = AttackUnitEndY(k)[ordernum]
                    if  puid[k] != 0
                        for j = 1,unitnum
                            if  CountUnitsInGroup(AttackUnitGroup) <= 100
                                u = CreateUnit(Player(10),puid[k],pex[k],pey[k],0)
                                SetUnitXY(u,psx[k],psy[k])
                                IssuePointOrderById(u,851983,pex[k],pey[k])
                                GroupAddUnit(AttackUnitGroup,u)
                            endif
                        end
                    endif
                endif
            end
            FlushNum = FlushNum - 1
            SaveInteger(ht,GetHandleId(t),1,FlushNum)
        else
            FlushChildHashtable(ht,GetHandleId(t))
            DestroyTimer(t)
            CreateAttackUnitTimer = null
        endif
        t = null
        u = null
    endfunction

    function CreateUnitTimer(int ordernum)
        real time = AttackUnitIntervalTime(0)[ordernum]
        int FlushNum = AttackUnitFlushNum(0)[ordernum] - 1
        int unitnum = AttackUnitNum(0)[ordernum]
        unit u = null
        int Attacknum = 0
        real BossTime = 0
        for k = 0,3
            if  IsPlaying(k) == true
                puid[k] = AttackUnitID(k)[ordernum]
                psx[k] = AttackUnitStartX(k)[ordernum]
                psy[k] = AttackUnitStartY(k)[ordernum]
                pex[k] = AttackUnitEndX(k)[ordernum]
                pey[k] = AttackUnitEndY(k)[ordernum]
                if  puid[k] != 0
                    for j = 1,unitnum
                        u = CreateUnit(Player(10),puid[k],pex[k],pey[k],0)
                        SetUnitXY(u,psx[k],psy[k])
                        IssuePointOrderById(u,851983,pex[k],pey[k])
                        GroupAddUnit(AttackUnitGroup,u)
                    end
                endif
            endif
        end
        //DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffff0000开始进攻！！！|r")
        if  AttackUnitWN >= AttackUnitWNOver - 2
            OpenAttackShowUI("UI_AttackShow_1.tga",2)

        else
            OpenAttackShowUI("UI_AttackShow_0.tga",2)
        endif
        if  InfiniteAttackBool == false
            if  ModuloInteger(AttackUnitWN,3) == 0
                Attacknum = 100
                BossTime = 0
                AttackUnitWNBoss = AttackUnitWNBoss + 1
                CreateBossTimer(AttackUnitWNBoss+Attacknum,BossTime)
            endif
        else

        endif  
        if  FlushNum > 0
            CreateAttackUnitTimer = CreateTimer()
            SaveInteger(ht,GetHandleId(CreateAttackUnitTimer),1,FlushNum)
            SaveInteger(ht,GetHandleId(CreateAttackUnitTimer),2,ordernum)
            TimerStart(CreateAttackUnitTimer,time,true,function OpenCreateUnitTimer)
        endif
        flush locals
    endfunction
    
    function OpenAttackUnitTimer()
        timer t = GetExpiredTimer()
        FlushChildHashtable(ht,GetHandleId(t))
        DestroyTimer(t)
        ExecuteFunc("StartAttackUnit")
        t = null
    endfunction
    
    function CreateNextTimer(int i)
        int r1 = 0
        BJDebugMsg("CreateNextTimer"+I2S(i)+"@@"+I2S(AttackUnitWN+1))
        AttackTimer = CreateTimer()
        TimerStart(AttackTimer,AttackUnitNextTime[i],false,function OpenAttackUnitTimer)
        /*if  AttackUnitWN == AttackUnitWNOver - 3
            TimerStart(AttackTimer,80,false,function OpenAttackUnitTimer)
        else
            TimerStart(AttackTimer,5,false,function OpenAttackUnitTimer)
        endif*/
        if  AttackUnitWN >= AttackUnitWNOver - 3
            AttackTimerUIText = "最终大决战"
            if  IsChangeGodStage == false
                IsChangeGodStage = true
                //CreateChangeGodStage.execute(80)
                CreateChangeGodStage.execute(AttackUnitNextTime[i])
            endif
        else
            if  AttackUnitWN == 5
                if  IsGameOperaA == false
                    IsGameOperaA = true
                    CreateGameOperaA.execute(AttackUnitNextTime[i])
                endif
            elseif  AttackUnitWN == 11
                if  IsGameOperaB == false
                    IsGameOperaB = true
                    CreateGameOperaB.execute(AttackUnitNextTime[i])
                endif
                for pid = 0,3
                    if  IsPlaying(pid) == true
                        AddPlayerTechResearched(Player(pid),'RZ00',1)
                    endif
                end
            elseif  AttackUnitWN == 14
                if  IsGameOperaC == false
                    IsGameOperaC = true
                    CreateGameOperaC.execute(AttackUnitNextTime[i])
                endif
            elseif  AttackUnitWN == 15
                ExecuteFunc("ShowGameTeamChallengeNPC")
            endif
            AttackTimerUIText = "进攻波 "+I2S(AttackUnitWN+1)+"/"+I2S(AttackUnitWNOver)
        endif
    endfunction

    function OpenStopAttackTimer()
        FlushChildHashtable(ht,GetHandleId(AttackElseTimer))
        DestroyTimer(AttackElseTimer)
        AttackElseTimer = null
        ResumeTimer(AttackTimer)
        StopAttackBool = false
    endfunction
    function FuncStopAttack(real time)
        StopAttackBool = true
        PauseTimer(AttackTimer)
        AttackElseTimer = CreateTimer()
        TimerStart(AttackElseTimer,time,false,function OpenStopAttackTimer)
    endfunction
    
    function StartAttackUnit()
        int jf = 0
        int cos = 0
        if  StopAttackBool == false
            AttackUnitOrderNum = AttackUnitOrderNum + 1
            if  InfiniteAttackBool == false
                if  AttackUnitType[AttackUnitOrderNum] == 0
                    AttackUnitWN = AttackUnitWN + 1
                    CreateUnitTimer(AttackUnitOrderNum)
                /*else
                    if  AttackUnitOrderNum == 7
                        ExecuteFunc("CreateOperaA")
                        BJDebugMsg("CreateOperaACreateOperaACreateOperaACreateOperaA")
                    elseif  AttackUnitOrderNum == 14
                        ExecuteFunc("CreateOperaB")
                        BJDebugMsg("CreateOperaACreateOperaACreateOperaACreateOperaA")
                    elseif  AttackUnitOrderNum == 16
                        ExecuteFunc("ShowGameTeamChallengeNPC")
                    elseif  AttackUnitOrderNum == 18
                        ExecuteFunc("CreateOperaC")
                        BJDebugMsg("CreateOperaACreateOperaACreateOperaACreateOperaA")
                    endif*/
                endif
            endif
            if  AttackUnitWN < AttackUnitWNOver
                if  InfiniteAttackBool == false and AttackUnitType[AttackUnitOrderNum] == 0
                    CreateNextTimer(AttackUnitOrderNum)
                endif
            else
                if  InfiniteAttackBool == true
                    /*if  GameMode == 3
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[宠物之森]：|r|cffff0000波数到达上限，游戏胜利！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[宠物之森]：|r|cffff0000波数到达上限，游戏胜利！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[宠物之森]：|r|cffff0000波数到达上限，游戏胜利！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[宠物之森]：|r|cffff0000波数到达上限，游戏胜利！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[宠物之森]：|r|cffff0000波数到达上限，游戏胜利！|r")
                    elseif  GameMode == 4
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[镜世界]：|r|cffff0000波数到达上限，游戏胜利！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[镜世界]：|r|cffff0000波数到达上限，游戏胜利！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[镜世界]：|r|cffff0000波数到达上限，游戏胜利！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[镜世界]：|r|cffff0000波数到达上限，游戏胜利！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[镜世界]：|r|cffff0000波数到达上限，游戏胜利！|r")
                    endif
                    PauseAllUnitsBJ(true)
                    for pid = 0,5
                        CustomVictoryBJ(Player(pid), true, true )
                    end*/
                endif
            endif
            if  InfiniteAttackBool == false
                for pid = 0,5
                    if  IsPlaying(pid) == true
                        cos = 100*AttackUnitWN
                        if  cos > 30000
                            cos = 30000
                        endif
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,cos)
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r敌军发起进攻，每人获得"+I2S(cos)+"金币奖励。")

                        if  GetPlayerTechCount(Player(pid),'RY4D',true) == 1
                            AddUnitRealState(Pu[1],50,16)
                            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[商城-鼠年大吉]：|r进攻怪来袭，|cffffff80每秒金币+16|r！")
                        endif
                    endif
                end     
            else
                for pid = 0,5
                    if  IsPlaying(pid) == true
                        //DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[无尽]:|cff00ff00进攻怪来袭，每人奖励"+I2S(R2I(10*(1+(S2I(DzC[19])*0.5))))+"点无尽积分！|r")
                    endif
                end
            endif
        endif
    endfunction
    
    function OpenStartAttackUnitTimer()
        timer t = GetExpiredTimer()
        FlushChildHashtable(ht,GetHandleId(t))
        DestroyTimer(t)
        if  InfiniteAttackBool == false
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffff0000---------------------")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"开始进攻，注意回防！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"开始进攻，注意回防！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"开始进攻，注意回防！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"开始进攻，注意回防！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"开始进攻，注意回防！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"开始进攻，注意回防！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"开始进攻，注意回防！！！")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffff0000---------------------|r")
        endif
        StartAttackUnit()
        t = null
    endfunction
    
    function StartAttackUnitTimer(real time)
        AttackTimer = CreateTimer()
        if  InfiniteAttackBool == false
            OpenAttackTimerUI(R2I(time))
        endif
        TimerStart(AttackTimer,time,false,function OpenStartAttackUnitTimer)
    endfunction
    
    function AttackUnitWin()
        real ran = 0
        int jf = 0
        int jfadd = 0
        GameWinBoolJu = true
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在30秒内结束！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在30秒内结束！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在30秒内结束！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在30秒内结束！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在30秒内结束！|r")
        for pid = 0,5
            if  IsPlaying(pid) == true
                //存档
                AddDzPlayerData(pid,3,1,1) //总通关次数
                AddDzPlayerData(pid,3,GameLevel+1,1) //通关难度次数

                jfadd = 10*GameLevel
                jfadd = R2I(I2R(jfadd)*(1+DzConA[11]*0.5))
                AddDzPlayerData(pid,2,1,jfadd) //通关积分
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|cff00ff00游戏已通关，奖励"+I2S(jfadd)+"点通关积分！|r")
                
                AddDzHeroExp(Pu[1],1+GameLevel)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|cff00ff00增加"+GetUnitName(Pu[1])+I2S((1+GameLevel)*10)+"点熟练度！|r")

                MissionAddNumFunc(pid,2,1) //任务
                MissionAddNumFunc(pid,6,1) //任务
                if  PlayerNum > 1 
                    MissionAddNumFunc(pid,11,1) //任务
                endif
                if  GameLevel >= 2
                    MissionAddNumFunc(pid,22,1) //任务
                endif
                if  GameLevel >= 3
                    MissionAddNumFunc(pid,23,1) //任务
                endif
            endif
        end
        ExecuteFunc("GameWin")
    endfunction
    
    function GameWin()
        int time = 0
        TimerStart(1,true)
        {
            if  time < 30
                time = time + 1
                if  time == 10
                
                elseif  time == 20
                    for pid = 0,5
                        if  IsPlaying(pid) == true
                            Dialog.create(Player(pid),"|cffff0000游戏已通关！|r\n游戏将在10秒内结束！","确定","","","","","","","","","","","","")
                        endif
                    end
                elseif  time == 25
                    PauseAllUnits( true )
                endif
            else
                for pid = 0,5
                    CustomVictoryBJ(Player(pid), true, true )
                end
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

endlibrary
