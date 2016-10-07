Attribute VB_Name = "Module1"
'  Copyright (C) 1995-2006 Adlink Technology INC.
'  All rights reserved.
Option Explicit

'''''''''''''Type define
Type STR_SAMP_DATA_4CH
    tick As Long
    Data(3) As Long 'Total channel = 4
End Type

Type STR_SAMP_DATA_8CH
    tick As Long
    Data(7) As Long  '//Total channel = 8
End Type


Type POINT_DATA_EX
     i32_pos As Long              '//(Center)Position data (could be relative or absolute value)
     i16_accType As Integer       '//Acceleration pattern 0: T curve, 1:S curve
     i16_decType As Integer       '// Deceleration pattern 0: T curve, 1:S curve
     i32_acc As Long             '//Acceleration rate ( pulse / sec 2 )
     i32_dec As Long             '//Deceleration rate ( pulse / sec 2  )
     i32_initSpeed As Long     '//Start velocity ( pulse / s )
     i32_maxSpeed As Long  '//Maximum velocity    ( pulse / s )
     i32_endSpeed As Long   '//End velocity  ( pulse / s )
     i32_angle As Long          '//Arc move angle ( degree, -360 ~ 360 )
     u32_dwell As Long         '//dwell times ( unit: ms ) *Divided by system cycle time.
     i32_opt As Long              '//Point move option. (*)
     i32_pitch As Long                  '// pitch for helical move
     i32_totalheight As Long    '// total hight
           i16_cw As Integer                    '// cw or ccw
     i16_opt_ext As Integer             '// option extend
End Type

Type MOVE_PARA
    i16_accType As Integer '    //Axis parameter
    i16_decType As Integer '    //Axis parameter
    i32_acc As Long '        //Axis parameter
    i32_dec As Long '        //Axis parameter
    i32_initSpeed As Long ';  //Axis parameter
    i32_maxSpeed As Long ';   //Axis parameter
    i32_endSpeed As Long ';   //Axis parameter
    '//Speed pattern
End Type

Type POINT_DATA
    i32_pos As Long ';        // Position data (relative or absolute) (pulse)
    i16_accType As Integer '    // Acceleration pattern 0: T-curve,  1: S-curve
    i16_decType As Integer ';    // Deceleration pattern 0: T-curve,  1: S-curve
    i32_acc As Long ';        // Acceleration rate ( pulse / ss )
    i32_dec As Long ';        // Deceleration rate ( pulse / ss )
    i32_initSpeed As Long ';  // Start velocity   ( pulse / s )
    i32_maxSpeed As Long ';   // Maximum velocity  ( pulse / s )
    i32_endSpeed As Long ';   // End velocity     ( pulse / s )
    i32_angle As Long ';      // Arc move angle    ( degree, -360 ~ 360 )
    u32_dwell As Long ';      // Dwell times       ( unit: ms )
    i32_opt As Long ';        // Option //0xABCD , D:0 absolute, 1:relative
End Type

Type POINT_DATA2
    i32_pos(15) As Long ';    // Position data (relative or absolute) (pulse)
    i32_initSpeed As Long ';  // Start velocity   ( pulse / s )
    i32_maxSpeed As Long ';   // Maximum velocity  ( pulse / s )
    i32_angle As Long ';      // Arc move angle    ( degree, -360 ~ 360 )
    u32_dwell As Long ';      // Dwell times       ( unit: ms )
    i32_opt As Long ';        // Option //0xABCD , D:0 absolute, 1:relative
End Type

Type POINT_DATA3
    i32_pos(3) As Long
    i32_maxSpeed As Long
    i32_endPos(1) As Long
    i32_dir As Long
    i32_opt As Long
End Type

Type JOG_DATA
    i16_jogMode As Integer ';    // Jog mode. 0:Free running mode, 1:Step mode
    i16_dir As Integer ';        // Jog direction. 0:positive, 1:negative direction
    i16_accType As Integer ';    // Acceleration pattern 0: T-curve,  1: S-curve
    i32_acc As Long ';        // Acceleration rate ( pulse / ss )
    i32_dec As Long ';        // Deceleration rate ( pulse / ss )
    i32_maxSpeed As Long ';   // Positive value, maximum velocity  ( pulse / s )
    i32_offset As Long ';     // Positive value, a step (pulse)
    i32_delayTime As Long ';  // Delay time, ( range: 0 ~ 65535 millisecond, align by cycle time)
End Type

Type PNT_DATA_2D_F64

     u32_opt As Long        '// option, [0x00000000,0xFFFFFFFF
     f64_x As Double         '    // x-axis component (pulse), [-2147483648,2147484647]
     f64_y As Double         ' // y-axis component (pulse), [-2147483648,2147484647]
     f64_theta As Double      '// x-y plane arc move angle (0.000001 degree), [-360000,360000]
     f64_acc As Double        '// acceleration rate (pulse/ss), [0,2147484647]
     f64_dec As Double        '// deceleration rate (pulse/ss), [0,2147484647]
     f64_vi As Double         '// initial velocity (pulse/s), [0,2147484647]
     f64_vm As Double         '// maximum velocity (pulse/s), [0,2147484647]
     f64_ve As Double         '// ending velocity (pulse/s), [0,2147484647]
           f64_sf As Double                     '// s-factor [0.0 ~ 1.0]
End Type

Type HOME_PARA
    u8_homeMode As Byte
    u8_homeDir As Byte
    u8_curveType As Byte
    i32_orgOffset As Long
    i32_acceleration As Long
    i32_startVelocity As Long
    i32_maxVelocity As Long
    i32_OrgVelocity As Long
End Type

Type POS_DATA_2D
    u32_opt As Long ';        // option, [0x00000000,0xFFFFFFFF]
    i32_x As Long ';          // x-axis component (pulse), [-2147483648,2147484647]
    i32_y As Long ';          // y-axis component (pulse), [-2147483648,2147484647]
    i32_theta As Long ';      // x-y plane arc move angle (0.000001 degree), [-360000,360000]
End Type

Type PNT_DATA_2D
    u32_opt As Long ';        // option, [0x00000000,0xFFFFFFFF]
    i32_x As Long ';          // x-axis component (pulse), [-2147483648,2147484647]
    i32_y As Long ';          // y-axis component (pulse), [-2147483648,2147484647]
    i32_theta As Long ';      // x-y plane arc move angle (0.000001 degree), [-360000,360000]
    i32_acc As Long ';        // acceleration rate (pulse/ss), [0,2147484647]
    i32_dec As Long ';        // deceleration rate (pulse/ss), [0,2147484647]
    i32_vi As Long ';         // initial velocity (pulse/s), [0,2147484647]
    i32_vm As Long ';         // maximum velocity (pulse/s), [0,2147484647]
    i32_ve As Long ';         // ending velocity (pulse/s), [0,2147484647]
End Type

'// Point table structure (Four dimension)
Type PNT_DATA_4DL
    u32_opt As Long ';        // option, [0x00000000,0xFFFFFFFF]
    i32_x As Long ';          // x-axis component (pulse), [-2147483648,2147484647]
    i32_y As Long ';          // y-axis component (pulse), [-2147483648,2147484647]
    i32_z As Long ';          // z-axis component (pulse), [-2147483648,2147484647]
    i32_u As Long ';          // u-axis component (pulse), [-2147483648,2147484647]
    i32_acc As Long ';        // acceleration rate (pulse/ss), [0,2147484647]
    i32_dec As Long ';        // deceleration rate (pulse/ss), [0,2147484647]
    i32_vi As Long ';         // initial velocity (pulse/s), [0,2147484647]
    i32_vm As Long ';         // maximum velocity (pulse/s), [0,2147484647]
    i32_ve As Long ';         // ending velocity (pulse/s), [0,2147484647]
End Type

'// Point table structure (One dimension)
Type PNT_DATA
    u32_opt As Long ';        // option, [0x00000000,0xFFFFFFFF]
    i32_x As Long ';          // x-axis component (pulse), [-2147483648,2147484647]
    i32_theta As Long ';      // x-y plane arc move angle (0.001 degree), [-360000,360000]
    i32_acc As Long ';        // acceleration rate (pulse/ss), [0,2147484647]
    i32_dec As Long ';        // deceleration rate (pulse/ss), [0,2147484647]
    i32_vi As Long ';         // initial velocity (pulse/s), [0,2147484647]
    i32_vm As Long ';         // maximum velocity (pulse/s), [0,2147484647]
    i32_ve As Long ';         // ending velocity (pulse/s), [0,2147484647]
End Type

'//Asynchronized call
Type ASYNCALL
    h_event As Long
    i32_ret As Long
End Type

Type TSK_INFO
    State As Integer
    RunTimeErr As Integer
    IP As Integer
    SP As Integer
    BP As Integer
    MsgQueueSts As Integer
End Type

Type VAO_DATA
'    //Param
    outputType As Long '; //Output type, [0, 3]
    inputType As Long ';  //Input type, [0, 1]
    config As Long ';         //PWM configuration according to output type
    inputSrc As Long ';       //Input source by axis, [0, 0xf]
'    //Mapping table
    minVel As Long ';     //Minimum linear speed, [ positive ]
    VelInterval As Long ';    //Speed interval, [ positive ]
    TotalPoints As Long ';    //Total points, [1, 32]
    mappingDataArr(31) As Long ';  //mapping data array
