scope FrameButton
    func FrameFunc(int pid,int frame,int eventId)
        int Type = GetFrameType(frame)
        int id = Frame2Id(frame)
        BJDebugMsg(I2S(id))
        if  Pu[1] != null
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
                    
                
                    
                elseif  id >= 411 and id <= 413//选择奖励
                    PlayerClickPrize(pid,id-410)
                elseif  id >= 421 and id <= 423//选择奖励
                    PlayerClickPrize(pid,id-420)
                    
                    
                elseif  id >= 581 and id <= 590
                    SetPlayerShowSavePage(pid,id-581)
                elseif  id == 661 //通行证翻页
                    PassFreamClickLast(pid)
                elseif  id == 662 //通行证翻页
                    PassFreamClickNext(pid)
                endif
            elseif  Type == TYPE_FUNC
                if  id >= 301 and id <= 308//选择副本按钮
                    PlayerTestPlot(pid,id-300)
                elseif  id >= 311 and id <= 318//选择副本按钮
                    PlayerTestPlot(pid,id-310)
                endif
            endif
        endif
    end
endscope


//! textmacro AddFrameFunc takes value
    function FrameFuncExecute1n$value$ takes nothing returns nothing
        FrameFunc(GetPlayerId(DzGetTriggerUIEventPlayer()),Id2Frame($value$),1)
    endfunction
    function FrameFuncExecute12n$value$ takes nothing returns nothing
        FrameFunc(GetPlayerId(DzGetTriggerUIEventPlayer()),Id2Frame($value$),12)
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

//! runtextmacro AddFrameFunc("311")
//! runtextmacro AddFrameFunc("312")
//! runtextmacro AddFrameFunc("313")
//! runtextmacro AddFrameFunc("314")
//! runtextmacro AddFrameFunc("315")
//! runtextmacro AddFrameFunc("316")
//! runtextmacro AddFrameFunc("317")
//! runtextmacro AddFrameFunc("318")

//! runtextmacro AddFrameFunc("411")
//! runtextmacro AddFrameFunc("412")
//! runtextmacro AddFrameFunc("413")

//! runtextmacro AddFrameFunc("421")
//! runtextmacro AddFrameFunc("422")
//! runtextmacro AddFrameFunc("423")


//! runtextmacro AddFrameFunc("581")
//! runtextmacro AddFrameFunc("582")
//! runtextmacro AddFrameFunc("583")
//! runtextmacro AddFrameFunc("584")
//! runtextmacro AddFrameFunc("585")
//! runtextmacro AddFrameFunc("586")
//! runtextmacro AddFrameFunc("587")


//! runtextmacro AddFrameFunc("661")
//! runtextmacro AddFrameFunc("662")

