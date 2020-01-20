library ServerTime initializer UpdateTimeAll uses ejtimer
    
        int NS = 31536000
        int LS = 31622400	
        int BJTIME = 28800
        int BASE2015_SEC = 1451606400
        int BASE2015_WEEKDAY = 4
        
        boolean bIsInit = false
        int ServerTime = 0
        int array NormalMon
        string array DayStr

        int DzPuTime = 0
        int DzMissionWeek = 0
        int GamePuOverDay = 0
        int MeridiansDay = 0

        int TimeTestDay = 0
        int TimeMon = 0
        int TimeWeek = 0
        int TimeDay = 0
        int TimeHour = 0
        int TimeMin = 0
        int TimeSec = 0
        int TimeYear = 0
        function InitArray()
            NormalMon[1] = 31
            NormalMon[2] = 28
            NormalMon[3] = 31
            NormalMon[4] = 30
            NormalMon[5] = 31
            NormalMon[6] = 30
            NormalMon[7] = 31
            NormalMon[8] = 31
            NormalMon[9] = 30
            NormalMon[10] = 31
            NormalMon[11] = 30
            NormalMon[12] = 31
            DayStr[0] = "日"
            DayStr[1] = "一"
            DayStr[2] = "二"
            DayStr[3] = "三"
            DayStr[4] = "四"
            DayStr[5] = "五"
            DayStr[6] = "六"
        endfunction
        function MathMod(int dividend,int divisor)->int
            int modulus = dividend - (dividend / divisor) * divisor
            if modulus < 0
                modulus = modulus + divisor
            endif
            return modulus
        endfunction
        function MathFloor(real a)->int
            return R2I(a)
        endfunction
        function IsLeapYear(int y)->boolean
            if MathMod(y,4) == 0
                if MathMod(y,100) == 0
                    if MathMod(y,400) == 0
                        return true
                    else
                        return false
                    endif
                endif
                return true
            endif
            return false
        endfunction
        function Time_UpdateDate(int y,int remainSec,int dayBy2015)
            boolean bIsLeap = IsLeapYear(y)
            real dayNum = I2R(remainSec) / (24*60*60)
            int totalDay = MathFloor(dayNum)
            int totalDayBase = 0
            int totalMonDay = 0
            int curMonDay = 0
            int m = 1
            if (dayNum - I2R(totalDay)) > 0
                totalDay = totalDay + 1
            endif
            if totalDay == 0
                totalDay = 1
            endif
            dayBy2015 = dayBy2015 + totalDay
            loop
            exitwhen m > 12
                if bIsLeap and m == 2 
                    curMonDay = NormalMon[m] + 1
                else
                    curMonDay = NormalMon[m]
                endif
                if totalDay <= curMonDay
                    TimeYear = y
                    TimeMon = m
                    TimeDay = totalDay
                    TimeHour = MathMod(MathFloor(remainSec/(60*60) ), 24)
                    TimeMin = MathMod(MathFloor(remainSec/60) , 60 )
                    TimeSec = MathMod(remainSec , 60)
                    m = 100
                endif
                m = m + 1
                totalDay = totalDay - curMonDay
            endloop
            TimeWeek = MathMod( MathMod(dayBy2015,7) + BASE2015_WEEKDAY, 7 )
        endfunction
        function GetDate(int now)
            int remain = now - BASE2015_SEC + BJTIME// 默认东八区
            int y = 2016
            int baseRemain = 0
            int dayBy2015 = 0
            int baseDayBy2015 = 0
            loop
            exitwhen y > 3000
                baseRemain = remain
                baseDayBy2015 = dayBy2015
                if IsLeapYear(y)
                    remain = remain - LS
                    dayBy2015 = dayBy2015 + 366
                else
                    remain = remain - NS
                    dayBy2015 = dayBy2015 + 365
                endif
                if remain < 0
                    Time_UpdateDate(y, baseRemain, baseDayBy2015)
                    y = 10000
                endif
                y = y + 1
            endloop
        endfunction
        
        function ServerTimeDeBugEx()->string
            return I2S(TimeYear) + "年" + I2S(TimeMon)+"月"+ I2S(TimeDay)+"日"+ I2S(TimeHour)+"时"+ I2S(TimeMin)+"分"+ I2S(TimeSec)+"秒"
        endfunction
        function ServerTimeDeBug()->string
            return "|cffffcc00[北京时间]:|r" + I2S(TimeYear) + "年" + I2S(TimeMon)+"月"+ I2S(TimeDay)+"日"+ I2S(TimeHour)+"时"+ I2S(TimeMin)+"分"+ I2S(TimeSec)+"秒["+"星期" + DayStr[TimeWeek] + "]"
        endfunction
        
        function UpdateTimeAllTimer() //一秒计时器运行这个
            ServerTime = ServerTime + 1
            GetDate(ServerTime)
        endfunction
        function UpdateTimeAll() //初始化
            InitArray()
            DzPuTime = 1578412800
            ServerTime = DzAPI_Map_GetGameStartTime()
            if  ServerTime < DzPuTime
                ServerTime = DzPuTime + 86400 * 6
            endif
            
            ServerTime = ServerTime + GetRandomInt(1,10)

            ServerTime = ServerTime - 18000
            GetDate(ServerTime)

            DzMissionWeek = TimeWeek
            MissionDay = (ServerTime-DzPuTime)/86400
            if  MissionDay < 0
                MissionDay = 0
            endif

            ServerTime = ServerTime + 18000
            GetDate(ServerTime)

            StartTimeYear = TimeYear
            StartTimeMon = TimeMon
            StartTimeDay = TimeDay
            GamePuOverDay = (ServerTime-DzPuTime)/86400
            if  GamePuOverDay < 0
                GamePuOverDay = 0
            endif

            MeridiansDay = (ServerTime-1578412800)/86400 //经脉日
            if  MeridiansDay < 0
                MeridiansDay = 0
            endif

            BJDebugMsg.execute("初始化天数 已发布：："+I2S(GamePuOverDay))
            BJDebugMsg.execute("初始化天数 通行证：："+I2S(MissionDay))
            
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,ServerTimeDeBug())
        endfunction
        
    endlibrary