End Type

Public Const MAX_SAMPL_CH = (8)
Public Const MAX_SAMPL_SRC = (2)

Type SAMP_PARAM
    rate As Long ';                           //Sampling rate
    edge As Long ';                           //Trigger edge
    level As Long ';                          //Trigger level
    trigCh As Long ';                         //Trigger channel
    sourceByCh(MAX_SAMPL_CH - 1, MAX_SAMPL_SRC - 1) As Long
    '//Sampling source by channel, named sourceByCh[a][b],
    '//a: Channel
    '//b: 0: Sampling source 1: Sampling axis
    '//Sampling source: F64 data occupies two channel, I32 data occupies one channel.
End Type

Public Const MAX_PT_DIM = (6)

Type PTINFO
    Dimension As Long
    AxisArr(MAX_PT_DIM - 1) As Long
End Type

Type PTDWL
    DwTime As Double ' //Unit is ms
End Type

'Type PTLINE
'    Dim As Long
'    Pos(MAX_PT_DIM - 1) As Long
'End Type

Type PTLINE
    Dimension As Long
    Dim_dummy As Long '//dummy, reserved
    pos0 As Double
    pos1 As Double
    pos2 As Double
    pos3 As Double
    pos4 As Double
    pos5 As Double
End Type

Public Const MAXHEXLIX = &H3    '//Helix axes is 3.
Public Const MAXARC3 = &H3    '//ARC3 axes is 3.
Public Const MAXARC2 = &H2    '//ARC2 axes is 2.

'Type PTA2CA
'    Index(MAXARC2 - 1) As Byte '  //Index X,Y
'    Center(MAXARC2 - 1) As Double '//Center Arr
'    Angle As Double '//Angle
'End Type

Type PTA2CA
    Index0 As Byte '//Index X
    Index1 As Byte '//Index Y
    Index_dummy0 As Byte '//dummy, reserved
    Index_dummy1 As Byte '//dummy, reserved
    Index_dummy2 As Byte '//dummy, reserved
    Index_dummy3 As Byte '//dummy, reserved
    Index_dummy4 As Byte '//dummy, reserved
    Index_dummy5 As Byte '//dummy, reserved
    Center0 As Double '//Center Arr
    Center1 As Double '//Center Arr
    Angle As Double '//Angle
End Type


'Type PTA2CE
'    Index(MAXARC2 - 1) As Byte '//Index X,Y
'    Center(MAXARC2 - 1) As Double ' //
'    End_pos(MAXARC2 - 1) As Double
'    Dir As Integer
'End Type

Type PTA2CE
    Index0 As Byte '//Index X
    Index1 As Byte '//Index Y
    Index_dummy0 As Byte '//dummy, reserved
    Index_dummy1 As Byte '//dummy, reserved
    Index_dummy2 As Byte '//dummy, reserved
    Index_dummy3 As Byte '//dummy, reserved
    Index_dummy4 As Byte '//dummy, reserved
    Index_dummy5 As Byte '//dummy, reserved
    Center0 As Double '//Center Arr
    Center1 As Double '//Center Arr
    End_pos0 As Double
    End_pos1 As Double
    Dir As Integer
End Type


'Type PTA3CA
'    Index(MAXARC3 - 1) As Byte ' //Index X,Y
'    Center(MAXARC3 - 1) As Double '; //Center Arr
'    Noraml(MAXARC3 - 1) As Double ' //Normal Arr
'    Angle As Double '//Angle
'End Type

Type PTA3CA
    Index0 As Byte ' //Index X
    Index1 As Byte ' //Index Y
    Index2 As Byte ' //Index Z
    Index_dummy0 As Byte '//dummy, reserved
    Index_dummy1 As Byte '//dummy, reserved
    Index_dummy2 As Byte '//dummy, reserved
    Index_dummy3 As Byte '//dummy, reserved
    Index_dummy4 As Byte '//dummy, reserved
    Center0 As Double '; //Center Arr
    Center1 As Double '; //Center Arr
    Center2 As Double '; //Center Arr
    Noraml0 As Double ' //Normal Arr
    Noraml1 As Double ' //Normal Arr
    Noraml2 As Double ' //Normal Arr
    Angle As Double '//Angle
End Type


'Type PTA3CE
'    Index(MAXARC3 - 1) As Byte ' //Index X,Y
'    Center(MAXARC3 - 1) As Double ' //Center Arr
'    End_pos(MAXARC3 - 1) As Double '//End Arr
'    Dir As Integer
'End Type

Type PTA3CE
    Index0 As Byte ' //Index X
    Index1 As Byte ' //Index Y
    Index2 As Byte ' //Index Z
    Index_dummy0 As Byte '//dummy, reserved
    Index_dummy1 As Byte '//dummy, reserved
    Index_dummy2 As Byte '//dummy, reserved
    Index_dummy3 As Byte '//dummy, reserved
    Index_dummy4 As Byte '//dummy, reserved
    Center0 As Double ' //Center Arr
    Center1 As Double ' //Center Arr
    Center2 As Double ' //Center Arr
    End_pos0 As Double '//End Arr
    End_pos1 As Double '//End Arr
    End_pos2 As Double '//End Arr
    Dir As Integer
End Type


'Type PTHCA
'    Index(MAXHEXLIX - 1) As Byte '; //Index X,Y
'    Center(MAXHEXLIX - 1) As Double '//Center Arr
'    Noraml(MAXHEXLIX - 1) As Double '//Normal Arr
'    Angle As Double '//Angle
'    DeltaH As Double
'    FinalR As Double
'End Type

Type PTHCA
    Index0 As Byte '; //Index X
    Index1 As Byte '; //Index Y
    Index2 As Byte '; //Index Z
    Index_dummy0 As Byte '//dummy, reserved
    Index_dummy1 As Byte '//dummy, reserved
    Index_dummy2 As Byte '//dummy, reserved
    Index_dummy3 As Byte '//dummy, reserved
    Index_dummy4 As Byte '//dummy, reserved
    Center0 As Double ' //Center Arr
    Center1 As Double ' //Center Arr
    Center2 As Double ' //Center Arr
    Noraml0 As Double ' //Normal Arr
    Noraml1 As Double ' //Normal Arr
    Noraml2 As Double ' //Normal Arr
    Angle As Double '//Angle
    DeltaH As Double
    FinalR As Double
End Type


'Type PTHCE
'    Index(MAXHEXLIX - 1) As Byte '//Index X,Y
'    Center(MAXHEXLIX - 1) As Double '//Center Arr
'    Noraml(MAXHEXLIX - 1) As Double '//Normal Arr
'    End_pos(MAXHEXLIX - 1) As Double '//End Arr
'    Dir As Integer
'End Type

Type PTHCE
    Index0 As Byte '; //Index X
    Index1 As Byte '; //Index Y
    Index2 As Byte '; //Index Z
    Index_dummy0 As Byte '//dummy, reserved
    Index_dummy1 As Byte '//dummy, reserved
    Index_dummy2 As Byte '//dummy, reserved
    Index_dummy3 As Byte '//dummy, reserved
    Index_dummy4 As Byte '//dummy, reserved
    Center0 As Double ' //Center Arr
    Center1 As Double ' //Center Arr
    Center2 As Double ' //Center Arr
    Noraml0 As Double ' //Normal Arr
    Noraml1 As Double ' //Normal Arr
    Noraml2 As Double ' //Normal Arr
    End_pos0 As Double '//End Arr
    End_pos1 As Double '//End Arr
    End_pos2 As Double '//End Arr
    Dir As Integer
End Type

Type DEBUG_DATA
         ServoOffCondition As Integer
         DspCmdPos As Double
         DspFeedbackPos As Double
         FpgaCmdPos As Double
         FpgaFeedbackPos As Double
         FpgaOutputVoltage As Double
End Type

Type DEBUG_STATE

         AxisState As Integer
         GroupState As Integer
         AxisSuperState As Integer

End Type

Type PTSTS
    BitSts As Integer '; //b0: Is PTB work? [1:working, 0:Stopped]
                       ' //b1: Is point buffer full? [1:full, 0:not full]
                       ' //b2: Is point buffer empty? [1:empty, 0:not empty]
                       ' //b3, b4, b5: Reserved for future
                       ' //b6~: Be always 0
    PntBufFreeSpace As Integer
    PntBufUsageSpace As Integer
    RunningCnt As Long
End Type

Type LPSTS
    MotionLoopLoading As Long
    HostLoopLoading As Long
    MotionLoopLoadingMax As Long
    HostLoopLoadingMax As Long
End Type



'New ADCNC structure define
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Type POS_DATA_2D_F64


    'This structure extends original point data contents from "I32" to "F64"
                'for internal computation. It's important to prevent data overflow.

     u32_opt As Long          '// option, [0x00000000, 0xFFFFFFFF]
     f64_x As Double          '// x-axis component (pulse), [-9223372036854775808, 9223372036854775807]
     f64_y As Double          '// y-axis component (pulse), [-9223372036854775808, 9223372036854775807]
     f64_theta As Double      '// x-y plane arc move angle (0.000001 degree), [-360000, 360000]

End Type

