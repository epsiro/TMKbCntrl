syntax match comment /\/\/.*$/
syntax region String start=+L\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial,@Spell
syntax keyword identifier p_and_P
syntax match Modifier /\(left_\|right_\)\{0,1\}\(shift\|control\|alt\|gui\)/
syntax region Modifiers start=/</ end=/>/ contains=Modifier
syntax match Location / [0-9][A-Z]/

highlight identifier guifg=Blue
highlight Key guifg=Brown
highlight HeadKey guifg=Red
highlight String guifg=Cyan
highlight Modifier guifg=PaleGreen
highlight Modifiers guifg=Orange
highlight Usage guifg=Purple
highlight UsagePage guifg=Green
highlight Location guifg=Yellow

syntax match HeadKey /Keyboard/
syntax match HeadKey /Layout/
syntax match HeadKey /Map/
syntax match HeadKey /Matrix/
syntax match HeadKey /Mode/
syntax match HeadKey /Key/
syntax match HeadKey /KeyDef/
syntax match HeadKey /NilKey/
syntax match HeadKey /Mapping/
syntax match HeadKey /Macro/
syntax match HeadKey /Row/
syntax match HeadKey /Usage/
syntax match HeadKey /UsagePage/
      
syntax match Key /include/
syntax match Key /base/
syntax match Key /rev/
syntax match Key /id/
syntax match Key /led/
syntax match Key /width/
syntax match Key /height/
syntax match Key /background/
syntax match Key /offsetX/
syntax match Key /offsetY/
syntax match Key /tl/
syntax match Key /bl/
syntax match Key /modifiers/
syntax match Key /type/
syntax match Key /section/
syntax match Key /spacing/

