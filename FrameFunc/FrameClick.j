scope FrameButton

    


    func FrameFunc(int pid,int frame,int eventId)
        int Type = GetFrameType(frame)
        int id = Frame2Id(frame)
        
        if  eventId == 1
            if  Pu[1] != null
                //BJDebugMsg(I2S(id))
                if  Type == TYPE_BUTTON
                    if  id >= 1 and id <= 17//法宝
                        SelectPlayerMagicItem(pid,id)
                    elseif  id == 21//重铸
                        RecastPlayerMagicItem(pid)
                    elseif  id == 22//锻造
                        ForgePlayerMagicItem(pid)
                        
                    elseif  id >= 101 and id <= 103//选择备选学习技能
                        PlayerSelectLearnAbility(pid,id-100)
                    elseif  id >= 111 and id <= 113//选择备选学习技能
                        PlayerSelectLearnAbility(pid,id-110)
                        
                    elseif  id >= 121 and id <= 123//选择要替换的技能
                        PlayerReplaceAbility(pid,id-120)
                    elseif  id >= 131 and id <= 133//选择要替换的技能
                        PlayerReplaceAbility(pid,id-130)
                        
                    elseif  id == 310//刷新时渊奖励
                        RePlayerAllExPlotPrize(pid)
                    elseif  id == 401 or id == 402
                        PlayerClickPrize(pid,0)
                    elseif  id >= 411 and id <= 413//选择奖励
                        PlayerClickPrize(pid,id-410)
                    elseif  id >= 421 and id <= 423//选择奖励
                        PlayerClickPrize(pid,id-420)
                        
                        
                    elseif  id >= 581 and id <= 590
                        SetPlayerShowSavePage(pid,id-581)
                    
                    elseif  id == 655//签到
                        if  GameTime >= 300
                            TimerMissionAddNumFunc(pid,1,1)
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]:|r游戏开局5分钟后可以签到！")
                        endif
                    elseif  id == 661 //通行证翻页
                        PassFreamClickLast(pid)
                    elseif  id == 662 //通行证翻页
                        PassFreamClickNext(pid)
                    elseif  id == 702 //F2
                        if  PlayerDeathBool == false
                            HeroMoveToHome(pid)
                        endif
                    elseif  id == 703 //F3
                        if  PlayerDeathBool == false 
                            HeroMoveToRoom(pid)
                        endif
                    elseif  id == 704 //F4
                        ClickCollectFrame(pid)
                    elseif  id == 705 //F5
                        ClickShowSaveFrame(pid)
                    elseif  id == 706 //F6
                        ClickPassFrame(pid)
                    endif
                elseif  Type == TYPE_FUNC
                    if  id >= 301 and id <= 308//选择副本按钮
                        //PlayerTestPlot(pid,id-300)
                        OpenGameChallenge(pid,id-300,GetPlayerPlotType(pid))
                    
                    elseif  id >= 311 and id <= 318//选择副本按钮
                        //PlayerTestPlot(pid,id-310)
                        OpenGameChallenge(pid,id-310,GetPlayerPlotType(pid))
                    endif
                elseif  Type == TYPE_CLOSE
                    if  id == 410
                        PlayerClickPrize(pid,0)
                    endif
                endif
            endif
        elseif  eventId == 6
            int whell = PlayerMouseWhell
            BJDebugMsg("玩家"+I2S(pid)+"&"+I2S(id)+"whell"+I2S(whell))
            if  id >= 501 and id <= 600
                PlayerWheelShowSaveFrame(pid,whell)
            endif
        endif
    endfunction
endscope




//! textmacro AddFrameFunc takes value
    function FrameFuncExecute1n$value$ takes nothing returns nothing
        FrameFunc(GetPlayerId(DzGetTriggerUIEventPlayer()),Id2Frame($value$),1)
    endfunction
    function FrameFuncExecute12n$value$ takes nothing returns nothing
        FrameFunc(GetPlayerId(DzGetTriggerUIEventPlayer()),Id2Frame($value$),12)
    endfunction
    function FrameFuncExecute6n$value$ takes nothing returns nothing
        FrameFunc(GetPlayerId(DzGetTriggerUIEventPlayer()),Id2Frame($value$),6)
    endfunction
//! endtextmacro