Type POS_DATA_2D_RPS

'/* This structure adds another variable to record what point was be saved */

     u32_opt As Long         '// option, [0x00000000, 0xFFFFFFFF]
           i32_x As Long           '// x-axis component (pulse), [-2147483648, 2147483647]
     i32_y As Long           '// y-axis component (pulse), [-2147483648, 2147483647]
     i32_theta As Long       '// x-y plane arc move angle (0.000001 degree), [-360000, 360000]
           crpi As Long                              '// current reading point index

End Type

Type POS_DATA_2D_F64_RPS

 '/* This structure adds another variable to record what point was be saved */
 
     u32_opt As Long          '// option, [0x00000000, 0xFFFFFFFF]
     f64_x As Double          '// x-axis component (pulse), [-2147483648, 2147483647]
     f64_y As Double          '// y-axis component (pulse), [-2147483648, 2147483647]
     f64_theta As Double      '// x-y plane arc move angle (0.000001 degree), [-360000, 360000]
           crpi As Long                             '// current reading point index

End Type


Type PNT_DATA_2D_EXT

      u32_opt As Long          '// option, [0x00000000,0xFFFFFFFF]
      f64_x As Double          '// x-axis component (pulse), [-2147483648,2147484647]
      f64_y As Double          '// y-axis component (pulse), [-2147483648,2147484647]
      f64_theta As Double      '// x-y plane arc move angle (0.000001 degree), [-360000,360000]
      f64_acc(3) As Double     '// acceleration rate (pulse/ss), [0,2147484647]
      f64_dec(3) As Double     '// deceleration rate (pulse/ss), [0,2147484647]
      crossover As Long
      Iboundary As Long                    '// initial boundary
      f64_vi(3) As Double      '// initial velocity (pulse/s), [0,2147484647]
      vi_cmpr As Long
      f64_vm(3) As Double      '// maximum velocity (pulse/s), [0,2147484647]
      vm_cmpr As Long
      f64_ve(3) As Double      '// ending velocity (pulse/s), [0,2147484647]
            ve_cmpr As Long
            Eboundary As Long                    '// end boundary
            f64_dist As Double                   '// point distance
            f64_angle As Double                '// path angle between previous & current point
            f64_radius As Double               '// point radiua (used in arc move)
            i32_arcstate As Long
            spt As Long                              '// speed profile type
         
            t(3) As Double
          
            HorizontalFlag As Long
            VerticalFlag As Long

End Type
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

















































'Error code define
Public Const ERR_NoError = (0)                                                          '//No Error
Public Const ERR_OSVersion = (-1)                                       '// Operation System type mismatched
Public Const ERR_OpenDriverFailed = (-2)                        '// Open device driver failed - Create driver interface failed
Public Const ERR_InsufficientMemory = (-3)                      '// System memory insufficiently
Public Const ERR_DeviceNotInitial = (-4)                        '// Cards not be initialized
Public Const ERR_NoDeviceFound = (-5)                           '// Cards not found(No card in your system)
Public Const ERR_CardIdDuplicate = (-6)                                 '// Cards' ID is duplicated.
Public Const ERR_DeviceAlreadyInitialed = (-7)          '// Cards have been initialed
Public Const ERR_InterruptNotEnable = (-8)                      '// Cards' interrupt events not enable or not be initialized
Public Const ERR_TimeOut = (-9)                                                 '// Function time out
Public Const ERR_ParametersInvalid = (-10)                      '// Function input parameters are invalid
Public Const ERR_SetEEPROM = (-11)                                      '// Set data to EEPROM (or nonvolatile memory) failed
Public Const ERR_GetEEPROM = (-12)                                      '// Get data from EEPROM (or nonvolatile memory) failed
Public Const ERR_FunctionNotAvailable = (-13)         ' // Function is not available in this step, The device is not support this function or Internal process failed
Public Const ERR_FirmwareError = (-14)                          '// Firmware error, please reboot the system
Public Const ERR_CommandInProcess = (-15)                       '// Previous command is in process
Public Const ERR_AxisIdDuplicate = (-16)                                '// Axes' ID is duplicated.
Public Const ERR_ModuleNotFound = (-17)                         ' // Slave module not found.
Public Const ERR_InsufficientModuleNo = (-18)           '// System ModuleNo insufficiently
Public Const ERR_HandShakeFailed = (-19)                                ' // HandSake with the DSP out of time.
Public Const ERR_FILE_FORMAT = (-20)                                    '// Config file format error.(cannot be parsed)
Public Const ERR_ParametersReadOnly = (-21)                     '// Function parameters read only.
Public Const ERR_DistantNotEnough = (-22)                       '// Distant is not enough for motion.
Public Const ERR_FunctionNotEnable = (-23)                      '// Function is not enabled.
Public Const ERR_ServerAlreadyClose = (-24)             '// Server already closed.
Public Const ERR_DllNotFound = (-25)                                    '// Related dll is not found, not in correct path.
Public Const ERR_TrimDAC_Channel = (-26)
Public Const ERR_Satellite_Type = (-27)
Public Const ERR_Over_Voltage_Spec = (-28)
Public Const ERR_Over_Current_Spec = (-29)
Public Const ERR_SlaveIsNotAI = (-30)
Public Const ERR_Over_AO_Channel_Scope = (-31)
Public Const ERR_DllFuncFailed = (-32)                                  '// Failed to invoke dll function. Extension Dll version is wrong.
Public Const ERR_FeederAbnormalStop = (-33)                '//Feeder abnormal stop, External stop or feeding stop
Public Const ERR_Read_ModuleType_Dismatch = (-33)
Public Const ERR_Win32Error = (-1000)                                          '// No such INT number, or WIN32_API error, contact with ADLINK's FAE staff.
Public Const ERR_DspStart = (-2000)                                              '// The base for DSP error

''''''''''''''APS168
Declare Function APS_initial Lib "APS168.dll" (BoardID_InBits As Long, ByVal Mode As Long) As Long
Declare Function APS_close Lib "APS168.dll" () As Long
Declare Function APS_version Lib "APS168.dll" () As Long

Declare Function APS_device_driver_version Lib "APS168.dll" (ByVal Board_ID As Long) As Long
Declare Function APS_get_axis_info Lib "APS168.dll" (ByVal Axis_ID As Long, Board_ID As Long, Axis_No As Long, Port_ID As Long, Module_ID As Long) As Long
Declare Function APS_set_board_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BOD_Param_No As Long, ByVal BOD_Param As Long) As Long
Declare Function APS_get_board_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BOD_Param_No As Long, BOD_Param As Long) As Long
Declare Function APS_set_axis_param Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal AXS_Param_No As Long, ByVal AXS_Param As Long) As Long
Declare Function APS_get_axis_param Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal AXS_Param_No As Long, AXS_Param As Long) As Long
Declare Function APS_get_system_timer Lib "APS168.dll" (ByVal Board_ID As Long, Timer As Long) As Long
Declare Function APS_get_device_info Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Info_No As Long, info As Long) As Long
Declare Function APS_get_card_name Lib "APS168.dll" (ByVal Board_ID As Long, CardName As Long) As Long
Declare Function APS_disable_device Lib "APS168.dll" (ByVal DeviceName As Long) As Long
Declare Function APS_get_first_axisId Lib "APS168.dll" (ByVal Board_ID As Long, StartAxisID As Long, TotalAxisNum As Long) As Long
Declare Function APS_set_security_key Lib "APS168.dll" (ByVal Board_ID As Long, ByVal OldPassword As Long, ByVal NewPassword As Long) As Long
Declare Function APS_check_security_key Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Password As Long) As Long
Declare Function APS_reset_security_key Lib "APS168.dll" (ByVal Board_ID As Long) As Long
Declare Function APS_load_param_from_file Lib "APS168.dll" (ByVal XMLFile As String) As Long

' Virtual board settings  [Only for PCI-8254/8]
Declare Function APS_register_virtual_board Lib "APS168.dll" (ByVal VirCardIndex As Long, ByVal Count As Long) As Long
Declare Function APS_get_virtual_board_info Lib "APS168.dll" (ByVal VirCardIndex As Long, Count As Long) As Long
' Parameters setting by float [Only for PCI-8254/8]
Declare Function APS_set_axis_param_f Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal AXS_Param_No As Long, ByVal AXS_Param As Double) As Long
Declare Function APS_get_axis_param_f Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal AXS_Param_No As Long, AXS_Param As Double) As Long
' Control driver mode [Only for PCI-8254/8]
Declare Function APS_get_eep_curr_drv_ctrl_mode Lib "APS168.dll" (ByVal Board_ID As Long, ModeInBit As Long) As Long
' Only support PCI-7856/MoionNet series
Declare Function APS_save_param_to_file Lib "APS168.dll" (ByVal Board_ID As Long, ByVal XMLFile As String) As Long

