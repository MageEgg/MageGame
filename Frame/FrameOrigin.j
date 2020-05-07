library OriginGameFrame uses ejtimer,System
    //关于控件锚点的预设
    integer Frame_TopLeft = 0
    integer Frame_Top = 1
    integer Frame_TopRight = 2
    integer Frame_Left = 3
    integer Frame_Center = 4
    integer Frame_Right = 5
    integer Frame_BottomLeft = 6
    integer Frame_Bottom = 7
    integer Frame_BottomRight = 8
    
    //关于控件事件的函数
    integer Frame_EVENT_NONE = 0
    integer Frame_EVENT_PRESSED = 1 //按着不放
    integer Frame_EVENT_MOUSE_ENTER = 2 //左键点击
    integer Frame_EVENT_MOUSE_LEAVE = 3 //鼠标离开
    integer Frame_EVENT_MOUSE_UP = 4
    integer Frame_EVENT_MOUSE_DOWN = 5
    integer Frame_EVENT_MOUSE_WHEEL = 6
    integer Frame_EVENT_FOCUS_ENTER = Frame_EVENT_MOUSE_ENTER
    integer Frame_EVENT_FOCUS_LEAVE = Frame_EVENT_MOUSE_LEAVE
    integer Frame_EVENT_CHECKBOX_CHECKED = 7
    integer Frame_EVENT_CHECKBOX_UNCHECKED = 8
    integer Frame_EVENT_EDITBOX_TEXT_CHANGED = 9
    integer Frame_EVENT_POPUPMENU_ITEM_CHANGE_START = 10
    integer Frame_EVENT_POPUPMENU_ITEM_CHANGED = 11
    integer Frame_EVENT_MOUSE_DOUBLECLICK = 12
    integer Frame_EVENT_SPRITE_ANIM_UPDATE = 13
    //控件类型
    int TYPE_NULL = 0
    int TYPE_BUTTON = 1
    int TYPE_FUNC = 2
    int TYPE_CLOSE = 9
    int TYPE_NOT = 99
    


    function GetResourceBarFrame takes integer index returns integer
        if  index == 0 then
            return DzSimpleFontStringFindByName("ResourceBarGoldText",0)
        elseif  index == 1 then
            return DzSimpleFontStringFindByName("ResourceBarLumberText",0)
        elseif  index == 2 then
            return DzSimpleFontStringFindByName("ResourceBarSupplyText",0)
        elseif  index == 3 then
            return DzSimpleFontStringFindByName("ResourceBarUpkeepText",0)
        endif
        return 0
    endfunction
    

    //获取物品名称
    function GetFrameItemNameFrame takes nothing returns integer
        return DzSimpleFontStringFindByName("SimpleItemNameValue",3)
    endfunction 
    //获取物品说明
    function GetFrameItemTipsFrame takes nothing returns integer
        return DzSimpleFontStringFindByName("SimpleItemDescriptionValue",3)
    endfunction
    
    

    //英雄面板父对象
    function GetFrameHeroStatePanelFrame takes nothing returns integer
        return DzSimpleFrameFindByName("SimpleInfoPanelIconDamage", 0)
    endfunction 
    //英雄主属性父对象
    function GetFrameHeroPanel takes nothing returns integer
        return DzSimpleFrameFindByName("SimpleInfoPanelIconHero", 6)
    endfunction
    
    
    //获取单位名称
    function GetFrameUnitNameFrame takes nothing returns integer
        return DzSimpleFontStringFindByName("SimpleNameValue",0)
    endfunction 
    //获取英雄称谓
    function GetFrameUnitClassFrame takes nothing returns integer
        return DzSimpleFontStringFindByName("SimpleClassValue",0)
    endfunction
    
    
    
    //获取单位攻击图标
    function GetFrameUnitAttackIcon takes integer index returns integer
        return DzSimpleTextureFindByName("InfoPanelIconBackdrop",index)
    endfunction
    //单位攻击标签
    function GetFrameUnitAttackLabel takes integer index returns integer
        return DzSimpleFontStringFindByName("InfoPanelIconLabel",index)
    endfunction
    //单位攻击数值
    function GetFrameUnitAttackValue takes integer index returns integer
        return DzSimpleFontStringFindByName("InfoPanelIconValue",index)
    endfunction
    
    //获取单位护甲图标
    function GetFrameUnitArmorIcon takes nothing returns integer
        return DzSimpleTextureFindByName("InfoPanelIconBackdrop",2)
    endfunction
    //单位护甲标签
    function GetFrameUnitArmorLabel takes nothing returns integer
        return DzSimpleFontStringFindByName("InfoPanelIconLabel",2)
    endfunction
    //单位护甲数值
    function GetFrameUnitArmorValue takes nothing returns integer
        return DzSimpleFontStringFindByName("InfoPanelIconValue",2)
    endfunction
    
    //获取金矿黄金图标
    function GetFrameUnitAttack2Icon takes nothing returns integer
        return DzSimpleTextureFindByName("InfoPanelIconBackdrop",5)
    endfunction
    
    
    //英雄主属性图标
    function GetFrameHeroPanelIcon takes nothing returns integer
        return DzSimpleTextureFindByName("InfoPanelIconHeroIcon", 6)
    endfunction
    
    
    //获取生命周期条
    function GetFrameProgressBar takes nothing returns integer
        return DzSimpleFrameFindByName("SimpleProgressIndicator", 0)
    endfunction
    //获取英雄经验条
    function GetFrameHeroLevelBar takes nothing returns integer
        return DzSimpleFrameFindByName("SimpleHeroLevelBar", 0)
    endfunction
    
    //英雄属性数值
    function GetFrameHeroStrValue takes nothing returns integer
        return DzSimpleFontStringFindByName("InfoPanelIconHeroStrengthValue",6)
    endfunction
    function GetFrameHeroAgiValue takes nothing returns integer
        return DzSimpleFontStringFindByName("InfoPanelIconHeroAgilityValue",6)
    endfunction
    function GetFrameHeroIntValue takes nothing returns integer
        return DzSimpleFontStringFindByName("InfoPanelIconHeroIntellectValue",6)
    endfunction
    
    //英雄属性标签
    function GetFrameHeroStrLabel takes nothing returns integer
        return DzSimpleFontStringFindByName("InfoPanelIconHeroStrengthLabel",6)
    endfunction
    function GetFrameHeroAgiLabel takes nothing returns integer
        return DzSimpleFontStringFindByName("InfoPanelIconHeroAgilityLabel",6)
    endfunction
    function GetFrameHeroIntLabel takes nothing returns integer
        return DzSimpleFontStringFindByName("InfoPanelIconHeroIntellectLabel",6)
    endfunction
    
    //英雄属性标签 带参数
    function GetFrameHeroStateLabel takes integer index returns integer
        if index == 1
            return GetFrameHeroStrLabel()
        elseif index == 2
            return GetFrameHeroAgiLabel()
        elseif index == 3
            return GetFrameHeroIntLabel()
        endif
        return 0
    endfunction
    //英雄属性数值 带参数
    function GetFrameHeroStateValue takes integer index returns integer
        if index == 1
            return GetFrameHeroStrValue()
        elseif index == 2
            return GetFrameHeroAgiValue()
        elseif index == 3
            return GetFrameHeroIntValue()
        endif
        return 0
    endfunction
    
    
    //未知
    function GetFrameUnitStatePanelFrame takes nothing returns integer
        return DzSimpleFrameFindByName("SimpleInfoPanelIconHeroText", 6)
    endfunction 
    function GetFrameUnitDetail takes nothing returns integer
        return DzSimpleFrameFindByName("SimpleInfoPanelUnitDetail", 0)
    endfunction
    
endlibrary
