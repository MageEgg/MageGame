scope FrameButton

    


    func FrameFunc(int pid,int frame,int eventId)
        int Type = GetFrameType(frame)
        int id = Frame2Id(frame)
        
        if  eventId == 1
            if  Pu[1] != null
                BJDebugMsg(I2S(id))
                if  Type == TYPE_BUTTON
                    if  id >= 1 and id <= 17//法宝
                        SelectPlayerMagicItem(pid,id)
                    elseif  id == 21//重铸
                        RecastPlayerMagicItem(pid)
                    elseif  id == 22//锻造
                        ForgePlayerMagicItem(pid)
                    elseif  id == 25//出售
                        SalePlayerMagicItem(pid)
                        
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
                        
                    elseif  id >= 501 and id <= 516//存档的按钮
                        PlayerClickShowSaveFrame(pid,id-500)
                    elseif  id >= 581 and id <= 590
                        SetPlayerShowSavePage(pid,id-581)
                    
                    elseif  id == 655//签到
                        if  GameSaveClose == 0
                            if  GameTime >= 60
                                TimerMissionAddNumFunc(pid,1,1)
                                DzPalyerSignIn(pid)
                            else
                                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r游戏开局1分钟后可以签到！")
                            endif
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r该模式下无法签到！")
                        endif
                    elseif  id == 661 //通行证翻页
                        PassFreamClickLast(pid)
                    elseif  id == 662 //通行证翻页
                        PassFreamClickNext(pid)
                    elseif  id >= 671 and id <= 679//通行证选择
                        PassFreamClickNextStep(pid,id - 671)
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
                    elseif  id == 709
                        ClickButtonWXBZ(pid)
                    elseif  id >= 751 and id <= 756
                        PlayerClickGemItem(pid,id-750)
                    elseif  id >= 911 and id <=913//符印奖励
                        PlayerClickRunePrize(pid,id-910)
                    elseif  id >= 921 and id <=923//符印奖励
                        PlayerClickRunePrize(pid,id-920)
                    elseif  id == 920//符印重随
                        ClickReRunePrizeFrame(pid)
                    elseif  id >= 931 and id <= 933//道果奖励
                        PlayerClickDGPrize(pid,id-930)
                    elseif  id >= 941 and id <= 943//道果奖励
                        PlayerClickDGPrize(pid,id-940)
                    elseif  id == 420//副本重随
                        ClickRePrizeFrame(pid)
                    elseif  id == 950//重随
                        ReHeroPrePare(pid)
                    endif
                elseif  Type == TYPE_FUNC
                    if  id >= 301 and id <= 308//选择副本按钮
                        //PlayerTestPlot(pid,id-300)
                        OpenGameChallenge(pid,id-300,GetPlayerPlotType(pid))
                    
                    elseif  id >= 311 and id <= 318//选择副本按钮
                        //PlayerTestPlot(pid,id-310)
                        OpenGameChallenge(pid,id-310,GetPlayerPlotType(pid))
                    
                    elseif  id >= 951 and id <= 966
                        if  GameChallengePlayerBool[pid][0] == false
                            ReHeroPrePareByPool(pid,id-950)
                        else
                            if  ReHeroButton.show == true    
                                ReHeroButton.show = false
                            endif
                            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r接取任务后无法更换英雄!")
                        endif
                    endif
                elseif  Type == TYPE_CLOSE
                    if  id == 410
                        PlayerClickPrize(pid,0)
                    elseif  id == 910
                        PlayerClickRunePrize(pid,1)
                    endif
                endif
            elseif  GameSaveClose == 1
                if  id >= 951 and id <= 966
                    if  GameChallengePlayerBool[pid][0] == false
                        ReHeroPrePareByPoolEx(pid,id-950)
                    else
                        if  ReHeroButton.show == true    
                            ReHeroButton.show = false
                        endif
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r接取任务后无法更换英雄!")
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
//! runtextmacro AddFrameFunc("25")


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

//重置按钮
//! runtextmacro AddFrameFunc("420")

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
//! runtextmacro AddFrameFunc("588")


//通行证签到
//! runtextmacro AddFrameFunc("655")
//! runtextmacro AddFrameFunc("661")
//! runtextmacro AddFrameFunc("662")

//! runtextmacro AddFrameFunc("671")
//! runtextmacro AddFrameFunc("672")
//! runtextmacro AddFrameFunc("673")
//! runtextmacro AddFrameFunc("674")
//! runtextmacro AddFrameFunc("675")

//辅助按钮
//! runtextmacro AddFrameFunc("701")
//! runtextmacro AddFrameFunc("702")
//! runtextmacro AddFrameFunc("703")
//! runtextmacro AddFrameFunc("704")
//! runtextmacro AddFrameFunc("705")
//! runtextmacro AddFrameFunc("706")
//! runtextmacro AddFrameFunc("707")
//! runtextmacro AddFrameFunc("708")

//! runtextmacro AddFrameFunc("709")

//! runtextmacro AddFrameFunc("751")
//! runtextmacro AddFrameFunc("752")
//! runtextmacro AddFrameFunc("753")
//! runtextmacro AddFrameFunc("754")
//! runtextmacro AddFrameFunc("755")
//! runtextmacro AddFrameFunc("756")


//重置按钮910-923  910esc  920Re
//! runtextmacro AddFrameFunc("910")
//! runtextmacro AddFrameFunc("911")
//! runtextmacro AddFrameFunc("912")
//! runtextmacro AddFrameFunc("913")

//! runtextmacro AddFrameFunc("920")

//! runtextmacro AddFrameFunc("921")
//! runtextmacro AddFrameFunc("922")
//! runtextmacro AddFrameFunc("923")

//重置按钮930-943  930esc  940Re
//! runtextmacro AddFrameFunc("930")
//! runtextmacro AddFrameFunc("931")
//! runtextmacro AddFrameFunc("932")
//! runtextmacro AddFrameFunc("933")

//! runtextmacro AddFrameFunc("940")

//! runtextmacro AddFrameFunc("941")
//! runtextmacro AddFrameFunc("942")
//! runtextmacro AddFrameFunc("943")

//重随英雄
//! runtextmacro AddFrameFunc("950")
//! runtextmacro AddFrameFunc("951")
//! runtextmacro AddFrameFunc("952")
//! runtextmacro AddFrameFunc("953")
//! runtextmacro AddFrameFunc("954")
//! runtextmacro AddFrameFunc("955")
//! runtextmacro AddFrameFunc("956")
//! runtextmacro AddFrameFunc("957")
//! runtextmacro AddFrameFunc("958")
//! runtextmacro AddFrameFunc("959")
//! runtextmacro AddFrameFunc("960")
//! runtextmacro AddFrameFunc("961")
//! runtextmacro AddFrameFunc("962")
//! runtextmacro AddFrameFunc("963")
//! runtextmacro AddFrameFunc("964")
//! runtextmacro AddFrameFunc("965")
//! runtextmacro AddFrameFunc("966")