'
'  Flash function [Only for PCI-8253/56, PCI-8392(H)]
Declare Function APS_save_parameter_to_flash Lib "APS168.dll" (ByVal Board_ID As Long) As Long
Declare Function APS_load_parameter_from_flash Lib "APS168.dll" (ByVal Board_ID As Long) As Long
Declare Function APS_load_parameter_from_default Lib "APS168.dll" (ByVal Board_ID As Long) As Long
'
'  SSCNET-3 functions [Only for PCI-8392(H)]
Declare Function APS_start_sscnet Lib "APS168.dll" (ByVal Board_ID As Long, AxisFound_InBits As Long) As Long
Declare Function APS_stop_sscnet Lib "APS168.dll" (ByVal Board_ID As Long) As Long
Declare Function APS_get_sscnet_servo_param Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Para_No1 As Long, Para_Dat1 As Long, ByVal Para_No2 As Long, Para_Dat2 As Long) As Long
Declare Function APS_set_sscnet_servo_param Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Para_No1 As Long, ByVal Para_Dat1 As Long, ByVal Para_No2 As Long, ByVal Para_Dat2 As Long) As Long
Declare Function APS_get_sscnet_servo_alarm Lib "APS168.dll" (ByVal Axis_ID As Long, Alarm_No As Long, Alarm_Detail As Long) As Long
Declare Function APS_reset_sscnet_servo_alarm Lib "APS168.dll" (ByVal Axis_ID As Long) As Long
Declare Function APS_save_sscnet_servo_param Lib "APS168.dll" (ByVal Board_ID As Long) As Long
Declare Function APS_get_sscnet_servo_abs_position Lib "APS168.dll" (ByVal Axis_ID As Long, Cyc_Cnt As Long, Res_Cnt As Long) As Long
Declare Function APS_save_sscnet_servo_abs_position Lib "APS168.dll" (ByVal Board_ID As Long) As Long
Declare Function APS_load_sscnet_servo_abs_position Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Abs_Option As Long, Cyc_Cnt As Long, Res_Cnt As Long) As Long
Declare Function APS_get_sscnet_link_status Lib "APS168.dll" (ByVal Board_ID As Long, Link_Status As Long) As Long
Declare Function APS_set_sscnet_servo_monitor_src Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Mon_No As Long, ByVal Mon_Src As Long) As Long
Declare Function APS_get_sscnet_servo_monitor_src Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Mon_No As Long, Mon_Src As Long) As Long
Declare Function APS_get_sscnet_servo_monitor_data Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Arr_Size As Long, Data_Arr As Long) As Long
Declare Function APS_set_sscnet_control_mode Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Mode As Long) As Long
'
'  Motion IO & motion status
Declare Function APS_get_command Lib "APS168.dll" (ByVal Axis_ID As Long, Command As Long) As Long
Declare Function APS_set_command Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Command As Long) As Long
Declare Function APS_motion_status Lib "APS168.dll" (ByVal Axis_ID As Long) As Long
Declare Function APS_motion_io_status Lib "APS168.dll" (ByVal Axis_ID As Long) As Long
Declare Function APS_set_servo_on Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Servo_On As Long) As Long
Declare Function APS_get_position Lib "APS168.dll" (ByVal Axis_ID As Long, Position As Long) As Long
Declare Function APS_set_position Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Position As Long) As Long
Declare Function APS_get_command_velocity Lib "APS168.dll" (ByVal Axis_ID As Long, Velocity As Long) As Long
Declare Function APS_get_feedback_velocity Lib "APS168.dll" (ByVal Axis_ID As Long, Velocity As Long) As Long
Declare Function APS_get_error_position Lib "APS168.dll" (ByVal Axis_ID As Long, Err_Pos As Long) As Long
Declare Function APS_get_target_position Lib "APS168.dll" (ByVal Axis_ID As Long, Targ_Pos As Long) As Long
'  Monitor functions by float [Only for PCI-8254/8]
Declare Function APS_get_command_f Lib "APS168.dll" (ByVal Axis_ID As Long, Command As Double) As Long
Declare Function APS_set_command_f Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Command As Double) As Long
Declare Function APS_get_position_f Lib "APS168.dll" (ByVal Axis_ID As Long, Position As Double) As Long
Declare Function APS_set_position_f Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Position As Double) As Long
Declare Function APS_get_command_velocity_f Lib "APS168.dll" (ByVal Axis_ID As Long, Velocity As Double) As Long
Declare Function APS_get_target_position_f Lib "APS168.dll" (ByVal Axis_ID As Long, Targ_Pos As Double) As Long
Declare Function APS_get_error_position_f Lib "APS168.dll" (ByVal Axis_ID As Long, Err_Pos As Double) As Long
Declare Function APS_get_feedback_velocity_f Lib "APS168.dll" (ByVal Axis_ID As Long, Velocity As Double) As Long
' Motion queue status [Only for PCI-8254/8]
Declare Function APS_get_mq_free_space Lib "APS168.dll" (ByVal Axis_ID As Long, Space As Long) As Long
Declare Function APS_get_mq_usage Lib "APS168.dll" (ByVal Axis_ID As Long, Usage As Long) As Long
' Motion Stop Code [Only for PCI-8254/8]
Declare Function APS_get_stop_code Lib "APS168.dll" (ByVal Axis_ID As Long, Code As Long) As Long
'
'  Single axis motion
Declare Function APS_relative_move Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Distance As Long, ByVal Max_Speed As Long) As Long
Declare Function APS_absolute_move Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Position As Long, ByVal Max_Speed As Long) As Long
Declare Function APS_velocity_move Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Max_Speed As Long) As Long
Declare Function APS_home_move Lib "APS168.dll" (ByVal Axis_ID As Long) As Long
Declare Function APS_stop_move Lib "APS168.dll" (ByVal Axis_ID As Long) As Long
Declare Function APS_emg_stop Lib "APS168.dll" (ByVal Axis_ID As Long) As Long
Declare Function APS_relative_move2 Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Distance As Long, ByVal Start_Speed As Long, ByVal Max_Speed As Long, ByVal End_Speed As Long, ByVal Acc_Rate As Long, ByVal Dec_Rate As Long) As Long
Declare Function APS_absolute_move2 Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Position As Long, ByVal Start_Speed As Long, ByVal Max_Speed As Long, ByVal End_Speed As Long, ByVal Acc_Rate As Long, ByVal Dec_Rate As Long) As Long
Declare Function APS_home_move2 Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Dir As Long, ByVal Acc As Long, ByVal Start_Speed As Long, ByVal Max_Speed As Long, ByVal ORG_Speed As Long) As Long
Declare Function APS_home_escape Lib "APS168.dll" (ByVal Axis_ID As Long) As Long

' JOG functions [Only for PCI-8392, PCI-8253/56]
Declare Function APS_set_jog_param Lib "APS168.dll" (ByVal Axis_ID As Long, pStr_Jog As JOG_DATA, ByVal Mask As Long) As Long
Declare Function APS_get_jog_param Lib "APS168.dll" (ByVal Axis_ID As Long, pStr_Jog As JOG_DATA) As Long
Declare Function APS_jog_mode_switch Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Turn_No As Long) As Long
Declare Function APS_jog_start Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal STA_On As Long) As Long
'
'  Interpolation
Declare Function APS_absolute_linear_move Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long, Position_Array As Long, ByVal Max_Linear_Speed As Long) As Long
Declare Function APS_relative_linear_move Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long, Distance_Array As Long, ByVal Max_Linear_Speed As Long) As Long
Declare Function APS_absolute_arc_move Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long, Center_Pos_Array As Long, ByVal Max_Arc_Speed As Long, ByVal Angle As Long) As Long
Declare Function APS_relative_arc_move Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long, Center_Offset_Array As Long, ByVal Max_Arc_Speed As Long, ByVal Angle As Long) As Long
'
'  Helical interpolation [Only for PCI-8392, PCI-8253/56]
Declare Function APS_absolute_helix_move Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long, Center_Pos_Array As Long, ByVal Max_Arc_Speed As Long, ByVal Pitch As Long, ByVal TotalHeight As Long, ByVal CwOrCcw As Long) As Long
Declare Function APS_relative_helix_move Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long, Center_PosOffset_Array As Long, ByVal Max_Arc_Speed As Long, ByVal Pitch As Long, ByVal TotalHeight As Long, ByVal CwOrCcw As Long) As Long
'
'  Circular interpolation( Support 2D and 3D ) [Only for PCI-8392, PCI-8253/56]
Declare Function APS_absolute_arc_move_3pe Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long, Pass_Pos_Array As Long, End_Pos_Array As Long, ByVal Max_Arc_Speed As Long) As Long
Declare Function APS_relative_arc_move_3pe Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long, Pass_PosOffset_Array As Long, End_PosOffset_Array As Long, ByVal Max_Arc_Speed As Long) As Long
'
'  Interrupt functions
'
Declare Function APS_int_enable Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Enable As Long) As Long
'
Declare Function APS_set_int_factor Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Item_No As Long, ByVal Factor_No As Long, ByVal Enable As Long) As Long
Declare Function APS_get_int_factor Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Item_No As Long, ByVal Factor_No As Long, Enable As Long) As Long
'
Declare Function APS_set_field_bus_int_factor_di Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal bitsOfCheck As Long) As Long
Declare Function APS_get_field_bus_int_factor_di Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, bitsOfCheck As Long) As Long
'
' [Only for PCI-7856 motion interrupt]
Declare Function APS_set_field_bus_int_factor_motion Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Factor_No As Long, ByVal Enable As Long) As Long
Declare Function APS_get_field_bus_int_factor_motion Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Factor_No As Long, Enable As Long) As Long
Declare Function APS_set_field_bus_int_factor_error Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Factor_No As Long, ByVal Enable As Long) As Long
Declare Function APS_get_field_bus_int_factor_error Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Factor_No As Long, Enable As Long) As Long
Declare Function APS_reset_field_bus_int_motion Lib "APS168.dll" (ByVal Axis_ID As Long) As Long
Declare Function APS_wait_field_bus_error_int_motion Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Time_Out As Long) As Long
'
Declare Function APS_set_int_factorH Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Item_No As Long, ByVal Factor_No As Long, ByVal Enable As Long) As Long
Declare Function APS_int_no_to_handle Lib "APS168.dll" (ByVal Int_No As Long) As Long
'
Declare Function APS_wait_single_int Lib "APS168.dll" (ByVal Int_No As Long, ByVal Time_Out As Long) As Long
Declare Function APS_wait_multiple_int Lib "APS168.dll" (ByVal Int_Count As Long, Int_No_Array As Long, ByVal Wait_All As Long, ByVal Time_Out As Long) As Long
Declare Function APS_reset_int Lib "APS168.dll" (ByVal Int_No As Long) As Long
Declare Function APS_set_int Lib "APS168.dll" (ByVal Int_No As Long) As Long
Declare Function APS_wait_error_int Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Item_No As Long, ByVal Time_Out As Long) As Long

