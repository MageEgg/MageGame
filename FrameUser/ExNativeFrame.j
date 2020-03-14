library ExNativeFrame uses GameFrame
    FRAME IncEquipModel = 0

    function IncEquipModelFunc(int pid,int index)
        if  GetLocalPlayer() == Player(pid)
            if  index == 1
                IncEquipModel.SetModel("war3mapImported\\ui_win.mdx",1,0)
            else
                IncEquipModel.SetModel("war3mapImported\\ui_lose.mdx",1,0)
            endif
            IncEquipModel.SetAnimate(0,true)
        endif
    endfunction

    function GiveItemShowModel(int pid,int index)
        if  GetLocalPlayer() == Player(pid)
            DzFrameSetModel( BUTTON_Model[701+index], "war3mapImported\\UI-ModalButtonOn.mdx", 0, 0 )
            DzFrameSetAnimate(BUTTON_Model[701+index],0,true)
        endif
    endfunction
      

    function BoxShowRuneFrame(int pid,int index)
        int lv = GetUnitIntState(Pu[1],900+index)
        int id = 'FY00'+index
        DzFrameShow(UI_TipsHead, true)
            
        if  lv > 0
            SetTipsData(1,"","|cffff0000"+GetTypeIdName(id)+"x"+I2S(lv))
        else
            SetTipsData(1,"","|cffff0000"+GetTypeIdName(id)+"|cff808080(未拥有)")
        endif
        
        SetTipsData(10,"",GetTypeIdTips(id))
        
        if  lv >= 3
            SetTipsData(11,"","\n|cff00ff00"+GetTypeIdName(id)+"x3\n"+GetTypeIdString(id,131))
        else
            SetTipsData(11,"","\n|cff808080"+GetTypeIdName(id)+"x3\n"+GetTypeIdString(id,131))
        endif

        if  lv >= 5
            SetTipsData(12,"","\n|cff00ff00"+GetTypeIdName(id)+"x5\n"+GetTypeIdString(id,132))
        else
            SetTipsData(12,"","\n|cff808080"+GetTypeIdName(id)+"x5\n"+GetTypeIdString(id,132))
        endif


        if  GetTypeIdString(id,133)!=""
            SetTipsData(13,"","\n|cff808080"+GetTypeIdString(id,133))
        endif



        ShowTipsUISetPosition(0.0,0.1)
    endfunction

    function ReRuneFrame(int pid)
        int lv = 0
        int index = 0
        if  GetLocalPlayer() == Player(pid)
            for i = 1,8
                index = 900 + i
                lv = GetUnitIntState(Pu[1],900+i)
                if  lv > 0
                    DzFrameSetTexture(BUTTON_Back[index][0],"war3mapImported\\UI_Fuin_Back0"+I2S(i)+".tga",0)
                    DzFrameSetTexture(BUTTON_Back[index][1],"war3mapImported\\UI_Fuin_num"+I2S(lv)+".tga",0)
                else
                    DzFrameSetTexture(BUTTON_Back[index][0],"war3mapImported\\UI_Fuin_DisBack0"+I2S(i)+".tga",0)
                    DzFrameSetTexture(BUTTON_Back[index][1],"war3mapImported\\alpha.tga",0)
                endif
            end
        endif
    endfunction

    function InitExNativeFrame()
        IncEquipModel = FRAME.create()

        IncEquipModel.frameid = FRAME.Tag("SPRITE","IncEquipModel",GameUI,IncEquipModel)
        IncEquipModel.SetPoint(4,DzFrameGetItemBarButton(0),2,0.01,-0.02)
        IncEquipModel.SetSize(0.000001,0.000001)
        


        for i = 0,5
            CreateModelEx(801+i,GameUI,TYPE_NOT,4,DzFrameGetItemBarButton(i),6,-0.004,-0.004,"")
        end



        int index = 0
        for x = 0,2
            for y = 0,2
                index = y * 3 + x + 1
                if  index >= 1 and index <= 8
                    CreateButton(900+index,GameUI,TYPE_BUTTON,4,GameUI,6,0.142+x*0.028,0.08-y*0.028,0.024,0.024,"war3mapImported\\UI_Fuin_DisBack0"+I2S(index)+".tga")

                    DzFrameClearAllPoints(BUTTON_Back[900+index][1])
                    DzFrameSetPoint( BUTTON_Back[900+index][1], 4, BUTTON_Back[900+index][0], 8,-0.005, 0.005 )
                    DzFrameSetSize(BUTTON_Back[900+index][1],0.014,0.014)
                endif
            end
        end

    endfunction
endlibrary
