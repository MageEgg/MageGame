library AttackUnit uses DamageCode 
    
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
    
    #define AttackTimer                 AttackArrayTimer[0]
    #define AttackElseTimer             AttackArrayTimer[1]
    #define CreateAttackUnitTimer       AttackArrayTimer[2]
    #define CreateAttackBossTimer       AttackArrayTimer[3]
    
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
        else
            AttackTimerTextUI.SetText("|cffffcc00"+AttackTimerUIText+"|r")
            AttackTimerTextExUI.SetText("")
        endif
    endfunction
    
    function OpenAttackTimerUI(int time)
        AttackTimerUIText = "进攻第1波"
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
        InitAttackUnitData(1,0,150,3,20,1,-7450,-7590,'m001',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(2,0,150,3,20,1,-7450,-7590,'m002',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(3,0,150,3,20,1,-7450,-7590,'m003',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(4,0,150,3,20,1,-7450,-7590,'m004',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(5,0,150,3,20,1,-7450,-7590,'m005',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(6,0,30,3,20,1,-7450,-7590,'m006',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(7,1,120,3,20,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
        InitAttackUnitData(8,0,120,3,20,1,-7450,-7590,'m007',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(9,0,120,3,20,1,-7450,-7590,'m008',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(10,0,120,6,20,1,-7450,-7590,'m009',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(11,0,120,6,20,1,-7450,-7590,'m010',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(12,0,120,6,20,1,-7450,-7590,'m011',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(13,0,30,6,20,1,-7450,-7590,'m012',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(14,1,120,6,20,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
        InitAttackUnitData(15,0,120,6,20,1,-1664,-7456,'m013',0,0,0,-1664,-6112,0,0,0,0,0,0)
        InitAttackUnitData(16,0,120,6,20,1,-1664,-7456,'m014',0,0,0,-1664,-6112,0,0,0,0,0,0)
        InitAttackUnitData(17,0,30,6,20,1,-1664,-7456,'m015',0,0,0,-1664,-6112,0,0,0,0,0,0)

        InitAttackUnitData(101,0,0,1,1,0,-7450,-7590,'mb01',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(102,0,0,1,1,0,-7450,-7590,'mb02',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(103,0,0,1,1,0,-7450,-7590,'mb03',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(104,0,0,1,1,0,-7450,-7590,'mb04',0,0,0,-4736,-7520,0,0,0,0,0,0)
        InitAttackUnitData(105,0,0,1,1,0,-1664,-7456,'mb05',0,0,0,-1664,-6112,0,0,0,0,0,0)
        InitAttackUnitData(106,0,0,1,1,0,-1664,-7456,'mb06',0,0,0,-1664,-6112,0,0,0,0,0,0)
        InitAttackUnitData(107,0,0,1,1,0,-1664,-7456,'mb07',0,0,0,-1664,-6112,0,0,0,0,0,0)
        InitAttackUnitData(108,0,0,1,1,0,-1664,-7456,'mb08',0,0,0,-1664,-6112,0,0,0,0,0,0)
        InitAttackUnitData(109,0,0,1,1,0,-1664,-7456,'mb09',0,0,0,-1664,-6112,0,0,0,0,0,0)

    endfunction
    
    function InitAttackUnitOfLevelEx(int lv)
        if  lv == 2
            InitAttackUnitData(18,1,180,6,20,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
            InitAttackUnitData(19,0,30,8,15,1,-1664,-7456,'m016',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(20,0,30,8,15,1,-1664,-7456,'m017',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(21,0,0,8,15,1,-1664,-7456,'m018',0,0,0,-1664,-6112,0,0,0,0,0,0)
        elseif  lv == 3
            InitAttackUnitData(18,1,120,6,20,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
            InitAttackUnitData(19,0,120,6,20,1,-1664,-7456,'m016',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(20,0,120,6,20,1,-1664,-7456,'m017',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(21,0,180,6,20,1,-1664,-7456,'m018',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(22,0,30,8,15,1,-1664,-7456,'m019',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(23,0,30,8,15,1,-1664,-7456,'m020',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(24,0,0,8,15,1,-1664,-7456,'m021',0,0,0,-1664,-6112,0,0,0,0,0,0)
        elseif  lv == 4
            InitAttackUnitData(18,1,120,6,20,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
            InitAttackUnitData(19,0,120,6,20,1,-1664,-7456,'m016',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(20,0,120,6,20,1,-1664,-7456,'m017',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(21,0,120,6,20,1,-1664,-7456,'m018',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(22,0,120,6,20,1,-1664,-7456,'m019',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(23,0,120,6,20,1,-1664,-7456,'m020',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(24,0,180,6,20,1,-1664,-7456,'m021',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(25,0,30,8,15,1,-1664,-7456,'m022',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(26,0,30,8,15,1,-1664,-7456,'m023',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(27,0,0,8,15,1,-1664,-7456,'m024',0,0,0,-1664,-6112,0,0,0,0,0,0)
        elseif  lv >= 5 and lv <= 7
            InitAttackUnitData(18,1,120,6,20,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
            InitAttackUnitData(19,0,120,6,20,1,-1664,-7456,'m016',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(20,0,120,6,20,1,-1664,-7456,'m017',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(21,0,120,6,20,1,-1664,-7456,'m018',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(22,0,120,6,20,1,-1664,-7456,'m019',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(23,0,120,6,20,1,-1664,-7456,'m020',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(24,0,120,6,20,1,-1664,-7456,'m021',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(25,0,120,6,20,1,-1664,-7456,'m022',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(26,0,120,6,20,1,-1664,-7456,'m023',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(27,0,180,6,20,1,-1664,-7456,'m024',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(28,0,30,8,15,1,-1664,-7456,'m025',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(28,0,30,8,15,1,-1664,-7456,'m026',0,0,0,-1664,-6112,0,0,0,0,0,0)
            InitAttackUnitData(29,0,0,8,15,1,-1664,-7456,'m027',0,0,0,-1664,-6112,0,0,0,0,0,0)
        endif
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
        if  GameLevel <= 2
            AttackUnitWNOver = 18  //最终波
        elseif  GameLevel == 3
            AttackUnitWNOver = 21  //最终波
        elseif  GameLevel == 4
            AttackUnitWNOver = 24  //最终波
        elseif  GameLevel >= 5 and GameLevel <= 7
            AttackUnitWNOver = 27  //最终波
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
    
    function OpenCreateBossTimer()
        timer t = GetExpiredTimer()
        int FlushNum = LoadInteger(ht,GetHandleId(t),1)
        int ordernum = LoadInteger(ht,GetHandleId(t),2)
        int num = LoadInteger(ht,GetHandleId(t),3)
        int unitnum = AttackUnitNum(0)[ordernum]
        unit u = null
        if  FlushNum > 0
            for k = 0,3
                puid[k] = AttackUnitID(k)[ordernum]
                psx[k] = AttackUnitStartX(k)[ordernum]
                psy[k] = AttackUnitStartY(k)[ordernum]
                pex[k] = AttackUnitEndX(k)[ordernum]
                pey[k] = AttackUnitEndY(k)[ordernum]
                if  puid[k] != 0
                    for j = 1,unitnum
                        u = CreateUnit(Player(11),puid[k],pex[k],pey[k],0)
                        UnitAddAbility(u,'A001')
                        SetUnitXY(u,psx[k],psy[k])
                        PingMinimap(psx[k],psy[k],5)
                        IssuePointOrderById(u,851983,pex[k],pey[k])
                        GroupAddUnit(AttackUnitGroup,u)
                    end
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
        if  FlushNum > 0
            for k = 0,3
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
        int FlushNum = 2//AttackUnitFlushNum(0)[ordernum] - 1
        int unitnum = AttackUnitNum(0)[ordernum]
        unit u = null
        int Attacknum = 0
        real BossTime = 0
        for k = 0,3
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
        //TimerStart(AttackTimer,AttackUnitNextTime[i],false,function OpenAttackUnitTimer)
        TimerStart(AttackTimer,8,false,function OpenAttackUnitTimer)
        if  i == 6
            AttackTimerUIText = "特殊事件 年兽贺岁"
        elseif  i == 13
            AttackTimerUIText = "特殊事件 闻太师西征"
        elseif  i == 17
            AttackTimerUIText = "特殊事件 摘星楼擒妖"
        else
            if  AttackUnitWN >= AttackUnitWNOver - 3
                AttackTimerUIText = "最终大决战"
            else
                AttackTimerUIText = "进攻第"+I2S(AttackUnitWN+1)+"波"
            endif
        endif
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
                else
                    if  AttackUnitOrderNum == 7
                        ExecuteFunc("CreateOperaA")
                        BJDebugMsg("CreateOperaACreateOperaACreateOperaACreateOperaA")
                    elseif  AttackUnitOrderNum == 14
                        ExecuteFunc("CreateOperaB")
                        BJDebugMsg("CreateOperaACreateOperaACreateOperaACreateOperaA")
                    elseif  AttackUnitOrderNum == 18
                        ExecuteFunc("CreateOperaC")
                        BJDebugMsg("CreateOperaACreateOperaACreateOperaACreateOperaA")
                    endif
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
                        //DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|cff00ff00进攻怪来袭，每人奖励"+I2S(R2I(10*(1+(S2I(DzC[15])*0.5))))+"点守家积分！|r")
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
        GameWinBoolJu = true
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在30秒内结束！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在30秒内结束！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在30秒内结束！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在30秒内结束！|r")
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在30秒内结束！|r")
        for pid = 0,5
            if  IsPlaying(pid) == true
                //存档
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