'
'  Sampling functions [Only for PCI-8392, PCI-8253/56, PCI-82548]
Declare Function APS_set_sampling_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal ParaNum As Long, ByVal ParaDat As Long) As Long
Declare Function APS_get_sampling_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal ParaNum As Long, ParaDat As Long) As Long
Declare Function APS_wait_trigger_sampling Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Length As Long, ByVal PreTrgLen As Long, ByVal TimeOutMs As Long, ByRef DataArr As STR_SAMP_DATA_4CH) As Long
Declare Function APS_wait_trigger_sampling_async Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Length As Long, ByVal PreTrgLen As Long, ByVal TimeOutMs As Long, ByRef DataArr As STR_SAMP_DATA_4CH) As Long
Declare Function APS_get_sampling_count Lib "APS168.dll" (ByVal Board_ID As Long, SampCnt As Long) As Long
Declare Function APS_stop_wait_sampling Lib "APS168.dll" (ByVal Board_ID As Long) As Long
Declare Function APS_auto_sampling Lib "APS168.dll" (ByVal Board_ID As Long, ByVal StartStop As Long) As Long
Declare Function APS_get_sampling_data Lib "APS168.dll" (ByVal Board_ID As Long, ByRef Length As Long, ByRef DataArr As STR_SAMP_DATA_4CH, ByRef Status As Long) As Long
'  Sampling functions extension[Only for PCI-82548 for up to 8 channel]
Declare Function APS_set_sampling_param_ex Lib "APS168.dll" (ByVal Board_ID As Long, ByRef Param As SAMP_PARAM) As Long
Declare Function APS_get_sampling_param_ex Lib "APS168.dll" (ByVal Board_ID As Long, ByRef Param As SAMP_PARAM) As Long
Declare Function APS_wait_trigger_sampling_ex Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Length As Long, ByVal PreTrgLen As Long, ByVal TimeOutMs As Long, ByRef DataArr As STR_SAMP_DATA_8CH) As Long
Declare Function APS_wait_trigger_sampling_async_ex Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Length As Long, ByVal PreTrgLen As Long, ByVal TimeOutMs As Long, ByRef DataArr As STR_SAMP_DATA_8CH) As Long
Declare Function APS_get_sampling_data_ex Lib "APS168.dll" (ByVal Board_ID As Long, ByRef Length As Long, ByRef DataArr As STR_SAMP_DATA_8CH, ByRef Status As Long) As Long
'
' DIO & AIO
Declare Function APS_write_d_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal DO_Group As Long, ByVal DO_Data As Long) As Long
Declare Function APS_read_d_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal DO_Group As Long, DO_Data As Long) As Long
Declare Function APS_read_d_input Lib "APS168.dll" (ByVal Board_ID As Long, ByVal DI_Group As Long, DI_Data As Long) As Long

'PCI-82548 Only for channel I/O
Declare Function APS_write_d_channel_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal DO_Group As Long, ByVal Ch_No As Long, ByVal DO_Data As Long) As Long
Declare Function APS_read_d_channel_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal DO_Group As Long, ByVal Ch_No As Long, DO_Data As Long) As Long

'
Declare Function APS_read_a_input_value Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Channel_No As Long, Convert_Data As Double) As Long
Declare Function APS_read_a_input_data Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Channel_No As Long, Raw_Data As Long) As Long
Declare Function APS_write_a_output_value Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Channel_No As Long, ByVal Convert_Data As Double) As Long
Declare Function APS_write_a_output_data Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Channel_No As Long, ByVal Raw_Data As Long) As Long
' New AIO [Only for PCI-82548]
Declare Function APS_read_a_output_value Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Channel_No As Long, Convert_Data As Double) As Long
'
' Point table move
Declare Function APS_set_point_table Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Index As Long, ByRef Point As POINT_DATA) As Long
Declare Function APS_get_point_table Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Index As Long, ByRef Point As POINT_DATA) As Long
Declare Function APS_get_running_point_index Lib "APS168.dll" (ByVal Axis_ID As Long, Index As Long) As Long
Declare Function APS_get_start_point_index Lib "APS168.dll" (ByVal Axis_ID As Long, Index As Long) As Long
Declare Function APS_get_end_point_index Lib "APS168.dll" (ByVal Axis_ID As Long, Index As Long) As Long
Declare Function APS_set_table_move_pause Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Pause_en As Long) As Long
Declare Function APS_set_table_move_repeat Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Repeat_en As Long) As Long
Declare Function APS_get_table_move_repeat_count Lib "APS168.dll" (ByVal Axis_ID As Long, RepeatCnt As Long) As Long
Declare Function APS_point_table_move Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long, ByVal StartIndex As Long, ByVal EndIndex As Long) As Long
'
Declare Function APS_set_point_tableEx Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Index As Long, ByRef Point As PNT_DATA) As Long
Declare Function APS_get_point_tableEx Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Index As Long, ByRef Point As PNT_DATA) As Long
Declare Function APS_set_point_table_4DL Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal Index As Long, ByRef Point As PNT_DATA_4DL) As Long
Declare Function APS_set_point_tableEx_2D Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Axis_ID_2 As Long, ByVal Index As Long, ByRef Point As PNT_DATA_2D) As Long
'
' Point table + IO - Pause / Resume
Declare Function APS_set_table_move_ex_pause Lib "APS168.dll" (ByVal Axis_ID As Long) As Long
Declare Function APS_set_table_move_ex_rollback Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Max_Speed As Long) As Long
Declare Function APS_set_table_move_ex_resume Lib "APS168.dll" (ByVal Axis_ID As Long) As Long