//法宝
//! runtextmacro AddFrameFunc("1")
//! runtextmacro AddFrameFunc("2")
//! runtextmacro AddFrameFunc("3")
//! runtextmacro AddFrameFunc("4")
//! runtextmacro AddFrameFunc("5")
//! runtextmacro AddFrameFunc("6")
//! runtextmacro AddFrameFunc("7")
//! runtextmacro AddFrameFunc("8")
//! runtextmacro AddFrameFunc("9")
//! runtextmacro AddFrameFunc("10")
//! runtextmacro AddFrameFunc("11")
//! runtextmacro AddFrameFunc("12")
//! runtextmacro AddFrameFunc("13")
//! runtextmacro AddFrameFunc("14")
//! runtextmacro AddFrameFunc("15")
//! runtextmacro AddFrameFunc("16")
//! runtextmacro AddFrameFunc("17")

//! runtextmacro AddFrameFunc("21")
//! runtextmacro AddFrameFunc("22")


//! runtextmacro AddFrameFunc("101")
//! runtextmacro AddFrameFunc("102")
//! runtextmacro AddFrameFunc("103")

//! runtextmacro AddFrameFunc("111")
//! runtextmacro AddFrameFunc("112")
//! runtextmacro AddFrameFunc("113")

//! runtextmacro AddFrameFunc("121")
//! runtextmacro AddFrameFunc("122")
//! runtextmacro AddFrameFunc("123")

//! runtextmacro AddFrameFunc("131")
//! runtextmacro AddFrameFunc("132")
//! runtextmacro AddFrameFunc("133")

//151-160 境界丹


//! runtextmacro AddFrameFunc("301")
//! runtextmacro AddFrameFunc("302")
//! runtextmacro AddFrameFunc("303")
//! runtextmacro AddFrameFunc("304")
//! runtextmacro AddFrameFunc("305")
//! runtextmacro AddFrameFunc("306")
//! runtextmacro AddFrameFunc("307")
//! runtextmacro AddFrameFunc("308")

//! runtextmacro AddFrameFunc("310")
//! runtextmacro AddFrameFunc("311")
//! runtextmacro AddFrameFunc("312")
//! runtextmacro AddFrameFunc("313")
//! runtextmacro AddFrameFunc("314")
//! runtextmacro AddFrameFunc("315")
//! runtextmacro AddFrameFunc("316")
//! runtextmacro AddFrameFunc("317")
//! runtextmacro AddFrameFunc("318")


//! runtextmacro AddFrameFunc("401")
//! runtextmacro AddFrameFunc("402")
//esc
//! runtextmacro AddFrameFunc("410")
//! runtextmacro AddFrameFunc("411")
//! runtextmacro AddFrameFunc("412")
//! runtextmacro AddFrameFunc("413")

//! runtextmacro AddFrameFunc("421")
//! runtextmacro AddFrameFunc("422")
//! runtextmacro AddFrameFunc("423")



//! runtextmacro AddFrameFunc("501")
//! runtextmacro AddFrameFunc("502")
//! runtextmacro AddFrameFunc("503")
//! runtextmacro AddFrameFunc("504")
//! runtextmacro AddFrameFunc("505")
//! runtextmacro AddFrameFunc("506")
//! runtextmacro AddFrameFunc("507")
//! runtextmacro AddFrameFunc("508")
//! runtextmacro AddFrameFunc("509")
//! runtextmacro AddFrameFunc("510")
//! runtextmacro AddFrameFunc("511")
//! runtextmacro AddFrameFunc("512")
//! runtextmacro AddFrameFunc("513")
//! runtextmacro AddFrameFunc("514")
//! runtextmacro AddFrameFunc("515")
//! runtextmacro AddFrameFunc("516")


//! runtextmacro AddFrameFunc("580")
//! runtextmacro AddFrameFunc("581")
//! runtextmacro AddFrameFunc("582")
//! runtextmacro AddFrameFunc("583")
//! runtextmacro AddFrameFunc("584")
//! runtextmacro AddFrameFunc("585")
//! runtextmacro AddFrameFunc("586")
//! runtextmacro AddFrameFunc("587")


//通行证签到
//! runtextmacro AddFrameFunc("655")


//! runtextmacro AddFrameFunc("661")
//! runtextmacro AddFrameFunc("662")

//辅助按钮
//! runtextmacro AddFrameFunc("701")
//! runtextmacro AddFrameFunc("702")
//! runtextmacro AddFrameFunc("703")
//! runtextmacro AddFrameFunc("704")
//! runtextmacro AddFrameFunc("705")
//! runtextmacro AddFrameFunc("706")
//! runtextmacro AddFrameFunc("707")
//! runtextmacro AddFrameFunc("708")