syntax match Usage /Undefined/
syntax match Usage /Pointer/
syntax match Usage /Mouse/
syntax match Usage /Joystick/
syntax match Usage /Game_Pad/
syntax match Usage /Keyboard/
syntax match Usage /Keypad/
syntax match Usage /Multi-axis_Controller/
syntax match Usage /Tablet_PC_System_Controls/
syntax match Usage /X/
syntax match Usage /Y/
syntax match Usage /Z/
syntax match Usage /Rx/
syntax match Usage /Ry/
syntax match Usage /Rz/
syntax match Usage /Slider/
syntax match Usage /Dial/
syntax match Usage /Wheel/
syntax match Usage /Hat_switch/
syntax match Usage /Counted_Buffer/
syntax match Usage /Byte_Count/
syntax match Usage /Motion_Wakeup/
syntax match Usage /Start/
syntax match Usage /Select/
syntax match Usage /Vx/
syntax match Usage /Vy/
syntax match Usage /Vz/
syntax match Usage /Vbrx/
syntax match Usage /Vbry/
syntax match Usage /Vbrz/
syntax match Usage /Vno/
syntax match Usage /Feature_Notification/
syntax match Usage /Resolution_Multiplier/
syntax match Usage /System_Control/
syntax match Usage /System_Power_Down/
syntax match Usage /System_Sleep/
syntax match Usage /System_Wake_Up/
syntax match Usage /System_Context_Menu/
syntax match Usage /System_Main_Menu/
syntax match Usage /System_App_Menu/
syntax match Usage /System_Menu_Help/
syntax match Usage /System_Menu_Exit/
syntax match Usage /System_Menu_Select/
syntax match Usage /System_Menu_Right/
syntax match Usage /System_Menu_Left/
syntax match Usage /System_Menu_Up/
syntax match Usage /System_Menu_Down/
syntax match Usage /System_Cold_Restart/
syntax match Usage /System_Warm_Restart/
syntax match Usage /D-pad_Up/
syntax match Usage /D-pad_Down/
syntax match Usage /D-pad_Right/
syntax match Usage /D-pad_Left/
syntax match Usage /System_Dock/
syntax match Usage /System_Undock/
syntax match Usage /System_Setup/
syntax match Usage /System_Break/
syntax match Usage /System_Debugger_Break/
syntax match Usage /Application_Break/
syntax match Usage /Application_Debugger_Break/
syntax match Usage /System_Speaker_Mute/
syntax match Usage /System_Hibernate/
syntax match Usage /System_Display_Invert/
syntax match Usage /System_Display_Internal/
syntax match Usage /System_Display_External/
syntax match Usage /System_Display_Both/
syntax match Usage /System_Display_Dual/
syntax match Usage /System_Display_Toggle_Int\/Ext/
syntax match Usage /System_Display_Swap_Primary\/Secondary/
syntax match Usage /System_Display_LCD_Autoscale/
syntax match Usage /Reserved_(no_event_indicated)/
syntax match Usage /ErrorRollOver/
syntax match Usage /POSTFail/
syntax match Usage /ErrorUndefined/
syntax match Usage /a_and_A/
syntax match Usage /b_and_B/
syntax match Usage /c_and_C/
syntax match Usage /d_and_D/
syntax match Usage /e_and_E/
syntax match Usage /f_and_F/
syntax match Usage /g_and_G/
syntax match Usage /h_and_H/
syntax match Usage /i_and_I/
syntax match Usage /j_and_J/
syntax match Usage /k_and_K/
syntax match Usage /l_and_L/
syntax match Usage /m_and_M/
syntax match Usage /n_and_N/
syntax match Usage /o_and_O/
syntax match Usage /p_and_P/
syntax match Usage /q_and_Q/
syntax match Usage /r_and_R/
syntax match Usage /s_and_S/
syntax match Usage /t_and_T/
syntax match Usage /u_and_U/
syntax match Usage /v_and_V/
syntax match Usage /w_and_W/
syntax match Usage /x_and_X/
syntax match Usage /y_and_Y/
syntax match Usage /z_and_Z/
syntax match Usage /1_and_!/
syntax match Usage /2_and_@/
syntax match Usage /3_and_#/
syntax match Usage /4_and_\$/
syntax match Usage /5_and_%/
syntax match Usage /6_and_^/
syntax match Usage /7_and_&/
syntax match Usage /8_and_\*/
syntax match Usage /9_and_(/
syntax match Usage /0_and_)/
syntax match Usage /Return_(ENTER)/
syntax match Usage /ESCAPE/
syntax match Usage /Backspace/
syntax match Usage /Tab/
syntax match Usage /Spacebar/
syntax match Usage /-_and__/
syntax match Usage /=_and_+/
syntax match Usage /\\\[_and_\\{/
syntax match Usage /\\\]_and_\\}/
syntax match Usage /\\_and_|/
syntax match Usage /Non-US_#_and_\~/
syntax match Usage /;_and_\\:/
syntax match Usage /\\'_and_\\"/
syntax match Usage /`_and_\~/
syntax match Usage /,_and_</
syntax match Usage /._and_>/
syntax match Usage /\/_and_?/
syntax match Usage /Caps_Lock/
syntax match Usage /F1/
syntax match Usage /F2/
syntax match Usage /F3/
syntax match Usage /F4/
syntax match Usage /F5/
syntax match Usage /F6/
syntax match Usage /F7/
syntax match Usage /F8/
syntax match Usage /F9/
syntax match Usage /F10/
syntax match Usage /F11/
syntax match Usage /F12/
syntax match Usage /PrintScreen/
syntax match Usage /Scroll_Lock/
syntax match Usage /Pause/
syntax match Usage /Insert/
syntax match Usage /Home/
syntax match Usage /PageUp/
syntax match Usage /Delete_Forward/
syntax match Usage /End/
syntax match Usage /PageDown/
syntax match Usage /RightArrow/
syntax match Usage /LeftArrow/
syntax match Usage /DownArrow/
syntax match Usage /UpArrow/
syntax match Usage /Keypad_Num_Lock_and_Clear/
syntax match Usage /Keypad_\//
syntax match Usage /Keypad_\*/
syntax match Usage /Keypad_-/
syntax match Usage /Keypad_+/
syntax match Usage /Keypad_ENTER/
syntax match Usage /Keypad_1_and_End/
syntax match Usage /Keypad_2_and_Down_Arrow/
syntax match Usage /Keypad_3_and_PageDn/
syntax match Usage /Keypad_4_and_Left_Arrow/
syntax match Usage /Keypad_5/
syntax match Usage /Keypad_6_and_Right_Arrow/
syntax match Usage /Keypad_7_and_Home/
syntax match Usage /Keypad_8_and_Up_Arrow/
syntax match Usage /Keypad_9_and_PageUp/
syntax match Usage /Keypad_0_and_Insert/
syntax match Usage /Keypad_._and_Delete/
syntax match Usage /Non-US_\\_and_|/
syntax match Usage /Application/
syntax match Usage /Power/
syntax match Usage /Keypad_=/
syntax match Usage /F13/
syntax match Usage /F14/
syntax match Usage /F15/
syntax match Usage /F16/
syntax match Usage /F17/
syntax match Usage /F18/
syntax match Usage /F19/
syntax match Usage /F20/
syntax match Usage /F21/
syntax match Usage /F22/
syntax match Usage /F23/
syntax match Usage /F24/
syntax match Usage /Execute/
syntax match Usage /Help/
syntax match Usage /Menu/
syntax match Usage /Select/
syntax match Usage /Stop/
syntax match Usage /Again/
syntax match Usage /Undo/
syntax match Usage /Cut/
syntax match Usage /Copy/
syntax match Usage /Paste/
syntax match Usage /Find/
syntax match Usage /Mute/
syntax match Usage /Volume_Up/
syntax match Usage /Volume_Down/
syntax match Usage /Locking_Caps_Lock/
syntax match Usage /Locking_Num_Lock/
syntax match Usage /Locking_Scroll_Lock/
syntax match Usage /Keypad_Comma/
syntax match Usage /Keypad_Equal_Sign/
syntax match Usage /International1/
syntax match Usage /International2/
syntax match Usage /International3/
syntax match Usage /International4/
syntax match Usage /International5/
syntax match Usage /International6/
syntax match Usage /International7/
syntax match Usage /International8/
syntax match Usage /International9/
syntax match Usage /LANG1/
syntax match Usage /LANG2/
syntax match Usage /LANG3/
syntax match Usage /LANG4/
syntax match Usage /LANG5/
syntax match Usage /LANG6/
syntax match Usage /LANG7/
syntax match Usage /LANG8/
syntax match Usage /LANG9/
syntax match Usage /Alternate_Erase/
syntax match Usage /SysReq\/Attention/
syntax match Usage /Cancel/
syntax match Usage /Clear/
syntax match Usage /Prior/
syntax match Usage /Return/
syntax match Usage /Separator/
syntax match Usage /Out/
syntax match Usage /Oper/
syntax match Usage /Clear\/Again/
syntax match Usage /CrSel\/Props/
syntax match Usage /ExSel/
syntax match Usage /Keypad_00/
syntax match Usage /Keypad_000/
syntax match Usage /Thousands_Separator/
syntax match Usage /Decimal_Separator/
syntax match Usage /Currency_Unit/
syntax match Usage /Currency_Sub-unit/
syntax match Usage /Keypad_(/
syntax match Usage /Keypad_)/
syntax match Usage /Keypad_{/
syntax match Usage /Keypad_}/
syntax match Usage /Keypad_Tab/
syntax match Usage /Keypad_Backspace/
syntax match Usage /Keypad_A/
syntax match Usage /Keypad_B/
syntax match Usage /Keypad_C/
syntax match Usage /Keypad_D/
syntax match Usage /Keypad_E/
syntax match Usage /Keypad_F/
syntax match Usage /Keypad_XOR/
syntax match Usage /Keypad_^/
syntax match Usage /Keypad_%/
syntax match Usage /Keypad_</
syntax match Usage /Keypad_>/
syntax match Usage /Keypad_&/
syntax match Usage /Keypad_&&/
syntax match Usage /Keypad_|/
syntax match Usage /Keypad_||/
syntax match Usage /Keypad_:/
syntax match Usage /Keypad_#/
syntax match Usage /Keypad_Space/
syntax match Usage /Keypad_@/
syntax match Usage /Keypad_!/
syntax match Usage /Keypad_Memory_Store/
syntax match Usage /Keypad_Memory_Recall/
syntax match Usage /Keypad_Memory_Clear/
syntax match Usage /Keypad_Memory_Add/
syntax match Usage /Keypad_Memory_Subtract/
syntax match Usage /Keypad_Memory_Multiply/
syntax match Usage /Keypad_Memory_Divide/
syntax match Usage /Keypad_+\/-216_d8_Keypad_Clear/
syntax match Usage /Keypad_Clear_Entry/
syntax match Usage /Keypad_Binary/
syntax match Usage /Keypad_Octal/
syntax match Usage /Keypad_Decimal/
syntax match Usage /Keypad_Hexadecimal/
syntax match Usage /LeftControl/
syntax match Usage /LeftShift/
syntax match Usage /LeftAlt/
syntax match Usage /Left_GUI/
syntax match Usage /RightControl/
syntax match Usage /RightShift/
syntax match Usage /RightAlt/
syntax match Usage /Right_GUI/
syntax match Usage /Unassigned/
syntax match Usage /Consumer_Control/
syntax match Usage /Numeric_Key_Pad/
syntax match Usage /Programmable_Buttons/
syntax match Usage /Microphone/
syntax match Usage /Headphone/
syntax match Usage /Graphic_Equalizer/
syntax match Usage /CC10/
syntax match Usage /CC100/
syntax match Usage /AM\/PM/
syntax match Usage /Power/
syntax match Usage /Reset/
syntax match Usage /Sleep/
syntax match Usage /Sleep_After/
syntax match Usage /Sleep_Mode/
syntax match Usage /Illumination/
syntax match Usage /Function_Buttons/
syntax match Usage /Menu/
syntax match Usage /Menu_Pick/
syntax match Usage /Menu_Up/
syntax match Usage /Menu_Down/
syntax match Usage /Menu_Left/
syntax match Usage /Menu_Right/
syntax match Usage /Menu_Escape/
syntax match Usage /Menu_Value_Increase/
syntax match Usage /Menu_Value_Decrease/
syntax match Usage /Data_On_Screen/
syntax match Usage /Closed_Caption/
syntax match Usage /Closed_Caption_Select/
syntax match Usage /VCR\/TV/
syntax match Usage /Broadcast_Mode/
syntax match Usage /Snapshot/
syntax match Usage /Still/
syntax match Usage /Selection/
syntax match Usage /Assign_Selection/
syntax match Usage /Mode_Step/
syntax match Usage /Recall_Last/
syntax match Usage /Enter_Channel/
syntax match Usage /Order_Movie/
syntax match Usage /Channel/
syntax match Usage /Media_Selection/
syntax match Usage /Media_Select_Computer/
syntax match Usage /Media_Select_TV/
syntax match Usage /Media_Select_WWW/
syntax match Usage /Media_Select_DVD/
syntax match Usage /Media_Select_Telephone/
syntax match Usage /Media_Select_Program_Guide/
syntax match Usage /Media_Select_Video_Phone/
syntax match Usage /Media_Select_Games/
syntax match Usage /Media_Select_Messages/
syntax match Usage /Media_Select_CD/
syntax match Usage /Media_Select_VCR/
syntax match Usage /Media_Select_Tuner/
syntax match Usage /Quit/
syntax match Usage /Help/
syntax match Usage /Media_Select_Tape/
syntax match Usage /Media_Select_Cable/
syntax match Usage /Media_Select_Satellite/
syntax match Usage /Media_Select_Security/
syntax match Usage /Media_Select_Home/
syntax match Usage /Media_Select_Call/
syntax match Usage /Channel_Increment/
syntax match Usage /Channel_Decrement/
syntax match Usage /Media_Select_SAP/
syntax match Usage /VCR_Plus/
syntax match Usage /Once/
syntax match Usage /Daily/
syntax match Usage /Weekly/
syntax match Usage /Monthly/
syntax match Usage /Play/
syntax match Usage /Pause/
syntax match Usage /Record/
syntax match Usage /Fast_Forward/
syntax match Usage /Rewind/
syntax match Usage /Scan_Next_Track/
syntax match Usage /Scan_Previous_Track/
syntax match Usage /Stop/
syntax match Usage /Eject/
syntax match Usage /Random_Play/
syntax match Usage /Select_Disc/
syntax match Usage /Enter_Disc/
syntax match Usage /Repeat/
syntax match Usage /Tracking/
syntax match Usage /Track_Normal/
syntax match Usage /Slow_Tracking/
syntax match Usage /Frame_Forward/
syntax match Usage /Frame_Back/
syntax match Usage /Mark/
syntax match Usage /Clear_Mark/
syntax match Usage /Repeat_From_Mark/
syntax match Usage /Return_To_Mark/
syntax match Usage /Search_Mark_Forward/
syntax match Usage /Search_Mark_Backwards/
syntax match Usage /Counter_Reset/
syntax match Usage /Show_Counter/
syntax match Usage /Tracking_Increment/
syntax match Usage /Tracking_Decrement/
syntax match Usage /Stop\/Eject/
syntax match Usage /Play\/Pause/
syntax match Usage /Play\/Skip/
syntax match Usage /Volume/
syntax match Usage /Balance/
syntax match Usage /Mute/
syntax match Usage /Bass/
syntax match Usage /Treble/
syntax match Usage /Bass_Boost/
syntax match Usage /Surround_Mode/
syntax match Usage /Loudness/
syntax match Usage /MPX/
syntax match Usage /Volume_Increment/
syntax match Usage /Volume_Decrement/
syntax match Usage /Speed_Select/
syntax match Usage /Playback_Speed/
syntax match Usage /Standard_Play/
syntax match Usage /Long_Play/
syntax match Usage /Extended_Play/
syntax match Usage /Slow/
syntax match Usage /Fan_Enable/
syntax match Usage /Fan_Speed/
syntax match Usage /Light_Enable/
syntax match Usage /Light_Illumination_Level/
syntax match Usage /Climate_Control_Enable/
syntax match Usage /Room_Temperature/
syntax match Usage /Security_Enable/
syntax match Usage /Fire_Alarm/
syntax match Usage /Police_Alarm/
syntax match Usage /Proximity/
syntax match Usage /Motion/
syntax match Usage /Duress_Alarm/
syntax match Usage /Holdup_Alarm/
syntax match Usage /Medical_Alarm/
syntax match Usage /Balance_Right/
syntax match Usage /Balance_Left/
syntax match Usage /Bass_Increment/
syntax match Usage /Bass_Decrement/
syntax match Usage /Treble_Increment/
syntax match Usage /Treble_Decrement/
syntax match Usage /Speaker_System/
syntax match Usage /Channel_Left/
syntax match Usage /Channel_Right/
syntax match Usage /Channel_Center/
syntax match Usage /Channel_Front/
syntax match Usage /Channel_Center_Front/
syntax match Usage /Channel_Side/
syntax match Usage /Channel_Surround/
syntax match Usage /Channel_Low_Frequency_Enhancement/
syntax match Usage /Channel_Top/
syntax match Usage /Channel_Unknown/
syntax match Usage /Sub-channel/
syntax match Usage /Sub-channel_Increment/
syntax match Usage /Sub-channel_Decrement/
syntax match Usage /Alternate_Audio_Increment/
syntax match Usage /Alternate_Audio_Decrement/
syntax match Usage /Application_Launch_Buttons/
syntax match Usage /AL_Launch_Button_Configuration_Tool/
syntax match Usage /AL_Programmable_Button_Configuration/
syntax match Usage /AL_Consumer_Control_Configuration/
syntax match Usage /AL_Word_Processor/
syntax match Usage /AL_Text_Editor/
syntax match Usage /AL_Spreadsheet/
syntax match Usage /AL_Graphics_Editor/
syntax match Usage /AL_Presentation_App/
syntax match Usage /AL_Database_App/
syntax match Usage /AL_Email_Reader/
syntax match Usage /AL_Newsreader/
syntax match Usage /AL_Voicemail/
syntax match Usage /AL_Contacts\/Address_Book/
syntax match Usage /AL_Calendar\/Schedule/
syntax match Usage /AL_Task\/Project_Manager/
syntax match Usage /AL_Log\/Journal\/Timecard/
syntax match Usage /AL_Checkbook\/Finance/
syntax match Usage /AL_Calculator/
syntax match Usage /AL_A\/V_Capture\/Playback/
syntax match Usage /AL_Local_Machine_Browser/
syntax match Usage /AL_LAN\/WAN_Browser/
syntax match Usage /AL_Internet_Browser/
syntax match Usage /AL_Remote_Networking\/ISP_Connect/
syntax match Usage /AL_Network_Conference/
syntax match Usage /AL_Network_Chat/
syntax match Usage /AL_Telephony\/Dialer/
syntax match Usage /AL_Logon/
syntax match Usage /AL_Logoff/
syntax match Usage /AL_Logon\/Logoff/
syntax match Usage /AL_Terminal_Lock\/Screensaver/
syntax match Usage /AL_Control_Panel/
syntax match Usage /AL_Command_Line_Processor\/Run/
syntax match Usage /AL_Process\/Task_Manager/
syntax match Usage /AL_Select_Task\/Application/
syntax match Usage /AL_Next_Task\/Application/
syntax match Usage /AL_Previous_Task\/Application/
syntax match Usage /AL_Preemptive_Halt_Task\/Application/
syntax match Usage /AL_Integrated_Help_Center/
syntax match Usage /AL_Documents/
syntax match Usage /AL_Thesaurus/
syntax match Usage /AL_Dictionary/
syntax match Usage /AL_Desktop/
syntax match Usage /AL_Spell_Check/
syntax match Usage /AL_Grammar_Check/
syntax match Usage /AL_Wireless_Status/
syntax match Usage /AL_Keyboard_Layout/
syntax match Usage /AL_Virus_Protection/
syntax match Usage /AL_Encryption/
syntax match Usage /AL_Screen_Saver/
syntax match Usage /AL_Alarms/
syntax match Usage /AL_Clock/
syntax match Usage /AL_File_Browser/
syntax match Usage /AL_Power_Status/
syntax match Usage /AL_Image_Browser/
syntax match Usage /AL_Audio_Browser/
syntax match Usage /AL_Movie_Browser/
syntax match Usage /AL_Digital_Rights_Manager/
syntax match Usage /AL_Digital_Wallet/
syntax match Usage /AL_Instant_Messaging/
syntax match Usage /AL_OEM_Features\/_Tips\/Tutorial_Browser/
syntax match Usage /AL_OEM_Help/
syntax match Usage /AL_Online_Community/
syntax match Usage /AL_Entertainment_Content_Browser/
syntax match Usage /AL_Online_Shopping_Browser/
syntax match Usage /AL_SmartCard_Information\/Help/
syntax match Usage /AL_Market_Monitor\/Finance_Browser/
syntax match Usage /AL_Customized_Corporate_News_Browser/
syntax match Usage /AL_Online_Activity_Browser/
syntax match Usage /AL_Research\/Search_Browser/
syntax match Usage /AL_Audio_Player/
syntax match Usage /Generic_GUI_Application_Controls/
syntax match Usage /AC_New/
syntax match Usage /AC_Open/
syntax match Usage /AC_Close/
syntax match Usage /AC_Exit/
syntax match Usage /AC_Maximize/
syntax match Usage /AC_Minimize/
syntax match Usage /AC_Save/
syntax match Usage /AC_Print/
syntax match Usage /AC_Properties/
syntax match Usage /AC_Propertie(orkbkbword, type,/
syntax match Usage /AC_Undo/
syntax match Usage /AC_Copy/
syntax match Usage /AC_Cut/
syntax match Usage /AC_Paste/
syntax match Usage /AC_Select_All/
syntax match Usage /AC_Find/
syntax match Usage /AC_Find_and_Replace/
syntax match Usage /AC_Search/
syntax match Usage /AC_Go_To/
syntax match Usage /AC_Home/
syntax match Usage /AC_Back/
syntax match Usage /AC_Forward/
syntax match Usage /AC_Stop/
syntax match Usage /AC_Refresh/
syntax match Usage /AC_Previous_Link/
syntax match Usage /AC_Next_Link/
syntax match Usage /AC_Bookmarks/
syntax match Usage /AC_History/
syntax match Usage /AC_Subscriptions/
syntax match Usage /AC_Zoom/
syntax match Usage /AC_Zoom_In/
syntax match Usage /AC_Zoom_Out/
syntax match Usage /AC_Full_Screen_View/
syntax match Usage /AC_Normal_View/
syntax match Usage /AC_View_Toggle/
syntax match Usage /AC_Scroll_Up/
syntax match Usage /AC_Scroll_Down/
syntax match Usage /AC_Scroll/
syntax match Usage /AC_Pan_Left/
syntax match Usage /AC_Pan_Right/
syntax match Usage /AC_Pan/
syntax match Usage /AC_New_Window/
syntax match Usage /AC_Tile_Horizontally/
syntax match Usage /AC_Tile_Vertically/
syntax match Usage /AC_Format/
syntax match Usage /AC_Edit/
syntax match Usage /AC_Bold/
syntax match Usage /AC_Italics/
syntax match Usage /AC_Underline/
syntax match Usage /AC_Strikethrough/
syntax match Usage /AC_Subscript/
syntax match Usage /AC_Superscript/
syntax match Usage /AC_All_Caps/
syntax match Usage /AC_Rotate/
syntax match Usage /AC_Resize/
syntax match Usage /AC_Flip_horizontal/
syntax match Usage /AC_Flip_Vertical/
syntax match Usage /AC_Mirror_Horizontal/
syntax match Usage /AC_Mirror_Vertical/
syntax match Usage /AC_Font_Select/
syntax match Usage /AC_Font_Color/
syntax match Usage /AC_Font_Size/
syntax match Usage /AC_Justify_Left/
syntax match Usage /AC_Justify_Center_H/
syntax match Usage /AC_Justify_Right/
syntax match Usage /AC_Justify_Block_H/
syntax match Usage /AC_Justify_Top/
syntax match Usage /AC_Justify_Center_V/
syntax match Usage /AC_Justify_Bottom/
syntax match Usage /AC_Justify_Block_V/
syntax match Usage /AC_Indent_Decrease/
syntax match Usage /AC_Indent_Increase/
syntax match Usage /AC_Numbered_List/
syntax match Usage /AC_Restart_Numbering/
syntax match Usage /AC_Bulleted_List/
syntax match Usage /AC_Promote/
syntax match Usage /AC_Demote/
syntax match Usage /AC_Yes/
syntax match Usage /AC_No/
syntax match Usage /AC_Cancel/
syntax match Usage /AC_Catalog/
syntax match Usage /AC_Buy\/Checkout/
syntax match Usage /AC_Add_to_Cart/
syntax match Usage /AC_Expand/
syntax match Usage /AC_Expand_All/
syntax match Usage /AC_Collapse/
syntax match Usage /AC_Collapse_All/
syntax match Usage /AC_Print_Preview/
syntax match Usage /AC_Paste_Special/
syntax match Usage /AC_Insert_Mode/
syntax match Usage /AC_Delete/
syntax match Usage /AC_Lock/
syntax match Usage /AC_Unlock/
syntax match Usage /AC_Protect/
syntax match Usage /AC_Unprotect/
syntax match Usage /AC_Attach_Comment/
syntax match Usage /AC_Delete_Comment/
syntax match Usage /AC_View_Comment/
syntax match Usage /AC_Select_Word/
syntax match Usage /AC_Select_Sentence/
syntax match Usage /AC_Select_Paragraph/
syntax match Usage /AC_Select_Column/
syntax match Usage /AC_Select_Row/
syntax match Usage /AC_Select_Table/
syntax match Usage /AC_Select_Object/
syntax match Usage /AC_Redo\/Repeat/
syntax match Usage /AC_Sort/
syntax match Usage /AC_Sort_Ascending/
syntax match Usage /AC_Sort_Descending/
syntax match Usage /AC_Filter/
syntax match Usage /AC_Set_Clock/
syntax match Usage /AC_View_Clock/
syntax match Usage /AC_Select_Time_Zone/
syntax match Usage /AC_Edit_Time_Zones/
syntax match Usage /AC_Set_Alarm/
syntax match Usage /AC_Clear_Alarm/
syntax match Usage /AC_Snooze_Alarm/
syntax match Usage /AC_Reset_Alarm/
syntax match Usage /AC_Synchronize/
syntax match Usage /AC_Send\/Receive/
syntax match Usage /AC_Send_To/
syntax match Usage /AC_Reply/
syntax match Usage /AC_Reply_All/
syntax match Usage /AC_Forward_Msg/
syntax match Usage /AC_Send/
syntax match Usage /AC_Attach_File/
syntax match Usage /AC_Upload/
syntax match Usage /AC_Download_(Save_Target_As)/
syntax match Usage /AC_Set_Borders/
syntax match Usage /AC_Insert_Row/
syntax match Usage /AC_Insert_Column/
syntax match Usage /AC_Insert_File/
syntax match Usage /AC_Insert_Picture/
syntax match Usage /AC_Insert_Object/
syntax match Usage /AC_Insert_Symbol/
syntax match Usage /AC_Save_and_Close/
syntax match Usage /AC_Rename/
syntax match Usage /AC_Merge/
syntax match Usage /AC_Split/
syntax match Usage /AC_Disribute_Horizontally/
syntax match Usage /AC_Distribute_Vertically/

syntax match Usage /Tablet_PC_System_Controls/
syntax match Usage /Return_(ENTER)/
syntax match Usage /Keypad_Num_Lock_and_Clear/
syntax match Usage /Keypad_ENTER/
syntax match Usage /AC_Normal_View/
syntax match Usage /AC_Pan_Left/
syntax match Usage /AC_Pan_Right/
syntax match Usage /AC_Send\/Receive/
syntax match Usage /AC_Send_To/
syntax match Usage /Motion_Wakeup/
syntax match UsagePage /Generic_Desktop/
syntax match UsagePage /Keyboard_and_Keypad/
syntax match UsagePage /Consumer_Control/