'Only for PCI-8392 to replace APS_set_point_table & APS_get_point_table
Declare Function APS_set_point_table_ex Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Index As Long, ByRef Point As POINT_DATA_EX) As Long
Declare Function APS_get_point_table_ex Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Index As Long, ByRef Point As POINT_DATA_EX) As Long
'
' Point table Feeder (Only for PCI-825x)
Declare Function APS_set_feeder_group Lib "APS168.dll" (ByVal GroupId As Long, ByVal Dimension As Long, Axis_ID_Array As Long) As Long
Declare Function APS_get_feeder_group Lib "APS168.dll" (ByVal GroupId As Long, Dimension As Long, Axis_ID_Array As Long) As Long
Declare Function APS_free_feeder_group Lib "APS168.dll" (ByVal GroupId As Long) As Long
Declare Function APS_reset_feeder_buffer Lib "APS168.dll" (ByVal GroupId As Long) As Long
Declare Function APS_set_feeder_point_2D Lib "APS168.dll" (ByVal GroupId As Long, ByRef PtArray As PNT_DATA_2D, ByVal Size As Long, ByVal LastFlag As Long) As Long
Declare Function APS_start_feeder_move Lib "APS168.dll" (ByVal GroupId As Long) As Long
Declare Function APS_get_feeder_running_index Lib "APS168.dll" (ByVal GroupId As Long, Index As Long) As Long
Declare Function APS_get_feeder_feed_index Lib "APS168.dll" (ByVal GroupId As Long, Index As Long) As Long
Declare Function APS_set_feeder_ex_pause Lib "APS168.dll" (ByVal GroupId As Long) As Long
Declare Function APS_set_feeder_ex_rollback Lib "APS168.dll" (ByVal GroupId As Long, ByVal Max_Speed As Long) As Long
Declare Function APS_set_feeder_ex_resume Lib "APS168.dll" (ByVal GroupId As Long) As Long
Declare Function APS_set_feeder_cfg_acc_type Lib "APS168.dll" (ByVal GroupId As Long, ByVal APS_Type As Long) As Long
'
' Point table move2
Declare Function APS_set_point_table_mode2 Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Mode As Long) As Long
Declare Function APS_set_point_table2 Lib "APS168.dll" (ByVal Dimension As Long, ByRef Axis_ID_Array As Long, ByVal Index As Long, ByRef Point As POINT_DATA2) As Long
Declare Function APS_point_table_continuous_move2 Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long) As Long
Declare Function APS_point_table_single_move2 Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Index As Long) As Long
Declare Function APS_get_running_point_index2 Lib "APS168.dll" (ByVal Axis_ID As Long, Index As Long) As Long
Declare Function APS_point_table_status2 Lib "APS168.dll" (ByVal Axis_ID As Long, Status As Long) As Long
'
' Point table Only for HSL-4XMO
Declare Function APS_set_point_table3 Lib "APS168.dll" (ByVal Dimension As Long, ByRef Axis_ID_Array As Long, ByVal Index As Long, ByRef Point As POINT_DATA3) As Long
Declare Function APS_point_table_move3 Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long, ByVal StartIndex As Long, ByVal EndIndex As Long) As Long
Declare Function APS_set_point_table_param3 Lib "APS168.dll" (ByVal FirstAxid As Long, ByVal ParaNum As Long, ByVal ParaDat As Long) As Long
'
'  Gantry functions. [Only for PCI-8392, PCI-8253/56]
Declare Function APS_set_gantry_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal GroupNum As Long, ByVal ParaNum As Long, ByVal ParaDat As Long) As Long
Declare Function APS_get_gantry_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal GroupNum As Long, ByVal ParaNum As Long, ParaDat As Long) As Long
Declare Function APS_set_gantry_axis Lib "APS168.dll" (ByVal Board_ID As Long, ByVal GroupNum As Long, ByVal Master_Axis_ID As Long, ByVal Slave_Axis_ID As Long) As Long
Declare Function APS_get_gantry_axis Lib "APS168.dll" (ByVal Board_ID As Long, ByVal GroupNum As Long, Master_Axis_ID As Long, Slave_Axis_ID As Long) As Long
Declare Function APS_get_gantry_error Lib "APS168.dll" (ByVal Board_ID As Long, ByVal GroupNum As Long, GentryError As Long) As Long
'
'  Digital filter functions. [Only for PCI-8253/56]
Declare Function APS_set_filter_param Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Filter_paramNo As Long, ByVal Param_Val As Long) As Long
Declare Function APS_get_filter_param Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Filter_paramNo As Long, Param_Val As Long) As Long
'
' Field bus master fucntions For PCI-8392(H)
Declare Function APS_set_field_bus_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal BUS_Param_No As Long, ByVal BUS_Param As Long) As Long
Declare Function APS_get_field_bus_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal BUS_Param_No As Long, BUS_Param As Long) As Long
Declare Function APS_start_field_bus Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal start_axis_id As Long) As Long
Declare Function APS_stop_field_bus Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long) As Long
'
Declare Function APS_get_field_bus_device_info Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Info_No As Long, info As Long) As Long
Declare Function APS_get_field_bus_last_scan_info Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, Info_Array As Long, ByVal Array_Size As Long, Info_Count As Long) As Long
Declare Function APS_get_field_bus_master_type Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, BUS_Type As Long) As Long
Declare Function APS_get_field_bus_slave_type Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, MOD_Type As Long) As Long
Declare Function APS_get_field_bus_slave_name Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, MOD_Name As Long) As Long
Declare Function APS_get_field_bus_slave_first_axisno Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, AxisNo As Long, TotalAxes As Long) As Long
'
' Field bus slave general functions
Declare Function APS_set_field_bus_slave_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, ByVal ParaNum As Long, ByVal ParaDat As Long) As Long
Declare Function APS_get_field_bus_slave_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, ByVal ParaNum As Long, ParaDat As Long) As Long
Declare Function APS_get_slave_connect_quality Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, Sts_data As Long) As Long
Declare Function APS_get_slave_online_status Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, Live As Long) As Long
'
' Field bus DIO slave fucntions For PCI-8392(H)
Declare Function APS_set_field_bus_d_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal DO_Value As Long) As Long
Declare Function APS_get_field_bus_d_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, DO_Value As Long) As Long
Declare Function APS_get_field_bus_d_input Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, DI_Value As Long) As Long
Declare Function APS_set_field_bus_d_channel_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, ByVal DO_Value As Long) As Long
Declare Function APS_get_field_bus_d_channel_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, DO_Value As Long) As Long
Declare Function APS_get_field_bus_d_channel_input Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, DI_Value As Long) As Long
'
' Field bus AIO slave function
Declare Function APS_set_field_bus_a_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, ByVal AO_Value As Double) As Long
Declare Function APS_set_field_bus_a_output_plc Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, ByVal AO_Value As Double, ByVal RunStep As Integer) As Long
Declare Function APS_get_field_bus_a_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, AO_Value As Double) As Long
Declare Function APS_get_field_bus_a_input Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, AI_Value As Double) As Long
Declare Function APS_get_field_bus_a_input_plc Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, AI_Value As Double, ByVal RunStep As Integer) As Long
'
' Field bus Comparing trigger functions
Declare Function APS_set_field_bus_trigger_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Param_No As Long, ByVal Param_Val As Long) As Long
Declare Function APS_get_field_bus_trigger_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Param_No As Long, Param_Val As Long) As Long
Declare Function APS_set_field_bus_trigger_linear Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal LCmpCh As Long, ByVal StartPoint As Long, ByVal RepeatTimes As Long, ByVal Interval As Long) As Long
Declare Function APS_set_field_bus_trigger_table Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal TCmpCh As Long, DataArr As Long, ByVal ArraySize As Long) As Long
Declare Function APS_set_field_bus_trigger_manual Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal TrgCh As Long) As Long
Declare Function APS_set_field_bus_trigger_manual_s Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal TrgChInBit As Long) As Long
Declare Function APS_get_field_bus_trigger_table_cmp Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal TCmpCh As Long, CmpVal As Long) As Long
Declare Function APS_get_field_bus_trigger_linear_cmp Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal LCmpCh As Long, CmpVal As Long) As Long
Declare Function APS_get_field_bus_trigger_count Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal TrgCh As Long, TrgCnt As Long) As Long
Declare Function APS_reset_field_bus_trigger_count Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal TrgCh As Long) As Long
Declare Function APS_get_field_bus_linear_cmp_remain_count Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal LCmpCh As Long, Cnt As Long) As Long
Declare Function APS_get_field_bus_table_cmp_remain_count Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal TCmpCh As Long, Cnt As Long) As Long
Declare Function APS_get_field_bus_encoder Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal EncCh As Long, EncCnt As Long) As Long
Declare Function APS_set_field_bus_encoder Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal EncCh As Long, ByVal EncCnt As Long) As Long
'
'  Comparing trigger functions
Declare Function APS_set_trigger_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Param_No As Long, ByVal Param_Val As Long) As Long
Declare Function APS_get_trigger_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Param_No As Long, Param_Val As Long) As Long
Declare Function APS_set_trigger_linear Lib "APS168.dll" (ByVal Board_ID As Long, ByVal LCmpCh As Long, ByVal StartPoint As Long, ByVal RepeatTimes As Long, ByVal Interval As Long) As Long
Declare Function APS_set_trigger_table Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TCmpCh As Long, ByRef DataArr As Long, ByVal ArraySize As Long) As Long
Declare Function APS_set_trigger_manual Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TrgCh As Long) As Long
Declare Function APS_set_trigger_manual_s Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TrgChInBit As Long) As Long
Declare Function APS_get_trigger_table_cmp Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TCmpCh As Long, CmpVal As Long) As Long
Declare Function APS_get_trigger_linear_cmp Lib "APS168.dll" (ByVal Board_ID As Long, ByVal LCmpCh As Long, CmpVal As Long) As Long
Declare Function APS_get_trigger_count Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TrgCh As Long, TrgCnt As Long) As Long
Declare Function APS_reset_trigger_count Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TrgCh As Long) As Long
Declare Function APS_get_timer_counter Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TmrCh As Long, Cnt As Long) As Long
Declare Function APS_set_timer_counter Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TmrCh As Long, ByVal Cnt As Long) As Long
Declare Function APS_enable_trigger_fifo_cmp Lib "APS168.dll" (ByVal Board_ID As Long, ByVal FCmpCh As Long, ByVal Enable As Long) As Long
Declare Function APS_get_trigger_fifo_cmp Lib "APS168.dll" (ByVal Board_ID As Long, ByVal FCmpCh As Long, CmpVal As Long) As Long
Declare Function APS_get_trigger_fifo_status Lib "APS168.dll" (ByVal Board_ID As Long, ByVal FCmpCh As Long, FifoSts As Long) As Long
Declare Function APS_set_trigger_fifo_data Lib "APS168.dll" (ByVal Board_ID As Long, ByVal FCmpCh As Long, DataArr As Long, ByVal ArraySize As Long, ByVal ShiftFlag As Long) As Long
Declare Function APS_set_trigger_encoder_counter Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TrgCh As Long, ByVal TrgCnt As Long) As Long
Declare Function APS_get_trigger_encoder_counter Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TrgCh As Long, TrgCnt As Long) As Long
Declare Function APS_start_timer Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TrgCh As Long, ByVal Start As Long) As Long
'
'  Pulser counter function
Declare Function APS_get_pulser_counter Lib "APS168.dll" (ByVal Board_ID As Long, Counter As Long) As Long
Declare Function APS_set_pulser_counter Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Counter As Long) As Long
'
'  Reserved functions
Declare Function APS_field_bus_slave_set_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, ByVal ParaNum As Long, ByVal ParaDat As Long) As Long
Declare Function APS_field_bus_slave_get_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, ByVal ParaNum As Long, ParaDat As Long) As Long
'
Declare Function APS_field_bus_d_set_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal DO_Value As Long) As Long
Declare Function APS_field_bus_d_get_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, DO_Value As Long) As Long
Declare Function APS_field_bus_d_get_input Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, DI_Value As Long) As Long
'
Declare Function APS_field_bus_A_set_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, ByVal AO_Value As Double) As Long
Declare Function APS_field_bus_A_set_output_plc Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, ByVal AO_Value As Double, ByVal RunStep As Integer) As Long
Declare Function APS_field_bus_A_get_output Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, AO_Value As Double) As Long
Declare Function APS_field_bus_A_get_input Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, AI_Value As Double) As Long
Declare Function APS_field_bus_A_get_input_plc Lib "APS168.dll" (ByVal Board_ID As Long, ByVal BUS_No As Long, ByVal MOD_No As Long, ByVal Ch_No As Long, AI_Value As Double, ByVal RunStep As Integer) As Long
'
' Dpac Function
Declare Function APS_rescan_CF Lib "APS168.dll" (ByVal Board_ID As Long) As Long
Declare Function APS_get_battery_status Lib "APS168.dll" (ByVal Board_ID As Long, Battery_status As Long) As Long
'
' DPAC Display & Display Button
Declare Function APS_get_display_data Lib "APS168.dll" (ByVal Board_ID As Long, ByVal displayDigit As Long, displayIndex As Long) As Long
Declare Function APS_set_display_data Lib "APS168.dll" (ByVal Board_ID As Long, ByVal displayDigit As Long, ByVal displayIndex As Long) As Long
Declare Function APS_get_button_status Lib "APS168.dll" (ByVal Board_ID As Long, buttonstatus As Long) As Long
'
' nv RAM funciton
Declare Function APS_set_nv_ram Lib "APS168.dll" (ByVal Board_ID As Long, ByVal RamNo As Long, ByVal DataWidth As Long, ByVal Offset As Long, ByVal Data As Long) As Long
Declare Function APS_get_nv_ram Lib "APS168.dll" (ByVal Board_ID As Long, ByVal RamNo As Long, ByVal DataWidth As Long, ByVal Offset As Long, Data As Long) As Long
Declare Function APS_clear_nv_ram Lib "APS168.dll" (ByVal Board_ID As Long, ByVal RamNo As Long) As Long
'
' VAO function(Laser function) [Only for PCI-8253/6]
Declare Function APS_set_vao_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Param_No As Long, ByVal Param_Val As Long) As Long
Declare Function APS_get_vao_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Param_No As Long, Param_Val As Long) As Long
Declare Function APS_set_vao_table Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Table_No As Long, ByVal MinVelocity As Long, ByVal VelInterval As Long, ByVal TotalPoints As Long, ByRef MappingDataArray As Long) As Long
                                                                                                                                                                                                        
