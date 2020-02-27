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
      


    function InitExNativeFrame()
        IncEquipModel = FRAME.create()

        IncEquipModel.frameid = FRAME.Tag("SPRITE","IncEquipModel",GameUI,IncEquipModel)
        IncEquipModel.SetPoint(4,DzFrameGetItemBarButton(0),2,0.01,-0.02)
        IncEquipModel.SetSize(0.000001,0.000001)
        


        for i = 0,5
            CreateModelEx(801+i,GameUI,TYPE_NOT,4,DzFrameGetItemBarButton(i),6,-0.004,-0.004,"")
        end

    endfunction
endlibrary
