library AttackUnit uses DamageCode,PassCheckMission
    
    group AttackUnitGroup = CreateGroup()
    private group AttackUnitGroupCos = CreateGroup()
    private unit AttackUnitGroupCosUnit = null
    private int GameModeTime = 0
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
    #define AttackUnitVariationNumA     AttackUnitInt[0][11]    //异变参数A
    #define AttackUnitVariationNumB     AttackUnitInt[0][12]    //异变参数B
    
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

    function GetGameMode4AttackUnitGroupCos()->int
        int cos = 0
        GroupAddGroup(AttackUnitGroup,AttackUnitGroupCos)
        loop
            AttackUnitGroupCosUnit = FirstOfGroup(AttackUnitGroupCos)
            exitwhen AttackUnitGroupCosUnit == null
            if  GetUnitIntState(AttackUnitGroupCosUnit,'IX0A') == 0
                cos = cos + 1
            else
                cos = cos + GetUnitIntState(AttackUnitGroupCosUnit,'IX0A')
            endif
            GroupRemoveUnit(AttackUnitGroupCos,AttackUnitGroupCosUnit)
        endloop
        GroupClear(AttackUnitGroupCos)
        AttackUnitGroupCosUnit = null
        return cos
    endfunction

    function GetGameMode4Time()->string
        int min = GameModeTime/60
        int s = 0
        if  min > 0
            s = GameModeTime-60*min
            return I2S(min)+"分"+I2S(s)+"秒"
        else
            s = GameModeTime
            return I2S(s)+"秒"
        endif
    endfunction

    function ReflushAttackTimerUI()
        int cos = 0
        if  GameLevel > 0
            if  GameMode == 4
                if  I2R(GetGameMode4AttackUnitGroupCos())/I2R(70+50*PlayerNum) < 0.6
                    VariationTextExUI.SetText("|cff00ff00"+I2S(GetGameMode4AttackUnitGroupCos())+"/"+I2S(70+50*PlayerNum)+"|r")
                else
                    VariationTextExUI.SetText("|cffff0000"+I2S(GetGameMode4AttackUnitGroupCos())+"/"+I2S(70+50*PlayerNum)+"|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,1,"|cffffcc00[系统]：|r|cffff0000当前怪物数量积压过多，请及时清理！！！|r")
                endif
                if  GetGameMode4AttackUnitGroupCos() > (70+50*PlayerNum)
                    ExecuteFunc("GameOverEx")
                endif
                if  GameModeTime > 0
                    GameModeTime = GameModeTime - 1
                    if  GameModeTime > 1800
                        AttackTimerTextUI.SetText("|cffffe100准备时间|r")
                        AttackTimerTextExUI.SetText("|cffffe100"+I2S(GameModeTime-1800)+"秒|r")
                    else
                        AttackTimerTextUI.SetText("|cff00ff00生存时间|r")
                        AttackTimerTextExUI.SetText("|cff00ff00"+GetGameMode4Time()+"|r")
                    endif
                else
                    KillAttackUnitGroup()
                    PauseAllUnits( true )
                    AttackTimerTextUI.SetText("|cffffe100游戏胜利|r")
                    AttackTimerTextExUI.SetText("|cffffe100游戏胜利|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r|cff00ff0成功生存30分钟！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r|cff00ff0成功生存30分钟！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r|cff00ff0成功生存30分钟！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r|cff00ff0成功生存30分钟！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r|cff00ff0成功生存30分钟！！！|r")
                endif
            else
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
            endif
        endif
    endfunction
    
    function OpenAttackTimerUI(int time)
        AttackTimerUIText = "进攻波 1/"+I2S(AttackUnitWNOver-3)
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
        InitAttackUnitData(21,0,0,3,500,0.6,-1664,-7440,'m021','m021','m021','m021',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
        InitAttackUnitData(22,0,15,3,25,0.6,-1664,-7440,'m022','m022','m022','m022',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
        InitAttackUnitData(23,0,15,3,25,0.6,-1664,-7440,'m023','m023','m023','m023',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
        InitAttackUnitData(24,0,0,3,500,0.6,-1664,-7440,'m024','m024','m024','m024',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)

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
            InitAttackUnitData(24,0,0,3,500,0.6,-1664,-7440,'m024','m024','m024','m024',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)

            InitAttackUnitData(107,0,0,1,1,1,-6910,-6912,'mb07','mb07','mb07','mb07',-6912,-4800,-4750,-6912,-6912,-9110,-9080,-6912)
            InitAttackUnitData(108,0,0,1,1,1,-1664,-7440,'mb08','mb08','mb08','mb08',-1664,-6320,96,-7550,-1664,-8950,-3250,-7440)
        endif
        if  GameMode == 2
            if  lv > 1
                for num = 10,20
                    AttackUnitNextTime[num] = 30
                end
                AttackUnitNextTime[21] = 70
            else
                for num = 10,17
                    AttackUnitNextTime[num] = 30
                end
                AttackUnitNextTime[18] = 70
            endif
            DzConA[11] = DzConA[11] + 1
        elseif  GameMode == 3
            if  lv > 1
                for num = 1,20
                    AttackUnitNextTime[num] = 61
                end
                AttackUnitNextTime[21] = 120
            else
                for num = 1,17
                    AttackUnitNextTime[num] = 61
                end
                AttackUnitNextTime[18] = 120
            endif
        endif
        ExecuteFunc("InitAttackUnitChallengeState")
    endfunction

    function InitAttackUnitOfGameMode4()
        InitAttackUnitData(1,0,30,1,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(2,0,30,1,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(3,0,30,1,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(4,0,30,1,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(5,0,30,1,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(6,0,30,1,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(7,0,30,1,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(8,0,30,1,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(9,0,30,1,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(10,0,30,1,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(11,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(12,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(13,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(14,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(15,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(16,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(17,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(18,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(19,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(20,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(21,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(22,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(23,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(24,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(25,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(26,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(27,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(28,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(29,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(30,0,30,2,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(31,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(32,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(33,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(34,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(35,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(36,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(37,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(38,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(39,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(40,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(41,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(42,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(43,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(44,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(45,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(46,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(47,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(48,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(49,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(50,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(51,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(52,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(53,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(54,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(55,0,30,3,54,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(56,0,20,4,36,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(57,0,20,4,36,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(58,0,20,4,36,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(59,0,20,4,36,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(60,0,20,4,36,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(61,0,20,5,36,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(62,0,20,6,36,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(63,0,10,7,360,0.5,-4096,11776,0,0,0,0,-6016,13728,-2144,13728,-2144,9824,-6016,9824)

        InitAttackUnitData(101,0,0,1,2,1,-4096,11776,'mb01','mb01','mb01','mb01',-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(102,0,0,1,2,1,-4096,11776,'mb02','mb02','mb02','mb02',-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(103,0,0,1,2,1,-4096,11776,'mb03','mb03','mb03','mb03',-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(104,0,0,1,2,1,-4096,11776,'mb04','mb04','mb04','mb04',-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(105,0,0,1,2,1,-4096,11776,'mb05','mb05','mb05','mb05',-6016,13728,-2144,13728,-2144,9824,-6016,9824)
        InitAttackUnitData(106,0,0,1,2,1,-4096,11776,'mb06','mb06','mb06','mb06',-6016,13728,-2144,13728,-2144,9824,-6016,9824)

        ExecuteFunc("InitAttackUnitChallengeState")

        VariationShowUI.SetPoint(0,GameUI,0,0.22,-0.025)
        VariationTextUI.SetText("|cffffcc00怪物上限|r")
        VariationTextExUI.SetText("|cff00ff00/"+I2S(70+50*PlayerNum)+"|r")

        GameModeTime = 1861

        ShowVariationUIEx(true)
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
        GameWinBoolJu = false
        if  GameMode == 4
            AttackUnitWNOver = 63  //最终波
            LastAttackBossId = 'mb06'
            ShowUnit(gg_unit_np00_0093,false)
            GameMode4ShopUnit = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np49',-4082,11772,270)
            GameDefendUnit = GameMode4ShopUnit

            CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np02',-4283,11772,270)
            CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'nc02',-4283,11772,270)

            CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np03',-3885,11772,270)
            CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'nc03',-3885,11772,270)

            for pid = 0,3
                if  IsPlaying(pid) == true
                    Pu[47] = CreateUnit(Player(pid),'np47',-4082,11772,270)
                    if  pid == 0
                        Pu[42]=CreateUnit(Player(pid),'np42',-4544,12896,270)//挑战
                        CreateUnit(Player(pid),'nc42',-4544,12896,270)//挑战
                        Pu[46]=CreateUnit(Player(pid),'np46',-4256,12896,270)//挑战
                        CreateUnit(Player(pid),'nc42',-4256,12896,270)//挑战
                        Pu[26]=CreateUnit(Player(pid),'np06',-3936,12896,270)//礼包
                        CreateUnit(Player(pid),'nc06',-3936,12896,270)//礼包
                    elseif  pid == 1
                        Pu[42]=CreateUnit(Player(pid),'np42',-2944,12224,270)//挑战
                        CreateUnit(Player(pid),'nc42',-2944,12224,270)//挑战
                        Pu[46]=CreateUnit(Player(pid),'np46',-2944,11904,270)//挑战
                        CreateUnit(Player(pid),'nc42',-2944,11904,270)//挑战
                        Pu[26]=CreateUnit(Player(pid),'np06',-2944,11584,270)//礼包
                        CreateUnit(Player(pid),'nc06',-2944,11584,270)//礼包
                    elseif  pid == 2
                        Pu[42]=CreateUnit(Player(pid),'np42',-3648,10624,270)//挑战
                        CreateUnit(Player(pid),'nc42',-3648,10624,270)//挑战
                        Pu[46]=CreateUnit(Player(pid),'np46',-3936,10624,270)//礼包
                        CreateUnit(Player(pid),'nc42',-3936,10624,270)//礼包
                        Pu[26]=CreateUnit(Player(pid),'np06',-4256,10624,270)//礼包
                        CreateUnit(Player(pid),'nc06',-4256,10624,270)//礼包
                    elseif  pid == 3
                        Pu[42]=CreateUnit(Player(pid),'np42',-5216,11296,270)//挑战
                        CreateUnit(Player(pid),'nc42',-5216,11296,270)//挑战
                        Pu[46]=CreateUnit(Player(pid),'np46',-5216,11584,270)//礼包
                        CreateUnit(Player(pid),'nc42',-5216,11584,270)//礼包
                        Pu[26]=CreateUnit(Player(pid),'np06',-5216,11936,270)//礼包
                        CreateUnit(Player(pid),'nc06',-5216,11936,270)//礼包
                    endif

                    SetPlayerTechResearched(Player(pid),'RF0A',1)
                endif
            end
            

            InitAttackUnitOfGameMode4()
        else
            if  GameLevel > 1
                AttackUnitWNOver = 24  //最终波
                LastAttackBossId = 'mb08'
            else
                AttackUnitWNOver = 21  //最终波
                LastAttackBossId = 'mb07'
            endif

            InitAttackUnitOfLevel()
            InitAttackUnitOfLevelEx(GameLevel)
        endif
    endfunction
    
    function AttackUnitGroupFunc()
        int pid = 0
        if  GetUnitCurrentOrder(GetEnumUnit()) == 0 
            pid = GetAttackPlayingHeroId.evaluate()
            if  pid >= 0
                IssuePointOrderById(GetEnumUnit(),851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
            else
                IssuePointOrderById(GetEnumUnit(),851983,GetUnitX(GameDefendUnit),GetUnitY(GameDefendUnit))
            endif
        endif
        if  GetUnitAbilityLevel(GetEnumUnit(),'AXAE') > 0
            if  GetUnitAbilityLevel(GetEnumUnit(),'AZ01') > 0 or GetUnitAbilityLevel(GetEnumUnit(),'AZ92') > 0 or GetUnitAbilityLevel(GetEnumUnit(),'AZ91') > 0 
                SetUnitState(GetEnumUnit(),UNIT_STATE_LIFE,GetUnitState(GetEnumUnit(),UNIT_STATE_LIFE)+GetUnitState(GetEnumUnit(),UNIT_STATE_MAX_LIFE)*0.03)
            else
                SetUnitState(GetEnumUnit(),UNIT_STATE_LIFE,GetUnitState(GetEnumUnit(),UNIT_STATE_LIFE)+GetUnitState(GetEnumUnit(),UNIT_STATE_MAX_LIFE)*0.3)                                                  
            endif
            UnitAddEffect(GetEnumUnit(),"Abilities\\Spells\\vOrc\\HealingWave\\HealingWaveTarget.mdl")
        endif
    endfunction
    
    function AttackUnitGroupTimer()
        ForGroup(AttackUnitGroup,function AttackUnitGroupFunc)
    endfunction

    function IntUnitVariation(unit u)
        if  GetUnitAbilityLevel(u,'AZ01') > 0 or GetUnitAbilityLevel(u,'AZ92') > 0 or GetUnitAbilityLevel(u,'AZ91') > 0
            SetUnitMoveSpeed(u,422)
        else
            SetUnitMoveSpeed(u,522)
        endif
        AddUnitRealState(u,9,30)
        SetUnitVertexColor(u,255,155,155,185)
    endfunction

    function AddUnitVariation(unit u,int ty)
        int sid = 0
        if  ty == 0
            sid = 'AXAA'+GetRandomInt(0,11)
        elseif  ty == 1
            sid = 'AXBA'+GetRandomInt(0,8)
        else
            sid = ty
        endif
        UnitAddAbility(u,sid)
        if  sid == 'AXAA'
            SetUnitRealState(u,1,GetUnitRealState(u,1)*1.4)
        elseif  sid == 'AXAB'
            if  GetUnitAbilityLevel(u,'AZ01') > 0 or GetUnitAbilityLevel(u,'AZ92') > 0 or GetUnitAbilityLevel(u,'AZ91') > 0
                SetUnitRealState(u,5,GetUnitRealState(u,5)*1.4)   
            else
                SetUnitRealState(u,5,GetUnitRealState(u,5)*12)   
            endif
        elseif  sid == 'AXAF'
            AddUnitRealState(u,10,15)
        elseif  sid == 'AXAH'
            if  GetUnitAbilityLevel(u,'AZ01') > 0 or GetUnitAbilityLevel(u,'AZ92') > 0 or GetUnitAbilityLevel(u,'AZ91') > 0
                AddUnitRealState(u,21,15) 
            else
                AddUnitRealState(u,21,150) 
            endif
        elseif  sid == 'AXAJ'
            AddUnitRealState(u,19,20)
        elseif  sid == 'AXAK'
            AddUnitRealState(u,20,800)
        elseif  sid == 'AXAL'
            UnitAddAbility(u,'AXAM')
        //////////////////////////////
        elseif  sid == 'AXBA'
            UnitAddAbility(u,'AZ3G')
        elseif  sid == 'AXBC'
            UnitAddAbility(u,'AZ3H')
        elseif  sid == 'AXBD'
            AddUnitRealState(u,51,500)
            SetUnitRealState(u,1,GetUnitRealState(u,1)*1.3)
            SpellAXBD.execute(u)
        elseif  sid == 'AXBE'
            UnitAddAbility(u,'AXBM')
        elseif  sid == 'AXBF'
            SpellAXBF.execute(u)
        elseif  sid == 'AXBG'
            SpellAXBG.execute(u)
        elseif  sid == 'AXBI'
            SpellAXBI.execute(u)
        endif
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
            if  GameMode == 4
                u = CreateUnit(Player(11),GetGameMode4AttackUnitId.evaluate()+0x100,ex,ey,GetUnitFacing(wu))
            else
                u = CreateUnit(Player(11),'ma01'+GetRandomInt(0,8),ex,ey,GetUnitFacing(wu))
            endif
            AddBossAttachUnitState(u,GetUnitTypeId(wu))
            SetUnitXY(u,sx,sy)
            IssuePointOrderById(u,851983,ex,ey)
            GroupAddUnit(AttackUnitGroup,u)
            if  GameMode == 3 or GameMode == 4
                IntUnitVariation(u)
                AddUnitVariation(u,AttackUnitVariationNumA)
                AddUnitVariation(u,AttackUnitVariationNumB)
            endif
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
            if  time <= 45 and GetUnitTypeId(u) != 0 and u != null
                if  ModuloInteger(time,5) == 0
                    nuqi = nuqi + 1
                    if  GetUnitAbilityLevel(u,'AZ80'+nuqi-1) > 0
                        UnitRemoveAbility(u,'AZ80'+nuqi-1)
                    endif
                    AddUnitRealState(u,9,10)
                    UnitAddAbility(u,'AZ80'+nuqi)
                endif
                if  time == 45
                    UnitAddAbility(u,'AZ80')
                    AddUnitRealState(u,1,GetUnitRealState(u,1))
                    AddUnitRealState(u,20,400)
                endif
            else
                BJDebugMsg("end计时器")
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    
    ////////////////////模式4分割//////////////////////

    function GetGameMode4AttackUnitId()->int
        int uid = 0
        real ran = GetRandomReal(1,100)
        if  ran > 40
            uid = 'm10A'
        elseif  ran > 10
            uid = 'm10B'
        else
            uid = 'm10C'
        endif
        return uid
    endfunction

    function SetGameMode4AttackUnitState(unit u)
        SetUnitRealState(u,1,GetUnitRealState(u,1)*10)
        SetUnitRealState(u,5,GetUnitRealState(u,5)*15)
    endfunction

    function SetGameMode4AttackUnitStateValue(int pid,unit u)
        real add = 1 + GetUnitRealState(Pu[1],'AT8A')
        
        SetUnitRealState(u,1,GetUnitRealState(u,1)*add)
        SetUnitRealState(u,5,GetUnitRealState(u,5)*add)
    endfunction

    ////////////////////模式4分割//////////////////////

    function OpenCreateBossTimer()
        timer t = GetExpiredTimer()
        int FlushNum = LoadInteger(ht,GetHandleId(t),1)
        int ordernum = LoadInteger(ht,GetHandleId(t),2)
        int num = LoadInteger(ht,GetHandleId(t),3)
        int unitnum = AttackUnitNum(0)[ordernum]
        unit u = null
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
                            UnitTimerAddSkill(u,'Avul',0.5)
                            SetUnitXY(u,psx[k],psy[k])
                            PingMinimap(psx[k],psy[k],5)
                            IssueImmediateOrderById(u,852076)
                            IssuePointOrderById(u,851983,pex[k],pey[k])
                            GroupAddUnit(AttackUnitGroup,u)
                            AttackBOSSLastCos = AttackBOSSLastCos + 1
                            CreateBossAttachUnit(u,pex[k],pey[k],0.1)
                            if  GameMode == 3 or GameMode == 4
                                IntUnitVariation(u)
                                AddUnitVariation(u,AttackUnitVariationNumA)
                                AddUnitVariation(u,AttackUnitVariationNumB)
                            endif
                            if  puid[k] == LastAttackBossId
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
        bool GM4 = false
        if  FlushNum > 0 and GameWinBoolJu == false and LastBOSSOpera == false
            for k = 0,3
                if  IsPlaying(k) == true
                    puid[k] = AttackUnitID(k)[ordernum]
                    psx[k] = AttackUnitStartX(k)[ordernum]
                    psy[k] = AttackUnitStartY(k)[ordernum]
                    pex[k] = AttackUnitEndX(k)[ordernum]
                    pey[k] = AttackUnitEndY(k)[ordernum]
                    if  GameMode == 4
                        puid[k] = GetGameMode4AttackUnitId()
                    endif
                    if  puid[k] != 0
                        for j = 1,unitnum
                            GM4 = false
                            if  CountUnitsInGroup(AttackUnitGroup) <= 50 or GameMode == 4
                                if  GameMode == 4 and GetRandomReal(1,100) <= 3//超爽模式变精英怪
                                    u = CreateUnit(Player(10),puid[k]+0x100,pex[k],pey[k],0)
                                    GM4 = true
                                else    
                                    u = CreateUnit(Player(10),puid[k],pex[k],pey[k],0)
                                endif
                                SetUnitXY(u,psx[k],psy[k])
                                IssuePointOrderById(u,851983,pex[k],pey[k])
                                GroupAddUnit(AttackUnitGroup,u)
                                if  GameMode == 3 and ModuloInteger(AttackUnitWN,3) == 0
                                    IntUnitVariation(u)
                                    AddUnitVariation(u,AttackUnitVariationNumA)
                                elseif  GameMode == 4
                                    UnitAddAbility(u,'AXCA')
                                    if  ModuloInteger(AttackUnitWN,2) == 0 
                                        if  GM4 == true
                                            SetGameMode4AttackUnitState(u)
                                            IntUnitVariation(u)
                                            AddUnitVariation(u,AttackUnitVariationNumA)
                                        endif
                                    elseif  ModuloInteger(AttackUnitWN,5) == 0
                                        IntUnitVariation(u)
                                        AddUnitVariation(u,AttackUnitVariationNumA)
                                    endif

                                    SetGameMode4AttackUnitStateValue(k,u)
                                endif
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
        int bossmod = 0
        bool GM4 = false
        if  GameMode == 3 
            if  ModuloInteger(AttackUnitWN,3) == 0
                AttackUnitVariationNumA = 'AXAA'+GetRandomInt(0,11)
                AttackUnitVariationNumB = 'AXBA'+GetRandomInt(0,8)
                VariationTextExUI.SetText("|cffff0000"+SubString(GetObjectName(AttackUnitVariationNumA),7,StringLength(GetObjectName(AttackUnitVariationNumA)))+"，"+SubString(GetObjectName(AttackUnitVariationNumB),13,StringLength(GetObjectName(AttackUnitVariationNumB)))+"|r")
                ShowVariationUIEx(true)
                for pid = 0,3
                    if  ShowEffect == true
                        if  GetLocalPlayer() == Player(pid)
                            Blood.show = true
                        endif
                    endif
                end
            elseif  ModuloInteger(AttackUnitWN-1,3) == 0 and AttackUnitWN > 3
                ShowVariationUIEx(false)
                Blood.show = false
            endif
        elseif GameMode == 4
            if  ModuloInteger(AttackUnitWN,2) == 0 or ModuloInteger(AttackUnitWN,5) == 0
                AttackUnitVariationNumA = 'AXAA'+GetRandomInt(0,11)
            endif
            if  ModuloInteger(AttackUnitWN,10) == 0
                AttackUnitVariationNumB = 'AXBA'+GetRandomInt(0,8)
            endif
        endif
        for k = 0,3
            if  IsPlaying(k) == true
                puid[k] = AttackUnitID(k)[ordernum]
                psx[k] = AttackUnitStartX(k)[ordernum]
                psy[k] = AttackUnitStartY(k)[ordernum]
                pex[k] = AttackUnitEndX(k)[ordernum]
                pey[k] = AttackUnitEndY(k)[ordernum]
                if  GameMode == 4
                    puid[k] = GetGameMode4AttackUnitId()
                endif
                if  puid[k] != 0
                    for j = 1,unitnum
                        GM4 = false
                        if  GameMode == 4 and GetRandomReal(1,100) <= 3//超爽模式变精英怪
                            u = CreateUnit(Player(10),puid[k]+0x100,pex[k],pey[k],0)
                            GM4 = true
                        else    
                            u = CreateUnit(Player(10),puid[k],pex[k],pey[k],0)
                        endif
                        SetUnitXY(u,psx[k],psy[k])
                        IssuePointOrderById(u,851983,pex[k],pey[k])
                        GroupAddUnit(AttackUnitGroup,u)
                        if  GameMode == 3 and ModuloInteger(AttackUnitWN,3) == 0
                            IntUnitVariation(u)
                            AddUnitVariation(u,AttackUnitVariationNumA)
                        elseif  GameMode == 4
                            UnitAddAbility(u,'AXCA')
                            if  ModuloInteger(AttackUnitWN,2) == 0 
                                if  GM4 == true
                                    SetGameMode4AttackUnitState(u)
                                    IntUnitVariation(u)
                                    AddUnitVariation(u,AttackUnitVariationNumA)
                                endif
                            elseif  ModuloInteger(AttackUnitWN,5) == 0
                                IntUnitVariation(u)
                                AddUnitVariation(u,AttackUnitVariationNumA)
                            endif

                            SetGameMode4AttackUnitStateValue(k,u)
                        endif
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
            if  GameMode == 4
                bossmod = 10
            else
                bossmod = 3
            endif
            if  ModuloInteger(AttackUnitWN,bossmod) == 0
                BJDebugMsg("BOSS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                Attacknum = 100
                BossTime = 0
                AttackUnitWNBoss = AttackUnitWNBoss + 1
                AttackBOSSDeathCos = 0
                AttackBOSSLastCos = 0
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
        if  AttackUnitWN >= AttackUnitWNOver - 3 and GameMode != 4
            AttackTimerUIText = "最终大决战"
            if  IsChangeGodStage == false
                IsChangeGodStage = true
                //CreateChangeGodStage.execute(80)
                CreateChangeGodStage.execute(AttackUnitNextTime[i])
            endif
        else

            if  DzConA[24] == 1 and GameMode != 4//劳动节活动
                
                    if  AttackUnitWN < AttackUnitWNOver - 3
                        if  GetRandomInt(1,100) <= 50
                            CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'uh02',-6900,-6594,270)
                            CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'uh02',-6900,-6594,270)
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|Cffffc926好吃懒做的恶徒|r寻衅滋事，麻烦少侠们守护西岐的安定！|r")
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|Cffffc926好吃懒做的恶徒|r寻衅滋事，麻烦少侠们守护西岐的安定！|r")
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|Cffffc926好吃懒做的恶徒|r寻衅滋事，麻烦少侠们守护西岐的安定！|r")
                        endif
                    endif
                
            endif

            if  GameMode == 1 or GameMode == 3
                if  AttackUnitWN == 5
                    if  IsGameOperaA == false
                        IsGameOperaA = true
                        CreateGameOperaA.execute(AttackUnitNextTime[i])
                    endif
                    ShowGameTeamChallengeNPC_A.execute(AttackUnitWN+1)
                elseif  AttackUnitWN == 6
                    if  GameSaveClose == 1
                        AddItemToStock(GameDefendUnit,'IZ70',1,1)
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[封神榜]：|r|cffffff00现在开始可在周文王处挑战龙须虎提前通关！！！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[封神榜]：|r|cffffff00现在开始可在周文王处挑战龙须虎提前通关！！！|r")
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[封神榜]：|r|cffffff00现在开始可在周文王处挑战龙须虎提前通关！！！|r")
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
                    ShowGameTeamChallengeNPC_B.execute(AttackUnitWN+1)

                    AddItemToStock(GameDefendUnit,'IZ04',1,1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[封神榜]：|r|cffffff00现在开始可在周文王处购买道具提前进入大决战！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[封神榜]：|r|cffffff00现在开始可在周文王处购买道具提前进入大决战！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[封神榜]：|r|cffffff00现在开始可在周文王处购买道具提前进入大决战！！！|r")
                elseif  AttackUnitWN == 17
                    ShowGameTeamChallengeNPC_C.execute(AttackUnitWN+1)
                endif
            elseif  GameMode == 2
                if  AttackUnitWN == 2
                    if  IsGameOperaA == false
                        IsGameOperaA = true
                        CreateGameOperaA.execute(AttackUnitNextTime[i])
                    endif
                elseif  AttackUnitWN == 3
                    ShowGameTeamChallengeNPC_A.execute(AttackUnitWN+1)
                elseif  AttackUnitWN == 5
                    if  IsGameOperaB == false
                        IsGameOperaB = true
                        CreateGameOperaB.execute(AttackUnitNextTime[i])
                    endif
                    for pid = 0,3
                        if  IsPlaying(pid) == true
                            AddPlayerTechResearched(Player(pid),'RZ00',1)
                        endif
                    end
                elseif  AttackUnitWN == 8
                    if  IsGameOperaC == false
                        IsGameOperaC = true
                        CreateGameOperaC.execute(AttackUnitNextTime[i])
                    endif
                elseif  AttackUnitWN == 9
                    ShowGameTeamChallengeNPC_B.execute(AttackUnitWN+1)
                elseif  AttackUnitWN == 10
                    AddItemToStock(GameDefendUnit,'IZ04',1,1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[封神榜]：|r|cffffff00现在开始可在周文王处购买道具提前进入大决战！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[封神榜]：|r|cffffff00现在开始可在周文王处购买道具提前进入大决战！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[封神榜]：|r|cffffff00现在开始可在周文王处购买道具提前进入大决战！！！|r")
                elseif  AttackUnitWN == 12
                    ShowGameTeamChallengeNPC_C.execute(AttackUnitWN+1)                
                endif
            elseif  GameMode == 4
                if  AttackUnitWN == 17
                    for pid = 0,3
                        if  IsPlaying(pid) == true
                            AddPlayerTechResearched(Player(pid),'RZ00',1)
                        endif
                    end
                endif
            endif
            AttackTimerUIText = "进攻波 "+I2S(AttackUnitWN+1)+"/"+I2S(AttackUnitWNOver-3)
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

    unit ExShopNpc = null
    //黑心商店
    function GetReExShopItem(int id1,int id2)->int
        int new = 'IL0A'+GetRandomInt(0,8)
        loop
            exitwhen new != id1 and new != id2
            new = 'IL0A'+GetRandomInt(0,8)
        endloop
        return new
    endfunction





    int array ExShopData[1000][2]

    function AddExShopItem(unit wu,int index,int id)
        int num = 1
        if  id == 'IL0A' or id == 'IL1A' or id == 'IL2A'
            num = GetRandomInt(1,3)
        elseif  id == 'IL0B' or id == 'IL1B' or id == 'IL2B'
            num = GetRandomInt(1,6)
        elseif  id == 'IL0C' or id == 'IL1C' or id == 'IL2C'
            num = GetRandomInt(1,4)
        elseif  id == 'IL0D' or id == 'IL1D' or id == 'IL2D'
            num = GetRandomInt(1,2)
        endif

        ExShopData[index][1] = id
        ExShopData[index][2] = num
        AddItemToStock(wu, id, num, num)
    endfunction

    function ReExShopItem(int id,int use)
        int index = 0

        for i = 1,4
            if  ExShopData[i][1] == id
                ExShopData[i][2] = ExShopData[i][2] - use
            endif
            if  ExShopData[i][2] > 0
                RemoveItemFromStock(ExShopNpc,ExShopData[i][1])
                AddItemToStock(ExShopNpc, ExShopData[i][1], ExShopData[i][2], ExShopData[i][2])
            endif
        end

    endfunction
    function PlayerBuyExShopItem(int pid,int id)
        int use = GetTypeIdData(id,103)
        int next = GetTypeIdData(id,106)
        BJDebugMsg("钻石需求"+I2S(use))
        if  GetPlayerFood(pid) >= use
            ReExShopItem(id,1)
            UsePlayerFood(pid,use)
            if  Udis(Pu[1],ExShopNpc) < Udis(Pu[2],ExShopNpc)
                UnitAddItemById(Pu[1],next)
            else
                UnitAddItemById(Pu[2],next)
            endif
            AddUnitIntState(Pu[1],'RDBA',1)
            if  GetUnitIntState(Pu[1],'RDBA') == 6
                if  GetPlayerTechCount(Player(pid),'RDBA',true) == 0
                    SetDzPlayerData(pid,15,27,1)
                    SetPlayerTechResearchedEx(Player(pid),'RDBA')
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000小富豪？|r（永久存档）！")
                endif
            endif
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r购买成功！")
        else
            ReExShopItem(id,0)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r钻石不足|cffff0000"+I2S(use)+"|r，无法购买！")
        endif

    endfunction


    


    function ReExShop()
        int id1 = 0
        int id2 = 0
        int id3 = 0
        int id4 = 0
        if  GetUnitTypeId(ExShopNpc) != 0
            RemoveUnit(ExShopNpc)
        endif

        if  GameMode == 4
            ExShopNpc = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np31',-3883,12175,270)//新商店
        else
            ExShopNpc = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np31',-6644,-5923,270)//新商店
        endif
        


        id1 = GetReExShopItem(0,0)
        id2 = GetReExShopItem(id1,0)
        //id3 = GetReExShopItem(id1,id2)

        id1 = id1 + 0x100
        id2 = id2 + 0x200
        //id3 = id3 + 0x300

        if  GetRandomInt(1,100) <= 15
            id4 = 'IL3A'+GetRandomInt(0,8)
        else
            if  GameLevel >= 4
                id4 = 'IL4A'+GetRandomInt(0,6)
            else
                id4 = 'IL4A'+GetRandomInt(0,4)
            endif
        endif

        AddExShopItem(ExShopNpc,1, id1)
        AddExShopItem(ExShopNpc,2, id2)
        //AddExShopItem(ExShopNpc,3, id3)
        AddExShopItem(ExShopNpc,4, id4)


        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[作者]：|r黑心，不对，|cff00ff00《良心商店》|r刷新啦！！！！")
    endfunction

    function ReChallengePrize(unit wu)
        for i = 0,5
            if  UnitItemInSlot(wu,i)!=null
                RemoveItem(UnitItemInSlot(wu,i))
            endif
        end
        
        bj_lastCreatedItem = UnitAddItemById(wu,'IC02')
        SetItemCharges(bj_lastCreatedItem,GetRandomInt(5000,20000))
        
        UnitAddPoolItem(wu,19)
        if  AttackUnitWN > 40
            UnitAddPoolItem(wu,22)
        elseif  AttackUnitWN > 20
            UnitAddPoolItem(wu,21)
        else
            UnitAddPoolItem(wu,20)
        endif
        
        RemoveItemFromStock(wu,'IZ71')
        RemoveItemFromStock(wu,'IZ72')
        AddItemToStock( wu,'IZ71', 1, 1 )
        AddItemToStock( wu,'IZ72', 1, 1 )

        bj_lastCreatedItem = null
    endfunction


    

    function CreateMode4ChallengeUnit()
        real x = 0
        real y = 0
        unit u = null
        for pid = 0,3
            if  IsPlaying(pid) == true
                if  pid == 0
                    x = GetRandomReal(-4256,-3904)
                    y = GetRandomReal(13472,13856)
                elseif  pid == 1
                    x = GetRandomReal(-2400,-2048)
                    y = GetRandomReal(11584,11968)
                elseif  pid == 2
                    x = GetRandomReal(-4256,-3904)
                    y = GetRandomReal(9664,10048)
                elseif  pid == 3
                    x = GetRandomReal(-6144,-5792)
                    y = GetRandomReal(11552,11936)
                endif
                u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),GetRandomInt('mg0A','mg0H'),x,y,GetRandomReal(0,360))
                
                UnitApplyTimedLife( u, 'BHwe', 300 )
                
                UnitAddAbility(u,'A00K')
                UnitAddAbility(u,'Avul')
                UnitAddAbility(u,'Asid')
                UnitAddAbility(u,'Aneu')
                UnitAddAbility(u,'Apit')
                AddItemToStock( u,'IZ71', 1, 1 )
                AddItemToStock( u,'IZ72', 1, 1 )
                EXSetUnitMoveType( u, 0x01 )

                ReChallengePrize(u)

            endif
        end

        u = null
    endfunction

    function OpenNewChallenge1(int pid,unit tu)
        int num = NewChallengeNum1+1
        real x = 0
        real y = 0
        
            if  pid == 0
                x = -6016
                y = 13728
            elseif  pid == 1
                x = -2144
                y = 13728
            elseif  pid == 2
                x = -2144
                y = 9824
            elseif  pid == 3
                x = -6016
                y = 9824
            endif
        

        SetUnitOwner(tu,Player(PLAYER_NEUTRAL_AGGRESSIVE),true)

        UnitRemoveAbility(tu,'Avul')
        UnitRemoveAbility(tu,'Asid')
        UnitRemoveAbility(tu,'Aneu')
        UnitRemoveAbility(tu,'Apit')

        UnitAddAbility(tu,'AZ99')
        SetUnitAbilityLevel(tu,'AZ99',pid+1)
        EXSetUnitMoveType( tu, 0x02 )
        SetUnitPosition(tu,x,y)

        IssuePointOrderById(tu,851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))

        NewChallengeNum1 = num
        if  num < 10
            SetUnitRealStateOfOtherIdAddValue(tu,'mg00'+num,1.0)
        else
            SetUnitRealStateOfOtherIdAddValue(tu,'mg10',1.0 + (num-10) * 0.4)
        endif
  
    endfunction

    
    function StartAttackUnit()
        int cos = 0
        int gold = 0
        if  StopAttackBool == false
            AttackUnitOrderNum = AttackUnitOrderNum + 1
            if  InfiniteAttackBool == false
                if  AttackUnitType[AttackUnitOrderNum] == 0
                    AttackUnitWN = AttackUnitWN + 1
                    CreateUnitTimer(AttackUnitOrderNum)
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
                        cos = 0
                        gold = 0
                        cos = 100*AttackUnitWN
                        if  cos > 30000
                            cos = 30000
                        endif
                        AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,cos)
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r敌军发起进攻，每人获得"+I2S(cos)+"金币奖励。")
                        if  GetPlayerTechCount(Player(pid),'RY4D',true) == 1 and GameSaveClose == 0
                            if  ModuloInteger(AttackUnitWN,3) == 0
                                if  AttackUnitWN == 3
                                    gold = 3000
                                elseif  AttackUnitWN == 6
                                    gold = 6000
                                elseif  AttackUnitWN == 9
                                    gold = 10000
                                elseif  AttackUnitWN == 12
                                    gold = 15000
                                elseif  AttackUnitWN == 15
                                    gold = 20000
                                elseif  AttackUnitWN == 18
                                    gold = 25000
                                elseif  AttackUnitWN == 21
                                    gold = 30000
                                endif
                                if  DzPlayerLv(Player(pid)) >= 22 and DzShop(Player(pid),"CH1") == true
                                    if   GetPlayerTechCount(Player(pid),'RSHE',true) == 1
                                        gold = gold * 2
                                    else
                                        gold = gold * 3 / 2
                                    endif
                                endif

                                if  gold > 0
                                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,gold)
                                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[商城-鼠年大吉]：|r进攻怪来袭，为您发放|cffffff80"+I2S(gold)+"金币|r！")
                                endif
                            endif
                        endif
                        /*
                        if  GetPlayerTechCount(Player(pid),'RJ1Z',true) == 1
                            if  ModuloInteger(AttackUnitWN,3) == 0
                                UnitAddPoolItemShow.execute(Pu[1],16)
                            endif
                        endif
                        */

                    endif
                end     

                if  GameMode != 4
                    if  ModuloInteger(AttackUnitWN,3) == 0
                        ReExShop()
                    endif
                endif

                
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

    function PlayerAttackUnitWin(int pid)
        real ran = 0
        int jf = 0
        int jfadd = 0
        if  GameSaveClose == 1
            AddDzPlayerData(pid,2,8,1) //全民竞速
            AddDzPlayerData(pid,3,1,1) //总通关次数
        else
            if  GameMode < 3
                AddDzPlayerData(pid,3,1,1) //总通关次数
                AddDzPlayerData(pid,3,GameLevel+1,1) //通关难度次数

                if  GameMode == 2
                    AddDzPlayerData(pid,17,1,1) //疯狂总通关次数
                    AddDzPlayerData(pid,17,GameLevel+1,1) //疯狂通关难度次数
                endif
                
                    

                jfadd = 10*GameLevel
                jfadd = R2I(I2R(jfadd)*(1+DzConA[11]*0.5))
                AddDzPlayerData(pid,2,1,jfadd) //通关积分

                if  GameMode == 1
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|cff00ff00游戏已通关，奖励"+I2S(jfadd)+"点通关积分！|r")
                elseif  GameMode == 2
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|cff00ff00游戏已通关，奖励"+I2S(jfadd)+"点通关积分(疯狂模式+50%)！|r")
                endif
            elseif  GameMode == 3
                AddDzPlayerData(pid,20,1,1) //异变总通关次数
                AddDzPlayerData(pid,20,GameLevel-2,1) //异变通关难度次数

                jfadd = 10*(GameLevel-3)
                jfadd = R2I(I2R(jfadd)*(1+DzConA[11]*0.5))
                AddDzPlayerData(pid,2,4,jfadd) //异变积分

                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|cff00ff00游戏已通关，奖励"+I2S(jfadd)+"点异变积分！|r")
            endif

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

            SaveDzRoom(pid) //刷新房间显示

            BuryingPointData(pid,1,GameLevel,1)//通关埋点
            if  GetUnitTypeId(Pu[1]) == 'H030'
                BuryingPointData(pid,8,1,1)//后羿埋点
            else
                BuryingPointData(pid,8,0,1)//非后羿埋点
            endif
        endif
    endfunction
    
    function AttackUnitWin()
        
        if  GameWinBoolJu == false
            GameWinBoolJu = true
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在60秒内结束！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在60秒内结束！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在60秒内结束！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在60秒内结束！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"|cffffcc00[系统]：|r|cffff0000游戏已通关！游戏将在60秒内结束！|r")
            if  GameSaveClose == 1
                RePKUI()
            endif
            ExecuteFunc("CreateMeridiansNPC")
            ExecuteFunc("GameWin")
            
            for pid = 0,5
                if  IsPlaying(pid) == true
                    //存档
                    PlayerAttackUnitWin.execute(pid)
                endif
            end
        endif
    endfunction
    
    function GameWin()
        int time = 0
        TimerStart(1,true)
        {
            if  time < 60
                time = time + 1
                if  time == 50
                    for pid = 0,5
                        if  IsPlaying(pid) == true
                            Dialog.create(Player(pid),"|cffff0000游戏已通关！|r\n游戏将在10秒内结束！","确定","","","","","","","","","","","","")
                        endif
                    end
                elseif  time == 55
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