Declare Function APS_switch_vao_table Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Table_No As Long) As Long
Declare Function APS_start_vao Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Output_Ch As Long, ByVal Enable As Long) As Long
Declare Function APS_get_vao_status Lib "APS168.dll" (ByVal Board_ID As Long, Status As Long) As Long
Declare Function APS_check_vao_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Table_No As Long, Status As Long) As Long
Declare Function APS_set_vao_param_ex Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Table_No As Long, ByRef VaoData As VAO_DATA) As Long
Declare Function APS_get_vao_param_ex Lib "APS168.dll" (ByVal Board_ID As Long, ByVal Table_No As Long, ByRef VaoData As VAO_DATA) As Long
' PWM function
Declare Function APS_set_pwm_width Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PWM_Ch As Long, ByVal Width As Long) As Long
Declare Function APS_get_pwm_width Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PWM_Ch As Long, Width As Long) As Long
Declare Function APS_set_pwm_frequency Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PWM_Ch As Long, ByVal Frequency As Long) As Long
Declare Function APS_get_pwm_frequency Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PWM_Ch As Long, Frequency As Long) As Long
Declare Function APS_set_pwm_on Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PWM_Ch As Long, ByVal PWM_On As Long) As Long
'
' Simultaneous move [Only for MNET series and 8392]
Declare Function APS_set_relative_simultaneous_move Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long, Distance_Array As Long, Max_Speed_Array As Long) As Long
Declare Function APS_set_absolute_simultaneous_move Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long, Position_Array As Long, Max_Speed_Array As Long) As Long
Declare Function APS_start_simultaneous_move Lib "APS168.dll" (ByVal Axis_ID As Long) As Long
Declare Function APS_stop_simultaneous_move Lib "APS168.dll" (ByVal Axis_ID As Long) As Long
Declare Function APS_set_velocity_simultaneous_move Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long, Max_Speed_Array As Long) As Long
Declare Function APS_release_simultaneous_move Lib "APS168.dll" (ByVal Axis_ID As Long) As Long
Declare Function APS_emg_stop_simultaneous_move Lib "APS168.dll" (ByVal Axis_ID As Long) As Long
'
' Override functions [Only for MNET series]
Declare Function APS_speed_override Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal MaxSpeed As Long) As Long
'
' Only for MNET-1XMO/MNET-4XMO
Declare Function APS_relative_move_ovrd Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Distance As Long, ByVal Max_Speed As Long) As Long
Declare Function APS_absolute_move_ovrd Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Position As Long, ByVal Max_Speed As Long) As Long
'
' New Interface
Declare Function APS_ptp Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal APS_Option As Long, ByVal Position As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_ptp_v Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal APS_Option As Long, ByVal Position As Double, ByVal Vm As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_ptp_all Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal APS_Option As Long, ByVal Position As Double, ByVal Vs As Double, ByVal Vm As Double, ByVal Ve As Double, ByVal Acc As Double, ByVal Dec As Double, ByVal SFac As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_vel Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal APS_Option As Long, ByVal Vm As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_vel_all Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal APS_Option As Long, ByVal Vs As Double, ByVal Vm As Double, ByVal Ve As Double, ByVal Acc As Double, ByVal Dec As Double, ByVal SFac As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_line Lib "APS168.dll" (ByVal Dimension As Long, ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef PositionArray As Double, ByRef TransPara As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_line_v Lib "APS168.dll" (ByVal Dimension As Long, ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef PositionArray As Double, ByRef TransPara As Double, ByVal Vm As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_line_all Lib "APS168.dll" (ByVal Dimension As Long, ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef PositionArray As Double, ByRef TransPara As Double, ByVal Vs As Double, ByVal Vm As Double, ByVal Ve As Double, ByVal Acc As Double, ByVal Dec As Double, ByVal SFac As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_arc2_ca Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByVal Angle As Double, ByRef TransPara As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_arc2_ca_v Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByVal Angle As Double, ByRef TransPara As Double, ByVal Vm As Long, ByRef Wait As ASYNCALL) As Long
Declare Function APS_arc2_ca_all Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByVal Angle As Double, ByRef TransPara As Double, ByVal Vs As Double, ByVal Vm As Double, ByVal Ve As Double, ByVal Acc As Double, ByVal Dec As Double, ByVal SFac As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_arc2_ce Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef EndArray As Double, ByVal Dir As Integer, ByRef TransPara As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_arc2_ce_v Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef EndArray As Double, ByVal Dir As Integer, ByRef TransPara As Double, ByVal Vm As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_arc2_ce_all Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef EndArray As Double, ByVal Dir As Integer, ByRef TransPara As Double, ByVal Vs As Double, ByVal Vm As Double, ByVal Ve As Double, ByVal Acc As Double, ByVal Dec As Double, ByVal SFac As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_arc3_ca Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef NormalArray As Double, ByVal Angle As Double, ByRef TransPara As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_arc3_ca_v Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef NormalArray As Double, ByVal Angle As Double, ByRef TransPara As Double, ByVal Vm As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_arc3_ca_all Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef NormalArray As Double, ByVal Angle As Double, ByRef TransPara As Double, ByVal Vs As Double, ByVal Vm As Double, ByVal Ve As Double, ByVal Acc As Double, ByVal Dec As Double, ByVal SFac As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_arc3_ce Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef EndArray As Double, ByVal Dir As Integer, ByRef TransPara As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_arc3_ce_v Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef EndArray As Double, ByVal Dir As Integer, ByRef TransPara As Double, ByVal Vm As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_arc3_ce_all Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef EndArray As Double, ByVal Dir As Integer, ByRef TransPara As Double, ByVal Vs As Double, ByVal Vm As Double, ByVal Ve As Double, ByVal Acc As Double, ByVal Dec As Double, ByVal SFac As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_spiral_ca Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef NormalArray As Double, ByVal Angle As Double, ByVal DeltaH As Double, ByVal FinalR As Double, ByRef TransPara As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_spiral_ca_v Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef NormalArray As Double, ByVal Angle As Double, ByVal DeltaH As Double, ByVal FinalR As Double, ByRef TransPara As Double, ByVal Vm As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_spiral_ca_all Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef NormalArray As Double, ByVal Angle As Double, ByVal DeltaH As Double, ByVal FinalR As Double, ByRef TransPara As Double, ByVal Vs As Double, ByVal Vm As Double, ByVal Ve As Double, ByVal Acc As Double, ByVal Dec As Double, ByVal SFac As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_spiral_ce Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef NormalArray As Double, ByRef EndArray As Double, ByVal Dir As Integer, ByRef TransPara As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_spiral_ce_v Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef NormalArray As Double, ByRef EndArray As Double, ByVal Dir As Integer, ByRef TransPara As Double, ByVal Vm As Double, ByRef Wait As ASYNCALL) As Long
Declare Function APS_spiral_ce_all Lib "APS168.dll" (ByRef Axis_ID_Array As Long, ByVal APS_Option As Long, ByRef CenterArray As Double, ByRef NormalArray As Double, ByRef EndArray As Double, ByVal Dir As Integer, ByRef TransPara As Double, ByVal Vs As Double, ByVal Vm As Double, ByVal Ve As Double, ByVal Acc As Double, ByVal Dec As Double, ByVal SFac As Double, ByRef Wait As ASYNCALL) As Long
'
' Point table Feeder (Only for PCI-8254/8)
Declare Function APS_pt_dwell Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByRef Prof As PTDWL, ByRef Status As PTSTS) As Long
Declare Function APS_pt_line Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, Prof As PTLINE, ByRef Status As PTSTS) As Long
Declare Function APS_pt_arc2_ca Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByRef Prof As PTA2CA, ByRef Status As PTSTS) As Long
Declare Function APS_pt_arc2_ce Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByRef Prof As PTA2CE, ByRef Status As PTSTS) As Long
Declare Function APS_pt_arc3_ca Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByRef Prof As PTA3CA, ByRef Status As PTSTS) As Long
Declare Function APS_pt_arc3_ce Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByRef Prof As PTA3CE, ByRef Status As PTSTS) As Long
Declare Function APS_pt_spiral_ca Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByRef Prof As PTHCA, ByRef Status As PTSTS) As Long
Declare Function APS_pt_spiral_ce Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByRef Prof As PTHCE, ByRef Status As PTSTS) As Long

' enable & disable
Declare Function APS_pt_enable Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal Dimension As Long, ByRef AxisArr As Long) As Long
Declare Function APS_pt_disable Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long) As Long
Declare Function APS_get_pt_info Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByRef info As PTINFO) As Long
Declare Function APS_pt_set_vs Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal Vs As Double) As Long
Declare Function APS_pt_get_vs Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, Vs As Double) As Long
Declare Function APS_pt_start Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long) As Long
Declare Function APS_pt_stop Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long) As Long
Declare Function APS_get_pt_status Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByRef Status As PTSTS) As Long
Declare Function APS_reset_pt_buffer Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long) As Long
Declare Function APS_pt_roll_back Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal Max_Speed As Double) As Long
Declare Function APS_pt_get_error Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ErrCode As Long) As Long
' Cmd buffer setting
Declare Function APS_pt_ext_set_do_ch Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal Channel As Long, ByVal OnOff As Long) As Long
Declare Function APS_pt_ext_set_table_no Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal CtrlNo As Long, ByVal TableNo As Long) As Long
'
' Profile buffer setting
Declare Function APS_pt_set_absolute Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long) As Long
Declare Function APS_pt_set_relative Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long) As Long
Declare Function APS_pt_set_trans_buffered Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long) As Long
Declare Function APS_pt_set_trans_inp Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long) As Long
Declare Function APS_pt_set_trans_blend_dec Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal BP As Double) As Long
Declare Function APS_pt_set_trans_blend_dist Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal BP As Double) As Long
Declare Function APS_pt_set_trans_blend_pcnt Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal BP As Double) As Long
Declare Function APS_pt_set_acc Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal Acc As Double) As Long
Declare Function APS_pt_set_dec Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal Dec As Double) As Long
Declare Function APS_pt_set_acc_dec Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal AccDec As Double) As Long
Declare Function APS_pt_set_s Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal Sf As Double) As Long
Declare Function APS_pt_set_vm Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal Vm As Double) As Long
Declare Function APS_pt_set_ve Lib "APS168.dll" (ByVal Board_ID As Long, ByVal PtbId As Long, ByVal Ve As Double) As Long
'
' Program download - APS
Declare Function APS_load_vmc_program Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TaskNum As Long, ByVal File As String, ByVal Password As Long) As Long
Declare Function APS_save_vmc_program Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TaskNum As Long, ByVal File As String, ByVal Password As Long) As Long
Declare Function APS_load_amc_program Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TaskNum As Long, ByVal File As String, ByVal Password As Long) As Long
Declare Function APS_save_amc_program Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TaskNum As Long, ByVal File As String, ByVal Password As Long) As Long
Declare Function APS_set_task_mode Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TaskNum As Long, ByVal Mode As Byte, ByVal LastIP As Integer) As Long
Declare Function APS_get_task_mode Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TaskNum As Long, Mode As Byte, LastIP As Integer) As Long
Declare Function APS_start_task Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TaskNum As Long, ByVal CtrlCmd As Long) As Long
Declare Function APS_get_task_info Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TaskNum As Long, ByRef info As TSK_INFO) As Long
Declare Function APS_get_task_msg Lib "APS168.dll" (ByVal Board_ID As Long, QueueSts As Integer, ActualSize As Integer, CharArr As Byte) As Long
'
' Latch functins
Declare Function APS_get_encoder Lib "APS168.dll" (ByVal Axis_ID As Long, Encoder As Long) As Long
Declare Function APS_get_latch_counter Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Src As Long, Counter As Long) As Long
Declare Function APS_get_latch_event Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Src As Long, APS_Event As Long) As Long
'
' Raw command counter [Only for PCI-8254/8]
Declare Function APS_get_command_counter Lib "APS168.dll" (ByVal Axis_ID As Long, Counter As Long) As Long
'
' Watch dog timer
Declare Function APS_wdt_start Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TimerNo As Long, ByVal TimeOut As Long) As Long
Declare Function APS_wdt_get_timeout_period Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TimerNo As Long, TimeOut As Long) As Long
Declare Function APS_wdt_reset_counter Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TimerNo As Long) As Long
Declare Function APS_wdt_get_counter Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TimerNo As Long, Counter As Long) As Long
Declare Function APS_wdt_set_action_event Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TimerNo As Long, ByVal EventByBit As Long) As Long
Declare Function APS_wdt_get_action_event Lib "APS168.dll" (ByVal Board_ID As Long, ByVal TimerNo As Long, EventByBit As Long) As Long
'
' Multi-axes simultaneuos move start/stop
Declare Function APS_move_trigger Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long) As Long
Declare Function APS_stop_move_multi Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long) As Long
Declare Function APS_emg_stop_multi Lib "APS168.dll" (ByVal Dimension As Long, Axis_ID_Array As Long) As Long
'
' Gear/Gantry function
Declare Function APS_start_gear Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Mode As Long) As Long
Declare Function APS_get_gear_status Lib "APS168.dll" (ByVal Axis_ID As Long, Status As Long) As Long
'
'Latch Function: for latching multi-points
Declare Function APS_set_ltc_counter Lib "APS168.dll" (ByVal Board_ID As Long, ByVal CntNum As Long, ByVal CntValue As Long) As Long
Declare Function APS_get_ltc_counter Lib "APS168.dll" (ByVal Board_ID As Long, ByVal CntNum As Long, CntValue As Long) As Long
Declare Function APS_set_ltc_fifo_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal FLtcCh As Long, ByVal Param_No As Long, ByVal Param_Val As Long) As Long
Declare Function APS_get_ltc_fifo_param Lib "APS168.dll" (ByVal Board_ID As Long, ByVal FLtcCh As Long, ByVal Param_No As Long, Param_Val As Long) As Long
Declare Function APS_manual_latch Lib "APS168.dll" (ByVal Board_ID As Long, ByVal LatchSignalInBits As Long) As Long
Declare Function APS_enable_ltc_fifo Lib "APS168.dll" (ByVal Board_ID As Long, ByVal FLtcCh As Long, ByVal Enable As Long) As Long
Declare Function APS_reset_ltc_fifo Lib "APS168.dll" (ByVal Board_ID As Long, ByVal FLtcCh As Long) As Long
Declare Function APS_get_ltc_fifo_data Lib "APS168.dll" (ByVal Board_ID As Long, ByVal FLtcCh As Long, Data As Long) As Long
Declare Function APS_get_ltc_fifo_usage Lib "APS168.dll" (ByVal Board_ID As Long, ByVal FLtcCh As Long, Usage As Long) As Long
Declare Function APS_get_ltc_fifo_free_space Lib "APS168.dll" (ByVal Board_ID As Long, ByVal FLtcCh As Long, FreeSpace As Long) As Long
Declare Function APS_get_ltc_fifo_status Lib "APS168.dll" (ByVal Board_ID As Long, ByVal FLtcCh As Long, Status As Long) As Long

'For Single latch for PCI8154/58/MNET-4XMO-(C)
Declare Function APS_manual_latch2 Lib "APS168.dll" (ByVal Axis_ID As Long) As Long
Declare Function APS_get_latch_data2 Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal LatchNum As Long, LatchData As Long) As Long
Declare Function APS_set_backlash_en Lib "APS168.dll" (ByVal Axis_ID As Long, ByVal Enable As Long) As Long
Declare Function APS_get_backlash_en Lib "APS168.dll" (ByVal Axis_ID As Long, Enable As Long) As Long

'
Declare Function VarPtrArray Lib "msvbvm60.dll" Alias "VarPtr" _
(Var() As Any) As Long


