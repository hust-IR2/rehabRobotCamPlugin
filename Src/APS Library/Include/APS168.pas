unit APS168;

interface

//Data Struct Define////////////////////////////////////////////////////////////////////////////

type STR_SAMP_DATA_4CH =record
	tick:Longint;
	data: array[1..4] of Longint; //Total channel = 4
end;

type STR_SAMP_DATA_8CH =record
	tick:Longint;
	data: array[1..8] of Longint; //Total channel = 8
end;

type POINT_DATA_EX   =record 
     i32_pos:Longint;              //(Center)Position data (could be relative or absolute value) 
     i16_accType:SmallInt;       //Acceleration pattern 0: T curve, 1:S curve   
     i16_decType:SmallInt;       // Deceleration pattern 0: T curve, 1:S curve 
     i32_acc:Longint;             //Acceleration rate ( pulse / sec 2 ) 
     i32_dec:Longint;             //Deceleration rate ( pulse / sec 2  ) 
     i32_initSpeed:Longint;     //Start velocity ( pulse / s ) 
     i32_maxSpeed:Longint;  //Maximum velocity    ( pulse / s ) 
     i32_endSpeed:Longint;   //End velocity  ( pulse / s )     
     i32_angle:Longint;          //Arc move angle ( degree, -360 ~ 360 ) 
     u32_dwell:DWord;         //dwell times ( unit: ms ) *Divided by system cycle time. 
     i32_opt:Longint;              //Point move option. (*) 
    
     i32_pitch:Longint;			// pitch for helical move
     i32_totalheight:Longint;	// total hight
	   i16_cw:SmallInt;			// cw or ccw
     i16_opt_ext:SmallInt;		// option extend
end; 

type POS_DATA_2D=record 
     u32_opt:DWord;       // option, [0x00000000,0xFFFFFFFF]
     i32_x:Longint;          // x-axis component (pulse), [-2147483648,2147484647]
     i32_y:Longint;          // y-axis component (pulse), [-2147483648,2147484647]
     i32_theta:Longint;      // x-y plane arc move angle (0.000001 degree), [-360000,360000]
end; 

type PNT_DATA_2D=record
     u32_opt:DWord;         // option, [0x00000000,0xFFFFFFFF]
     i32_x:Longint;           // x-axis component (pulse), [-2147483648,2147484647]
     i32_y:Longint;           // y-axis component (pulse), [-2147483648,2147484647]
     i32_theta:Longint;       // x-y plane arc move angle (0.000001 degree), [-360000,360000]
     i32_acc:Longint;         // acceleration rate (pulse/ss), [0,2147484647]
     i32_dec:Longint;         // deceleration rate (pulse/ss), [0,2147484647]
     i32_vi:Longint;          // initial velocity (pulse/s), [0,2147484647]
     i32_vm:Longint;          // maximum velocity (pulse/s), [0,2147484647]
     i32_ve:Longint;          // ending velocity (pulse/s), [0,2147484647]
end;

// Point table structure (Four dimension)
type PNT_DATA_4DL=record
     u32_opt:DWord;          // option, [0x00000000,0xFFFFFFFF]
     i32_x:Longint;          // x-axis component (pulse), [-2147483648,2147484647]
     i32_y:Longint;          // y-axis component (pulse), [-2147483648,2147484647]
     i32_z:Longint;          // z-axis component (pulse), [-2147483648,2147484647]
     i32_u:Longint;          // u-axis component (pulse), [-2147483648,2147484647]
     i32_acc:Longint;        // acceleration rate (pulse/ss), [0,2147484647]
     i32_dec:Longint;        // deceleration rate (pulse/ss), [0,2147484647]
     i32_vi:Longint;         // initial velocity (pulse/s), [0,2147484647]
     i32_vm:Longint;         // maximum velocity (pulse/s), [0,2147484647]
     i32_ve:Longint;         // ending velocity (pulse/s), [0,2147484647]
end;

//Asynchronized call
type ASYNCALL=record
	  h_event;HANDLE; 
    i32_ret:Longint;   
end;

type TSK_INFO=record
     State:Word;      	// 
     RunTimeErr:Word;     // 
     IP:Word;
     SP:Word;
     BP:Word;
	   MsgQueueSts:Word;
end;

type VAO_DATA=record
	//Param
	 outputType:Longint;	//Output type, [0, 3]
	 inputType:Longint;	//Input type, [0, 1]
	 config:Longint;			//PWM configuration according to output type
	 inputSrc:Longint;		//Input source by axis, [0, 0xf]
	 
	//Mapping table
	 minVel:Longint;		//Minimum linear speed, [ positive ]
	 velInterval:Longint;	//Speed interval, [ positive ]
	 totalPoints:Longint;	//Total points, [1, 32]
	 mappingDataArr: array[1..32] of Longint; //mapping data array
end;

MAX_SAMPL_CH					:Longint=8;
MAX_SAMPL_SRC					:Longint=2;

type SAMP_PARAM=record
	rate:Longint;							          		//Sampling rate
	edge:Longint;						 	          		//Trigger edge
	level:Longint;							        		//Trigger level
	trigCh:Longint;							        		//Trigger channel
	sourceByCh:array[1..8,1..2] of Longint; //mapping data array
end;

MAX_PT_DIM			:Longint=6;

type PTINFO=record
	 Dimension:Longint;	
	 AxisArr:array[1..6] of Longint;
end;

type PTDWL 
   DwTime:Double; //Unit is ms
end;

type PTLINE =record
	Dim:Longint;	
	Pos:array[1..6] of Double;
end;

MAXHEXLIX									:Longint=$3; //Helix axes is 3.
MAXARC3										:Longint=$3; //ARC3 axes is 3.
MAXARC2										:Longint=$2; //ARC2 axes is 2.

type PTA2CA=record
	Index:array[1..2] of Byte;    //Index X,Y
	Center:array[1..2] of Double; //Center Arr
	Angle:Double;                 //Angle
end;

type PTA2CE =record

	Index:array[1..2] of Byte;
	Center:array[1..2] of Double;
	End:array[1..2] of Double;
	Dir:SmallInt;    
end;

type PTA3CA =record

	Index:array[1..3] of Byte;
	Center:array[1..3] of Double;
	Normal:array[1..3] of Double;
	Angle:Double;    
end;

type PTA3CE =record
	Index:array[1..3] of Byte;
	Center:array[1..3] of Double;
	End:array[1..3] of Double;
	Dir:SmallInt; 
end;

type PTHCA =record

  Index:array[1..3] of Byte;
	Center:array[1..3] of Double;
	Normal:array[1..3] of Double;
	Angle:Double;
	DeltaH:Double;
	FinalR:Double; 
end;

type PTHCE =record
  Index:array[1..3] of Byte;
	Center:array[1..3] of Double;
	Normal:array[1..3] of Double;
	End:array[1..3] of Double;
	Dir:SmallInt;
end;

type PTSTS =record
	 BitSts:Word;
	 PntBufFreeSpace:Word;
	 PntBufUsageSpace:Word;	
	 RunningCnt:ULong;
end;

type LPSTS =record
	U32 MotionLoopLoading:ULong;
	U32 HostLoopLoading:ULong;
	U32 MotionLoopLoadingMax:ULong;
	U32 HostLoopLoadingMax:ULong;
end;

type DEBUG_DATA =record
	 ServoOffCondition:Word;	
	 DspCmdPos:Double;		
	 DspFeedbackPos:Double;		
	 FpgaCmdPos:Double;		
	 FpgaFeedbackPos:Double;		
	 FpgaOutputVoltage:Double;		
end;

type DEBUG_STATE=record
	U16 AxisState:Word;	
	U16 GroupState:Word;	
	U16 AxisSuperState:Word;	
end;

type MOVE_PARA = record
	 i16_accType:Smallint;	//Axis parameter
	 i16_decType:Smallint;	//Axis parameter
	 i32_acc:Longint;		//Axis parameter
	 i32_dec:Longint;		//Axis parameter
	 i32_initSpeed:Longint;	//Axis parameter
	 i32_maxSpeed:Longint;	//Axis parameter
	 i32_endSpeed:Longint; 	//Axis parameter
end ;

type POINT_DATA =record
	 i32_pos:Longint;		// Position data (relative or absolute) (pulse)
	 i16_accType:Smallint;	// Acceleration pattern 0: T-curve;  1: S-curve
	 i16_decType:Smallint;	// Deceleration pattern 0: T-curve;  1: S-curve
	 i32_acc:Longint;		// Acceleration rate ( pulse / ss )
	 i32_dec:Longint;		// Deceleration rate ( pulse / ss )
	 i32_initSpeed:Longint;	// Start velocity	( pulse / s )
	 i32_maxSpeed:Longint;	// Maximum velocity  ( pulse / s )
	 i32_endSpeed:Longint; 	// End velocity		( pulse / s )
	 i32_angle:Longint;		// Arc move angle    ( degree; -360 ~ 360 )
	 u32_dwell:Longword;		// Dwell times       ( unit: ms )
	 i32_opt:Longint;    	// Option //0xABCD ; D:0 absolute; 1:relative
end;

type POINT_DATA2 =record
	 i32_pos:array[0..15] of Longint;	// Position data (relative or absolute) (pulse)
	 i32_initSpeed:Longint;	// Start velocity	( pulse / s ) 
	 i32_maxSpeed:Longint;	// Maximum velocity  ( pulse / s ) 
	 i32_angle:Longint;		// Arc move angle    ( degree; -360 ~ 360 )
	 u32_dwell:Longint;		// Dwell times       ( unit: ms )
	 i32_opt:Longint;    	// Option //0xABCD ; D:0 absolute; 1:relative

end;

type POINT_DATA3 =record
	 i32_pos:array[0..3] of Longint;
	 i32_maxSpeed:Longint;
	 i32_endPos:array[0..1] of Longint;
	 i32_dir:Longint;
	 i32_opt:Longint;
end;


type JOG_DATA = record
   i16_jogMode:Smallint;	  // Jog mode. 0:Free running mode; 1:Step mode
	 i16_dir:Smallint;		    // Jog direction. 0:positive; 1:negative direction
	 i16_accType:Smallint;	  // Acceleration pattern 0: T-curve;  1: S-curve
	 i32_acc:Longint;		      // Acceleration rate ( pulse / ss )
	 i32_dec:Longint;		      // Deceleration rate ( pulse / ss )
	 i32_maxSpeed:Longint;	  // Positive value; maximum velocity  ( pulse / s )
	 i32_offset:Longint;		  // Positive value; a step (pulse)
	 i32_delayTime:Longint;   // Delay time; ( range: 0 ~ 65535 millisecond; align by cycle time)
end;

type HOME_PARA=record
	 u8_homeMode:Byte;
	 u8_homeDir:Byte;
	 u8_curveType:Byte;

	 i32_orgOffset:Longint;
	 i32_acceleration:Longint;
	 i32_startVelocity:Longint;
	 i32_maxVelocity:Longint;
	 i32_OrgVelocity:Longint;
end;


type FILTER_COEF=record
	 a1:Double;			// Biquad filter output polynomial coefficient
	 a2:Double;			// Biquad filter output polynomial coefficient
	 b0:Double;			// Biquad filter input polynomial coefficient
	 b1:Double;			// Biquad filter input polynomial coefficient
	 b2:Double;			// Biquad filter input polynomial coefficient
end;

//New ADCNC structure define
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
type POS_DATA_2D_F64=record		
{
    u32_opt:Longint;        // option, [0x00000000, 0xFFFFFFFF]
    f64_x:Double;          // x-axis component (pulse), [-9223372036854775808, 9223372036854775807]
    f64_y:Double;          // y-axis component (pulse), [-9223372036854775808, 9223372036854775807]
    f64_theta:Double;      // x-y plane arc move angle (0.000001 degree), [-360000, 360000]
}
end;

type POS_DATA_2D_RPS=record		/* This structure adds another variable to record what point was be saved */
{
     u32_opt:Longint;        // option, [0x00000000, 0xFFFFFFFF]
	   i32_x:Longint;          // x-axis component (pulse), [-2147483648, 2147483647]
     i32_y:Longint;          // y-axis component (pulse), [-2147483648, 2147483647]
     i32_theta:Longint;      // x-y plane arc move angle (0.000001 degree), [-360000, 360000]
	   crpi:Longint;			     // current reading point index
}
end;

type POS_DATA_2D_F64_RPS		/* This structure adds another variable to record what point was be saved */
{
     u32_opt:Longint;        // option, [0x00000000, 0xFFFFFFFF]
	   f64_x:Double;          // x-axis component (pulse), [-2147483648, 2147483647]
     f64_y:Double;          // y-axis component (pulse), [-2147483648, 2147483647]
     f64_theta:Double;      // x-y plane arc move angle (0.000001 degree), [-360000, 360000]
	   crpi:Longint;			    // current reading point index
}
end;

type PNT_DATA_2D_EXT
{
    U32  u32_opt:Longint;        // option, [0x00000000,0xFFFFFFFF]
    F64  f64_x:Double;          // x-axis component (pulse), [-2147483648,2147484647]
    F64  f64_y:Double;          // y-axis component (pulse), [-2147483648,2147484647]
    F64  f64_theta:Double;      // x-y plane arc move angle (0.000001 degree), [-360000,360000]
	  F64  f64_acc[4]:Double;        // acceleration rate (pulse/ss), [0,2147484647]
    F64  f64_dec[4]:Double;        // deceleration rate (pulse/ss), [0,2147484647]
	  I32  crossover:Longint;
	  I32  Iboundary:Longint;		// initial boundary
    F64  f64_vi[4]:Double;      // initial velocity (pulse/s), [0,2147484647]
	  U32  vi_cmpr:Longint;
    F64  f64_vm[4]:Double;      // maximum velocity (pulse/s), [0,2147484647]
	  U32  vm_cmpr:Longint;
    F64  f64_ve[4]:Double;      // ending velocity (pulse/s), [0,2147484647]
	  U32  ve_cmpr:Longint;
	  I32  Eboundary:Longint;		// end boundary
	  F64  f64_dist:Double;		// point distance
	  F64  f64_angle:Double;		// path angle between previous & current point
	  F64  f64_radius:Double;		// point radiua (used in arc move)
	  I32  i32_arcstate:Longint;
	  U32  spt:Longint;			// speed profile type
	  F64  t[4]:Double;
	  
	// Horizontal & Vertical line flag
	  I32  HorizontalFlag:Longint;
	  I32  VerticalFlag:Longint;
}
end;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// System & Initialization
function APS_initial(   var BoardID_InBits :Longint;   Mode:Longint):Longint;stdcall;
function APS_close():Longint;stdcall;
function APS_version():Longint;stdcall;
function APS_device_driver_version( Board_ID:Longint ):Longint;stdcall;
function APS_get_axis_info( Axis_ID:Longint;   var Board_ID:Longint;   var Axis_No:Longint;   var Port_ID:Longint;   var Module_ID:Longint ):Longint;stdcall;
function APS_set_board_param( Board_ID:Longint;   BOD_Param_No:Longint;   BOD_Param :Longint):Longint;stdcall;
function APS_get_board_param( Board_ID:Longint;   BOD_Param_No:Longint;   var BOD_Param :Longint):Longint;stdcall;
function APS_set_axis_param( Axis_ID:Longint;   AXS_Param_No:Longint;    AXS_Param :Longint):Longint;stdcall;
function APS_get_axis_param( Axis_ID:Longint;   AXS_Param_No:Longint;   var AXS_Param :Longint):Longint;stdcall;
function APS_get_watch_timer( Board_ID:Longint;   var Timer:Longint ):Longint;stdcall;
function APS_get_device_info( Board_ID:Longint;   Info_No:Longint;   var Info:Longint ):Longint;stdcall;
function APS_get_card_name( Board_ID:Longint;   var CardName:Longint ):Longint;stdcall;
function APS_disable_device(   DeviceName:Longint ):Longint;stdcall;
function APS_get_first_axisId( Board_ID:Longint; var StartAxisID:Longint; var TotalAxisNum:Longint ):Longint;stdcall;
function APS_set_security_key( Board_ID:Longint; OldPassword:Longint; NewPassword:Longint):Longint;stdcall;
function APS_check_security_key( Board_ID:Longint; Password:Longint ):Longint;stdcall;
function APS_reset_security_key( Board_ID:Longint ):Longint;stdcall;
function APS_load_param_from_file( var pXMLFile:String):Longint;stdcall;

//Only support PCI-7856/MoionNet series
function APS_save_param_to_file(  Board_ID:Longint; var pXMLFile:String ):Longint;stdcall;

//Control driver mode [Only for PCI-8254/8]
function APS_get_eep_curr_drv_ctrl_mode( Board_ID:Longint; var ModeInBit:Longint ):Longint;stdcall;

//Virtual board settings  [Only for PCI-8254/8]
function  APS_register_virtual_board( VirCardIndex:Longint;      Count:Longint ):Longint;stdcall;
function  APS_get_virtual_board_info( VirCardIndex:Longint;  var Count:Longint ):Longint;stdcall;

//Parameters setting by float [Only for PCI-8254/8]
function  APS_set_axis_param_f(  Axis_ID:Longint;  AXS_Param_No:Longint;     AXS_Param:Double ):Longint;stdcall;
function  APS_get_axis_param_f(  Axis_ID:Longint;  AXS_Param_No:Longint; var AXS_Param:Double ):Longint;stdcall;

// Flash function [Only for PCI-8253/56; PCI-8392(H)]
function APS_save_parameter_to_flash( Board_ID:Longint ):Longint;stdcall;
function APS_load_parameter_from_flash( Board_ID:Longint ):Longint;stdcall;
function APS_load_parameter_from_default( Board_ID:Longint ):Longint;stdcall;

// SSCNET-3 functions [Only for PCI-8392(H)]
function APS_start_sscnet( Board_ID:Longint;   var AxisFound_InBits:Longint ):Longint;stdcall;
function APS_stop_sscnet( Board_ID:Longint ):Longint;stdcall;
function APS_get_sscnet_servo_param( Axis_ID:Longint;   Para_No1:Longint;   var Para_Dat1:Longint;   Para_No2:Longint;   var Para_Dat2:Longint ):Longint;stdcall;
function APS_set_sscnet_servo_param( Axis_ID:Longint;   Para_No1:Longint;   Para_Dat1:Longint;   Para_No2:Longint;   Para_Dat2:Longint ):Longint;stdcall;
function APS_get_sscnet_servo_alarm( Axis_ID:Longint;   var Alarm_No:Longint;   var Alarm_Detail:Longint ):Longint;stdcall;
function APS_reset_sscnet_servo_alarm( Axis_ID:Longint ):Longint;stdcall;
function APS_save_sscnet_servo_param( Board_ID:Longint ):Longint;stdcall;
function APS_get_sscnet_servo_abs_position( Axis_ID:Longint;   var Cyc_Cnt:Longint;   var Res_Cnt:Longint ):Longint;stdcall;
function APS_save_sscnet_servo_abs_position( Board_ID:Longint ):Longint;stdcall;
function APS_load_sscnet_servo_abs_position( Axis_ID:Longint;   Abs_Option:Longint;   var Cyc_Cnt:Longint;   var Res_Cnt:Longint ):Longint;stdcall;
function APS_get_sscnet_link_status( Board_ID:Longint;   var Link_Status:Longint):Longint;stdcall;
function APS_set_sscnet_servo_monitor_src( Axis_ID:Longint; Mon_No:Longint; Mon_Src:Longint ):Longint;stdcall;
function APS_get_sscnet_servo_monitor_src( Axis_ID:Longint; Mon_No:Longint; var Mon_Src:Longint ):Longint;stdcall;
function APS_get_sscnet_servo_monitor_data( Axis_ID:Longint; Arr_Size:Longint; var Data_Arr:Longint ):Longint;stdcall;
function APS_set_sscnet_control_mode( Axis_ID:Longint; Mode:Longint; ):Longint;stdcall;

//Point table + IO - Pause / Resume
function APS_set_table_move_ex_pause(  Axis_ID:Longint ):Longint;stdcall;
function APS_set_table_move_ex_rollback(  Axis_ID:Longint;  Max_Speed:Longint ):Longint;stdcall;
function APS_set_table_move_ex_resume(  Axis_ID:Longint ):Longint;stdcall;


// Sampling functions extension[Only for PCI-82548 for up to 8 channel]
function APS_set_sampling_param_ex(  Board_ID:Longint; var Param:SAMP_PARAM ):Longint;stdcall;
function APS_get_sampling_param_ex(  Board_ID:Longint; var Param:SAMP_PARAM ):Longint;stdcall;
function APS_wait_trigger_sampling_ex(  Board_ID:Longint;  Length:Longint;  PreTrgLen:Longint;  TimeOutMs:Longint; var DataArr:STR_SAMP_DATA_8CH ):Longint;stdcall;
function APS_wait_trigger_sampling_async_ex(  Board_ID:Longint;  Length:Longint;  PreTrgLen:Longint;  TimeOutMs:Longint; var DataArr:STR_SAMP_DATA_8CH ):Longint;stdcall;
function APS_get_sampling_data_ex(  Board_ID:Longint;  var Length:Longint; var DataArr:STR_SAMP_DATA_8CH;  var Status:Longint ):Longint;stdcall;

// Monitor functions by float [Only for PCI-8254/8]
function APS_get_command_f(  Axis_ID:Longint; var Command:Double ):Longint;stdcall;
function APS_set_command_f(  Axis_ID:Longint; var Command:Double ):Longint;stdcall;
function APS_get_position_f(  Axis_ID:Longint;  var Position:Double ):Longint;stdcall;
function APS_set_position_f( Axis_ID:Longint; var Position:Double):Longint;stdcall;
function APS_get_command_velocity_f( Axis_ID:Longint; var Velocity:Double ):Longint;stdcall;
function APS_get_target_position_f(  Axis_ID:Longint; var Targ_Pos:Double ):Longint;stdcall;
function APS_get_error_position_f(  Axis_ID:Longint; var Err_Pos:Double ):Longint;stdcall;
function APS_get_feedback_velocity_f( Axis_ID:Longint; var Velocity:Double ):Longint;stdcall;

//Motion queue status [Only for PCI-8254/8]
function APS_get_mq_free_space(  Axis_ID:Longint; var Space:Longint ):Longint;stdcall;
function APS_get_mq_usage(  Axis_ID:Longint; var Usage:Longint ):Longint;stdcall;

// Motion IO & motion status
function APS_get_command( Axis_ID:Longint;   var Command:Longint ):Longint;stdcall;
function APS_set_command(Axis_ID:Longint;   Command:Longint):Longint;stdcall;
function APS_motion_status( Axis_ID:Longint ):Longint;stdcall;
function APS_motion_io_status( Axis_ID:Longint ):Longint;stdcall;
function APS_set_servo_on( Axis_ID:Longint;   Servo_On:Longint ):Longint;stdcall;
function APS_get_position( Axis_ID:Longint;   var Position:Longint ):Longint;stdcall;
function APS_set_position(Axis_ID:Longint;   Position:Longint):Longint;stdcall;
function APS_get_command_velocity(Axis_ID:Longint;   var Velocity:Longint ):Longint;stdcall;
function APS_get_feedback_velocity(Axis_ID:Longint;   var Velocity:Longint ):Longint;stdcall;
function APS_get_error_position( Axis_ID:Longint;   var Err_Pos:Longint ):Longint;stdcall;
function APS_get_target_position( Axis_ID:Longint;   var Targ_Pos:Longint ):Longint;stdcall;

// Single axis motion
function APS_relative_move( Axis_ID:Longint;   Distance:Longint;   Max_Speed:Longint ):Longint;stdcall;
function APS_absolute_move( Axis_ID:Longint;   Position:Longint;   Max_Speed:Longint ):Longint;stdcall;
function APS_velocity_move( Axis_ID:Longint;   Max_Speed:Longint ):Longint;stdcall;
function APS_home_move( Axis_ID:Longint ):Longint;stdcall;
function APS_stop_move( Axis_ID:Longint ):Longint;stdcall;
function APS_emg_stop( Axis_ID:Longint ):Longint;stdcall;
function APS_relative_move2( Axis_ID:Longint;   Distance:Longint;   Start_Speed:Longint;   Max_Speed:Longint;   End_Speed:Longint;   Acc_Rate:Longint;   Dec_Rate:Longint ):Longint;stdcall;
function APS_absolute_move2( Axis_ID:Longint;   Position:Longint;   Start_Speed:Longint;   Max_Speed:Longint;   End_Speed:Longint;   Acc_Rate:Longint;   Dec_Rate:Longint ):Longint;stdcall;
function APS_home_move2( Axis_ID:Longint;   Dir:Longint;   Acc:Longint;   Start_Speed:Longint;   Max_Speed:Longint;   ORG_Speed:Longint ):Longint;stdcall;
function APS_home_escape(  Axis_ID:Longint; ):Longint;stdcall;

//Override functions [Only for MNET-1XMO/MNET-4XMO/MNET-4XMO-C]
function APS_speed_override( Axis_ID:Longint; MaxSpeed:Longint ):Longint;stdcall;
function APS_relative_move_ovrd( Axis_ID:Longint; Distance:Longint; MaxSpeed:Longint ):Longint;stdcall;
function APS_absolute_move_ovrd( Axis_ID:Longint; Position:Longint; MaxSpeed:Longint ):Longint;stdcall;
function APS_get_field_bus_a_input_plc(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  Ch_No:Longint;  var AI_Value:Double;  RunStep:Longint ):Longint;stdcall;

//Point table Feeder (Only for PCI-8254/8)
function APS_pt_dwell(  Board_ID:Longint;  PtbId:Longint;  var Prof:PTDWL; var Status:PTSTS ):Longint;stdcall;
function APS_pt_line(  Board_ID:Longint;  PtbId:Longint;  var Prof:PTLINE; var Status:PTSTS ):Longint;stdcall;
function APS_pt_arc2_ca(  Board_ID:Longint;  PtbId:Longint; var Prof:PTA2CA; var Status:PTSTS ):Longint;stdcall;
function APS_pt_arc2_ce(  Board_ID:Longint;  PtbId:Longint; var Prof:PTA2CE; var Status:PTSTS ):Longint;stdcall;
function APS_pt_arc3_ca(  Board_ID:Longint;  PtbId:Longint; var Prof:PTA3CA; var Status:PTSTS ):Longint;stdcall;
function APS_pt_arc3_ce(  Board_ID:Longint;  PtbId:Longint; var Prof:PTA3CE; var Status:PTSTS ):Longint;stdcall;
function APS_pt_spiral_ca(  Board_I:Longint;  PtbId:Longint; var Prof:PTHCA; var Status:PTSTS ):Longint;stdcall;
function APS_pt_spiral_ce(  Board_ID:Longint;  PtbId:Longint; var Prof:PTHCE; var Status:PTSTS ):Longint;stdcall;

//New Interface
function APS_ptp(  Axis_ID:Longint;  Option:Longint:  Position:Double; var Wait:ASYNCALL);
function APS_ptp_v(  Axis_ID:Longint;  Option:Longint;  Position:Double;  Vm:Double; var Wait:ASYNCALL);
function APS_ptp_all(  Axis_ID:Longint;  Option:Longint;  Position:Double;  Vs:Double;	 Vm:Double; 	Ve:Double;  Acc:Double;	 Dec:Double;  SFac:Double; var Wait:ASYNCALL);
function APS_vel(  Axis_ID:Longint;  Option:Longint;  Vm:Double; var Wait:ASYNCALL);
function APS_vel_all(  Axis_ID:Longint;  Option:Longint;  Vs:Double;  Vm:Double;  Ve:Double;  Acc:Double;	 Dec:Double;  SFac:Double; var Wait:ASYNCALL);
function APS_line(  Dimension:Longint;  var Axis_ID_Array:Longint;  Option:Longint;  var PositionArray:Double;  var TransPara:Double; var Wait:ASYNCALL);
function APS_line_v(  Dimension:Longint;  var Axis_ID_Array:Longint;  Option:Longint;  var PositionArray:Double;  var TransPara:Double;  Vm:Double; var Wait:ASYNCALL);
function APS_line_all(  Dimension:Longint;  var Axis_ID_Array:Longint;  Option:Longint;  var PositionArray:Double;  var TransPara:Double;  Vs:Double;  Vm:Double;  Ve:Double;  Acc:Double; Dec:Double;  SFac:Double; var Wait:ASYNCALL);
function APS_arc2_ca(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  Angle:Double;  var TransPara:Double; var Wait:ASYNCALL );
function APS_arc2_ca_v(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  Angle:Double;  var TransPara:Double;  Vm:Double; var Wait:ASYNCALL );
function APS_arc2_ca_all(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  Angle:Double;  var TransPara:Double;  Vs:Double;  Vm:Double;  Ve:Double;  Acc:Double;  Dec:Double;  SFac:Double; var Wait:ASYNCALL );
function APS_arc2_ce(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var EndArray:Double;  Dir:Double;  var TransPara:Double; var Wait:ASYNCALL );
function APS_arc2_ce_v(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var EndArray:Double;  Dir:Double;  var TransPara:Double;  Vm:Double; var Wait:ASYNCALL );
function APS_arc2_ce_all(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var EndArray:Double;  Dir:Double;  var TransPara:Double;  Vs:Double;  Vm:Double;  Ve:Double;  Acc:Double;  Dec:Double;  SFac:Double; var Wait:ASYNCALL );
function APS_arc3_ca(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var NormalArray:Double;  Angle:Double;  var TransPara:Double; var Wait:ASYNCALL );
function APS_arc3_ca_v(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var NormalArray:Double;  Angle:Double;  var TransPara:Double;  Vm:Double; var Wait:ASYNCALL );
function APS_arc3_ca_all(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var NormalArray:Double;  Angle:Double;  var TransPara:Double;  Vs:Double;  Vm:Double;  Ve:Double;  Acc:Double;  Dec:Double;  SFac:Double; var Wait:ASYNCALL );
function APS_arc3_ce(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var EndArray:Double;  Dir:Double;  var TransPara:Double; var Wait:ASYNCALL );
function APS_arc3_ce_v(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var EndArray:Double;  Dir:Double; var TransPara:Double;  Vm:Double; var Wait:ASYNCALL );
function APS_arc3_ce_all(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var EndArray:Double;  Dir:Double;  var TransPara:Double;  Vs:Double;  Vm:Double;  Ve:Double;  Acc:Double;  Dec:Double;  SFac:Double; var Wait:ASYNCALL );
function APS_spiral_ca(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var NormalArray:Double;  Angle:Double;  DeltaH:Double;  FinalR:Double;  var TransPara:Double; var Wait:ASYNCALL );
function APS_spiral_ca_v(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var NormalArray:Double;  Angle:Double;  DeltaH:Double;  FinalR:Double;  var TransPara:Double;  Vm:Double; var Wait:ASYNCALL );
function APS_spiral_ca_all(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var NormalArray:Double;  Angle:Double;  DeltaH:Double;  FinalR:Double;  var TransPara:Double;  Vs:Double;  Vm:Double;  Ve:Double;  Acc:Double;  Dec:Double;  SFac:Double; var Wait:ASYNCALL );
function APS_spiral_ce(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var NormalArray:Double;  var EndArray:Double;  Dir:Double;  var TransPara:Double; var Wait:ASYNCALL );
function APS_spiral_ce_v(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var NormalArray:Double;  var EndArray:Double;  Dir:Double;  var TransPara:Double;  Vm:Double; var Wait:ASYNCALL );
function APS_spiral_ce_all(  var Axis_ID_Array:Longint;  Option:Longint;  var CenterArray:Double;  var NormalArray:Double;  var EndArray:Double;  Dir:Double;  var TransPara:Double;  Vs:Double;  Vm:Double;  Ve:Double;  Acc:Double;  Dec:Double;  SFac:Double; var Wait:ASYNCALL );

//Simultaneous move [Only for MNET series]
function APS_set_relative_simultaneous_move( Dimension:Longint; var Axis_ID_Array:Longint; var Distance_Array:Longint; var Max_Speed_Array:Longint ):Longint;stdcall;
function APS_set_absolute_simultaneous_move( Dimension:Longint; var Axis_ID_Array:Longint; var Position_Array:Longint; var Max_Speed_Array:Longint ):Longint;stdcall;
function APS_start_simultaneous_move( Axis_ID:Longint):Longint;stdcall;
function APS_stop_simultaneous_move( Axis_ID:Longint):Longint;stdcall;
function APS_emg_stop_simultaneous_move( Axis_ID:Longint ):Longint;stdcall;


function APS_set_velocity_simultaneous_move  ( Dimension:Longint; var Axis_ID_Array:Longint; var Max_Speed_Array:Longint ):Longint;stdcall;
function APS_Release_simultaneous_move       ( Axis_ID:Longint ):Longint;stdcall;

//Raw command counter [Only for PCI-8254/8]
function APS_get_command_counter(  Axis_ID:Longint; var Counter:Longint );

//JOG functions [Only for PCI-8392; PCI-8253/56]
function APS_set_jog_param( Axis_ID:Longint; var pStr_Jog:JOG_DATA;   Mask:Longint ):Longint;stdcall;
function APS_get_jog_param( Axis_ID:Longint; var pStr_Jog:JOG_DATA ):Longint;stdcall;
function APS_jog_mode_switch( Axis_ID:Longint;   Turn_No:Longint ):Longint;stdcall;
function APS_jog_start( Axis_ID:Longint;   STA_On:Longint ):Longint;stdcall;

// Interpolation
function APS_absolute_linear_move(   Dimension:Longint;   var Axis_ID_Array:Longint;   var Position_Array:Longint;   Max_Linear_Speed:Longint ):Longint;stdcall;
function APS_relative_linear_move(   Dimension:Longint;   var Axis_ID_Array:Longint;   var Distance_Array:Longint;   Max_Linear_Speed:Longint ):Longint;stdcall;
function APS_absolute_arc_move(   Dimension:Longint;   var Axis_ID_Array:Longint;   var Center_Pos_Array:Longint;   Max_Arc_Speed:Longint;   Angle:Longint ):Longint;stdcall;
function APS_relative_arc_move(   Dimension:Longint;   var Axis_ID_Array:Longint;   var Center_Offset_Array:Longint;   Max_Arc_Speed:Longint;   Angle:Longint ):Longint;stdcall;


function APS_set_field_bus_int_factor_di(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;   bitsOfCheck:Longint ):Longint;stdcall;
function APS_get_field_bus_int_factor_di(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  var bitsOfCheck:Longint ):Longint;stdcall;

// Helical interpolation [Only for PCI-8392; PCI-8253/56]
function APS_absolute_helix_move( Dimension :Longint; var Axis_ID_Array:Longint; var Center_Pos_Array:Longint; Max_Arc_Speed:Longint; Pitch:Longint; TotalHeight:Longint; CwOrCcw:Longint ):Longint;stdcall;
function APS_relative_helix_move( Dimension :Longint; var Axis_ID_Array:Longint; var Center_PosOffset_Array:Longint; Max_Arc_Speed:Longint; Pitch:Longint; TotalHeight:Longint; CwOrCcw:Longint):Longint;stdcall;

// Circular interpolation( Support 2D and 3D ) [Only for PCI-8392; PCI-8253/56]
function APS_absolute_arc_move_3pe(Dimension:Longint; var Axis_ID_Array:Longint; var Pass_Pos_Array:Longint; var End_Pos_Array:Longint; Max_Arc_Speed :Longint):Longint;stdcall;
function APS_relative_arc_move_3pe(Dimension:Longint; var Axis_ID_Array:Longint; var Pass_PosOffset_Array:Longint; var End_PosOffset_Array:Longint; Max_Arc_Speed :Longint):Longint;stdcall;

// Interrupt functions
function APS_int_enable( Board_ID:Longint;   Enable:Longint ):Longint;stdcall;
function APS_set_int_factor( Board_ID:Longint;   Item_No:Longint;   Factor_No:Longint;   Enable:Longint ):Longint;stdcall;
function APS_get_int_factor( Board_ID:Longint;   Item_No:Longint;   Factor_No:Longint;   var Enable:Longint ):Longint;stdcall;
//HANDLE FNTYPE APS_set_int_factorH( Board_ID:Longint;   Item_No:Longint;   Factor_No:Longint;   Enable:Longint ):Longint;stdcall;

function APS_wait_single_int(   Int_No:Longint;   Time_Out:Longint ):Longint;stdcall;
function APS_wait_multiple_int(   Int_Count:Longint;   var Int_No_Array:Longint;   Wait_All:Longint;   Time_Out:Longint ):Longint;stdcall;
function APS_reset_int(   Int_No:Longint ):Longint;stdcall;
function APS_set_int(   Int_No:Longint ):Longint;stdcall;
	//[Only for PCI-8154/58]
function APS_wait_error_int( Board_ID:Longint;   Item_No:Longint;   Time_Out:Longint ):Longint;stdcall;

// Sampling functions [Only for PCI-8392; PCI-8253/56]
function APS_set_sampling_param( Board_ID:Longint;   ParaNum:Longint;   ParaDat:Longint ):Longint;stdcall;
function APS_get_sampling_param( Board_ID:Longint;   ParaNum:Longint;   var ParaDat:Longint ):Longint;stdcall;
function APS_wait_trigger_sampling( Board_ID:Longint;   Length:Longint;   PreTrgLen:Longint;   TimeOutMs:Longint;  var DataArr:STR_SAMP_DATA_4CH ):Longint;stdcall;
function APS_wait_trigger_sampling_async( Board_ID:Longint;   Length:Longint;   PreTrgLen:Longint;   TimeOutMs:Longint;   var  DataArr:STR_SAMP_DATA_4CH ):Longint;stdcall;
function APS_get_sampling_count( Board_ID:Longint;   var SampCnt:Longint ):Longint;stdcall;
function APS_stop_wait_sampling( Board_ID:Longint ):Longint;stdcall;

function APS_auto_sampling(  Board_ID:Longint;  StartStop:Longint ):Longint;stdcall;
function APS_get_sampling_data(  Board_ID:Longint;  var Length:Longint; var DataArr:STR_SAMP_DATA_4CH;  var Status:Longint ):Longint;stdcall;

function APS_set_backlash_en( Axis_ID:Longint;  Enable:Longint ):Longint;stdcall;
function APS_get_backlash_en(  Axis_ID:Longint;  var Enable:Longint ):Longint;stdcall;

//DIO & AIO
function APS_write_d_output(Board_ID:Longint;   DO_Group:Longint;   DO_Data:Longint):Longint;stdcall;
function APS_read_d_output(Board_ID:Longint;   DO_Group:Longint;   var DO_Data:Longint):Longint;stdcall;
function APS_read_d_input(Board_ID:Longint;   DI_Group:Longint;   var DI_Data:Longint):Longint;stdcall;

function APS_read_a_input_value(Board_ID:Longint;   Channel_No:Longint;   var Convert_Data:Double):Longint;stdcall;
function APS_read_a_input_data(Board_ID:Longint;   Channel_No:Longint;   var Raw_Data:Longint):Longint;stdcall;
function APS_write_a_output_value(Board_ID:Longint;   Channel_No:Longint;   Convert_Data:Double):Longint;stdcall;
function APS_write_a_output_data(Board_ID:Longint;   Channel_No:Longint;   Raw_Data:Longint):Longint;stdcall;

//Point table move
function APS_set_point_table( Axis_ID:Longint;   Index:Longint;  var Point:POINT_DATA ):Longint;stdcall;
function APS_get_point_table( Axis_ID:Longint;   Index:Longint;  var Point:POINT_DATA ):Longint;stdcall;
function APS_get_running_point_index( Axis_ID:Longint;   var Index:Longint ):Longint;stdcall;
function APS_get_start_point_index( Axis_ID:Longint;   var Index:Longint ):Longint;stdcall;
function APS_get_end_point_index( Axis_ID:Longint;   var Index:Longint ):Longint;stdcall;
function APS_set_table_move_pause( Axis_ID:Longint;   Pause_en:Longint ):Longint;stdcall;
function APS_set_table_move_repeat( Axis_ID:Longint;   Repeat_en:Longint ):Longint;stdcall;
function APS_point_table_move(   Dimension:Longint;   var Axis_ID_Array:Longint;   StartIndex:Longint;   EndIndex:Longint ):Longint;stdcall;


//For Single latch for PCI8154/58/MNET-4XMO-(C)
function APS_manual_latch2( I32 Axis_ID:Longint ):Longint;stdcall;
function APS_get_latch_data2(  Axis_ID:Longint;  LatchNum:Longint;  var LatchData:Longint ):Longint;stdcall;

//Point table move2
function APS_set_point_table_mode2( Axis_ID:Longint; Mode:Longint ):Longint;stdcall;
function APS_set_point_table2( Dimension:Longint; var Axis_ID_Array:Longint; Index:Longint; var Point:POINT_DATA2  ):Longint;stdcall;
function APS_point_table_continuous_move2( Dimension:Longint; var Axis_ID_Array:Longint ):Longint;stdcall;
function APS_point_table_single_move2( Axis_ID:Longint; Index:Longint ):Longint;stdcall;
function APS_get_running_point_index2( Axis_ID:Longint; var Index:Longint ):Longint;stdcall;
function APS_point_table_status2( Axis_ID:Longint; var Status:Longint ):Longint;stdcall;

//Latch functins
function APS_get_encoder(  Axis_ID:Longint;  var Encoder:Longint ):Longint;stdcall;
function APS_get_latch_counter(  Axis_ID:Longint;  Src:Longint;  var Counter:Longint ):Longint;stdcall;
function APS_get_latch_event(  Axis_ID:Longint;  Src:Longint;  varEvent:Longint ):Longint;stdcall;

//Gear/Gantry function
function APS_start_gear(  Axis_ID:Longint;  Mode:Longint ):Longint;stdcall;
function APS_get_gear_status(  Axis_ID:Longint; var Status:Longint ):Longint;stdcall;

//Point table Only for HSL-4XMO
function APS_set_point_table3( Dimension:Longint; var Axis_ID_Array:Longint; Index:Longint; var Point:POINT_DATA3  ):Longint;stdcall;
function APS_point_table_move3( Dimension:Longint; var Axis_ID_Array:Longint; StartIndex:Longint; EndIndex:Longint ):Longint;stdcall;
function APS_set_point_table_param3( FirstAxid:Longint; ParaNum:Longint; ParaDat:Longint ):Longint;stdcall;

// Gantry functions. [Only for PCI-8392; PCI-8253/56]
function APS_set_gantry_param( Board_ID:Longint;   GroupNum:Longint;   ParaNum:Longint;   ParaDat:Longint ):Longint;stdcall;
function APS_get_gantry_param( Board_ID:Longint;   GroupNum:Longint;   ParaNum:Longint;   var ParaDat:Longint ):Longint;stdcall;
function APS_set_gantry_axis( Board_ID:Longint;   GroupNum:Longint;   Master_Axis_ID:Longint;   Slave_Axis_ID:Longint ):Longint;stdcall;
function APS_get_gantry_axis( Board_ID:Longint;   GroupNum:Longint;   var Master_Axis_ID:Longint;   var Slave_Axis_ID:Longint ):Longint;stdcall;
function APS_get_gantry_error( Board_ID:Longint;   GroupNum:Longint;   var GentryError:Longint ):Longint;stdcall;

// Digital filter functions. [Only for PCI-8253/56]
function APS_set_filter_param( Axis_ID:Longint; Filter_paramNo:Longint; param_val:Longint ):Longint;stdcall;
function APS_get_filter_param( Axis_ID:Longint; Filter_paramNo:Longint; var param_val:Longint ):Longint;stdcall;
function APS_manual_set_filter( Axis_ID:Longint; Coefficient:FILTER_COEF  ):Longint;stdcall;
function APS_get_filter_coef( Axis_ID:Longint; var Coefficient:FILTER_COEF ):Longint;stdcall;

//Field bus master fucntions For PCI-8392(H)
function APS_set_field_bus_param( Board_ID:Longint; BUS_No:Longint; BUS_Param_No:Longint;    BUS_Param:Longint ):Longint;stdcall;
function APS_get_field_bus_param( Board_ID:Longint; BUS_No:Longint; BUS_Param_No:Longint;   var BUS_Param:Longint ):Longint;stdcall;
function APS_start_field_bus( Board_ID:Longint; BUS_No:Longint;   Start_Axis_ID:Longint ):Longint;stdcall;
function APS_stop_field_bus( Board_ID:Longint; BUS_No:Longint ):Longint;stdcall;

//New AIO [Only for PCI-82548]
function APS_read_a_output_value( Board_ID:Longint;  Channel_No:Longint;  var Convert_Data:Double):Longint;stdcall;


//Profile buffer setting
function APS_pt_set_absolute(  Board_ID:Longint;  PtbId:Longint ):Longint;stdcall;
function APS_pt_set_relative(  Board_ID:Longint;  PtbId:Longint ):Longint;stdcall;
function APS_pt_set_trans_buffered(  Board_ID:Longint;  PtbId:Longint ):Longint;stdcall;
function APS_pt_set_trans_inp(  Board_ID:Longint;  PtbId:Longint ):Longint;stdcall;
function APS_pt_set_trans_blend_dec(  Board_ID:Longint;  PtbId:Longint;  Bp:Double ):Longint;stdcall;
function APS_pt_set_trans_blend_dist(  Board_ID:Longint;  PtbId:Longint;  Bp:Double ):Longint;stdcall;
function APS_pt_set_trans_blend_pcnt(  Board_ID:Longint;  PtbId:Longint;  Bp:Double ):Longint;stdcall;
function APS_pt_set_acc(  Board_ID:Longint;  PtbId:Longint;  Acc:Double ):Longint;stdcall;
function APS_pt_set_dec(  Board_ID:Longint;  PtbId:Longint;  Dec:Double ):Longint;stdcall;
function APS_pt_set_acc_dec(  Board_ID:Longint;  PtbId:Longint;  AccDec:Double ):Longint;stdcall;
function APS_pt_set_s(  Board_ID:Longint;  PtbId:Longint;  Sf:Double ):Longint;stdcall;
function APS_pt_set_vm(  Board_ID:Longint;  PtbId:Longint;  Vm:Double ):Longint;stdcall;
function APS_pt_set_ve(  Board_ID:Longint;  PtbId:Longint;  Ve:Double ):Longint;stdcall;


function APS_get_field_bus_device_info( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint; Info_No:Longint; var Info:Longint ):Longint;stdcall;
function APS_get_field_bus_last_scan_info( Board_ID:Longint; BUS_No:Longint;   var Info_Array;   Array_Size:Longint;   var Info_Count:Longint ):Longint;stdcall;
function APS_get_field_bus_master_type( Board_ID:Longint; BUS_No:Longint;   var BUS_Type:Longint ):Longint;stdcall;
function APS_get_field_bus_slave_type( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   var MOD_Type:Longint ):Longint;stdcall;
function APS_get_field_bus_slave_name( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   var MOD_Name:Longint ):Longint;stdcall;
function APS_get_field_bus_slave_first_axisno( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   var AxisID:Longint ):Longint;stdcall;

//Field bus slave general functions
function APS_set_field_bus_slave_param( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   Ch_No:Longint;   ParaNum:Longint;   ParaDat:Longint  ):Longint;stdcall;
function APS_get_field_bus_slave_param( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   Ch_No:Longint;   ParaNum:Longint;   var ParaDat:Longint ):Longint;stdcall;
function APS_get_slave_connect_quality( Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint; var Sts_data:Longint ):Longint;stdcall;
function APS_get_slave_online_status(  Board_ID:Longint;  BUS_No:Longint; MOD_No:Longint; var Live:Longint ):Longint;stdcall;

//Multi-axes simultaneuos move start/stop
function APS_move_trigger(  Dimension:Longint;  var Axis_ID_Array:Longint ):Longint;stdcall;
function APS_stop_move_multi(  Dimension:Longint;  var Axis_ID_Array:Longint ):Longint;stdcall;
function APS_emg_stop_multi(  Dimension:Longint;  var Axis_ID_Array:Longint ):Longint;stdcall;

//Field bus DIO slave fucntions For PCI-8392(H)
function APS_set_field_bus_d_output( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   DO_Value:Longint ):Longint;stdcall;
function APS_get_field_bus_d_output( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   var DO_Value:Longint ):Longint;stdcall;
function APS_get_field_bus_d_input( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   var DI_Value:Longint ):Longint;stdcall;

function APS_set_field_bus_d_channel_output( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint; Ch_No:Longint  ;DO_Value:Longint ):Longint;stdcall;
function APS_get_field_bus_d_channel_output( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint; Ch_No:Longint  ;var DO_Value:Longint ):Longint;stdcall;
function APS_get_field_bus_d_channel_input( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;  Ch_No:Longint  ;var DI_Value:Longint ):Longint;stdcall;

//Field bus AIO slave function
function APS_set_field_bus_a_output( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   Ch_No:Longint;    AO_Value:Double ):Longint;stdcall;
function APS_get_field_bus_a_output( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   Ch_No:Longint;   var AO_Value:Double ):Longint;stdcall;
function APS_get_field_bus_a_input( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   Ch_No:Longint;   var AI_Value:Double ):Longint;stdcall;

//Field bus Comparing trigger functions
function APS_set_field_bus_trigger_param(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  Param_No:Longint;  Param_Val:Longint ):Longint;stdcall;
function APS_get_field_bus_trigger_param(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  Param_No:Longint; var Param_Val:Longint ):Longint;stdcall;
function APS_set_field_bus_trigger_linear(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  LCmpCh:Longint;  StartPoint:Longint;  RepeatTimes:Longint;  Interval:Longint ):Longint;stdcall;
function APS_set_field_bus_trigger_table(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  TCmpCh:Longint; var DataArr:Longint;  ArraySize:Longint ):Longint;stdcall; 
function APS_set_field_bus_trigger_manual(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  TrgCh:Longint ):Longint;stdcall;
function APS_set_field_bus_trigger_manual_s(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  TrgChInBit:Longint ):Longint;stdcall;
function APS_get_field_bus_trigger_table_cmp(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  TCmpCh:Longint; var CmpVal:Longint ):Longint;stdcall;
function APS_get_field_bus_trigger_linear_cmp(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  LCmpCh:Longint; var CmpVal:Longint ):Longint;stdcall;
function APS_get_field_bus_trigger_count(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  TrgCh:Longint; var TrgCnt:Longint ):Longint;stdcall;
function APS_reset_field_bus_trigger_count(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  TrgCh:Longint ):Longint;stdcall;
function APS_get_field_bus_linear_cmp_remain_count(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  LCmpCh:Longint; var Cnt:Longint ):Longint;stdcall;
function APS_get_field_bus_table_cmp_remain_count(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  TCmpCh:Longint; var Cn:Longint ):Longint;stdcall;
function APS_get_field_bus_encoder(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  EncCh:Longint; var EncCnt:Longint ):Longint;stdcall;
function APS_set_field_bus_encoder(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  EncCh:Longint;  EncCnt:Longint ):Longint;stdcall;

//Latch Function: for latching multi-points
function APS_set_ltc_counter(  Board_ID:Longint;  CntNum:Longint;  CntValue:Longint ):Longint;stdcall;
function APS_get_ltc_counter(  Board_ID:Longint;  CntNum:Longint;  var CntValue:Longint ):Longint;stdcall;
function APS_set_ltc_fifo_param(  Board_ID:Longint;  FLtcCh:Longint;  Param_No:Longint;  Param_Val:Longint ):Longint;stdcall;
function APS_get_ltc_fifo_param(  Board_ID:Longint;  FLtcCh:Longint;  Param_No:Longint;  var Param_Val:Longint ):Longint;stdcall;
function APS_manual_latch(  Board_ID:Longint;  LatchSignalInBits:Longint ):Longint;stdcall;
function APS_enable_ltc_fifo(  Board_ID:Longint;  FLtcCh:Longint;  Enable:Longint ):Longint;stdcall;
function APS_reset_ltc_fifo(  Board_ID:Longint;  FLtcCh:Longint ):Longint;stdcall;
function APS_get_ltc_fifo_data(  Board_ID:Longint;  FLtcCh:Longint;  var Data:Longint ):Longint;stdcall;
function APS_get_ltc_fifo_usage(  Board_ID:Longint;  FLtcCh:Longint;  var Usage:Longint ):Longint;stdcall;
function APS_get_ltc_fifo_free_space(  Board_ID:Longint;  FLtcCh:Longint;  var FreeSpace:Longint ):Longint;stdcall;
function APS_get_ltc_fifo_status(  Board_ID:Longint;  FLtcCh:Longint;  var Status:Longint ):Longint;stdcall;

//Program download - APS
function APS_load_vmc_program(  Board_ID:Longint;  TaskNum:Longint; var pFile:String; Password:Longint):Longint;stdcall;
function APS_save_vmc_program(  Board_ID:Longint;  TaskNum:Longint; var pFile:String; Password:Longint):Longint;stdcall;
function APS_load_amc_program(  Board_ID:Longint;  TaskNum:Longint; var pFile:String; Password:Longint):Longint;stdcall;
function APS_save_amc_program(  Board_ID:Longint;  TaskNum:Longint; var pFile:String; Password:Longint):Longint;stdcall;
function APS_set_task_mode(  Board_ID:Longint;  TaskNum:Longint;  Mode:Longint;  LastIP:Longint ):Longint;stdcall;
function APS_get_task_mode(  Board_ID:Longint;  TaskNum:Longint;  var Mode:Longint;  var LastIP:Longint ):Longint;stdcall;
function APS_start_task(  Board_ID:Longint;  TaskNum:Longint;  CtrlCmd:Longint ):Longint;stdcall;
function APS_get_task_info(  Board_ID:Longint;  TaskNum:Longint; var Info:TSK_INFO ):Longint;stdcall;
function APS_get_task_msg(  Board_ID:Longint;  var QueueSts:Longint;  var ActualSize:Longint;  var CharArr:Longint ):Longint;stdcall;

// Comparing trigger functions
function APS_set_trigger_param( Board_ID:Longint;   Param_No:Longint;   Param_Val:Longint ):Longint;stdcall;
function APS_get_trigger_param( Board_ID:Longint;   Param_No:Longint;   var Param_Val:Longint ):Longint;stdcall;
function APS_set_trigger_linear( Board_ID:Longint;   LCmpCh:Longint;   StartPoint:Longint;   RepeatTimes:Longint;   Interval:Longint ):Longint;stdcall;
function APS_set_trigger_table( Board_ID:Longint;   TCmpCh:Longint;   var DataArr:Longint;   ArraySize:Longint ):Longint;stdcall; 
function APS_set_trigger_manual( Board_ID:Longint;   TrgCh:Longint ):Longint;stdcall;
function APS_set_trigger_manual_s( Board_ID:Longint;   TrgChInBit:Longint ):Longint;stdcall;
function APS_get_trigger_table_cmp( Board_ID:Longint;   TCmpCh:Longint;   var CmpVal:Longint ):Longint;stdcall;
function APS_get_trigger_linear_cmp( Board_ID:Longint;   LCmpCh:Longint;   var CmpVal:Longint ):Longint;stdcall;
function APS_get_trigger_count( Board_ID:Longint;   TrgCh:Longint;   var TrgCnt:Longint ):Longint;stdcall;
function APS_reset_trigger_count( Board_ID:Longint;   TrgCh:Longint ):Longint;stdcall;

//enable & disable
function APS_pt_enable(  Board_ID:Longint;  PtbId:Longint;  Dimension:Longint;  var AxisArr:Longint ):Longint;stdcall;
function APS_pt_disable(  Board_ID:Longint;  PtbId:Longint ):Longint;stdcall;
function APS_get_pt_info(  Board_ID:Longint;  PtbId:Longint; var Info:PTINFO ):Longint;stdcall;
function APS_pt_set_vs(  Board_ID:Longint;  PtbId:Longint;  Vs:Double ):Longint;stdcall;
function APS_pt_get_vs(  Board_ID:Longint;  PtbId:Longint;  var Vs:Double ):Longint;stdcall;
function APS_pt_start(  Board_ID:Longint;  PtbId:Longint ):Longint;stdcall;
function APS_pt_stop(  Board_ID:Longint;  PtbId:Longint ):Longint;stdcall;
function APS_get_pt_status(  Board_ID:Longint;  PtbId:Longint; var Status:PTSTS ):Longint;stdcall;
function APS_reset_pt_buffer(  Board_ID:Longint;  PtbId:Longint ):Longint;stdcall;
function APS_pt_roll_back(  Board_ID:Longint;  PtbId:Longint;  Max_Speed:Double ):Longint;stdcall;
function APS_pt_get_error(  Board_ID:Longint;  PtbId:Longint;  var ErrCode:Longint ):Longint;stdcall;

function APS_enable_trigger_fifo_cmp(  Board_ID:Longint;  FCmpCh:Longint;  Enable:Longint ):Longint;stdcall;
function APS_get_trigger_fifo_cmp(  Board_ID:Longint;  FCmpCh:Longint;  var CmpVal:Longint ):Longint;stdcall;
function APS_get_trigger_fifo_status(  Board_ID:Longint;  FCmpCh:Longint;  var FifoSts:Longint ):Longint;stdcall;
function APS_set_trigger_fifo_data(  Board_ID:Longint;  FCmpCh:Longint;  var DataArr:Longint;  ArraySize:Longint;  ShiftFlag:Longint ):Longint;stdcall; 
function APS_set_trigger_encoder_counter(  Board_ID:Longint;  TrgCh:Longint;  TrgCnt:Longint ):Longint;stdcall;
function APS_get_trigger_encoder_counter(  Board_ID:Longint;  TrgCh:Longint;  var TrgCnt:Longint ):Longint;stdcall;
function APS_start_timer(  Board_ID:Longint;  TrgCh:Longint;  Start:Longint ):Longint;stdcall;
function APS_get_timer_counter(  Board_ID:Longint;  TmrCh:Longint;  var Cnt:Longint ):Longint;stdcall;
function APS_set_timer_counter(  Board_ID:Longint;  TmrCh:Longint;  Cnt:Longint ):Longint;stdcall;

// Pulser counter function
function APS_get_pulser_counter( Board_ID:Longint;   var Counter:Longint ):Longint;stdcall;
function APS_set_pulser_counter( Board_ID:Longint;   Counter:Longint ):Longint;stdcall;

// Reserved functions
function APS_field_bus_slave_set_param( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   Ch_No:Longint;   ParaNum:Longint;   ParaDat:Longint  ):Longint;stdcall;
function APS_field_bus_slave_get_param( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   Ch_No:Longint;   ParaNum:Longint;   var ParaDat:Longint ):Longint;stdcall;

function APS_field_bus_d_set_output( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   DO_Value:Longint ):Longint;stdcall;
function APS_field_bus_d_get_output( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   var DO_Value:Longint ):Longint;stdcall;
function APS_field_bus_d_get_input( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   var DI_Value:Longint ):Longint;stdcall;

function APS_field_bus_A_set_output( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   Ch_No:Longint;    AO_Value:Double ):Longint;stdcall;
function APS_field_bus_A_get_output( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   Ch_No:Longint;   var AO_Value:Double ):Longint;stdcall;
function APS_field_bus_A_get_input( Board_ID:Longint; BUS_No:Longint; MOD_No:Longint;   Ch_No:Longint;   var AI_Value:Double ):Longint;stdcall;
function APS_field_bus_A_get_input_plc(  Board_ID:Longint;  BUS_No:Longint;  MOD_No:Longint;  Ch_No:Longint;  var AI_Value:Double;  RunStep:Longint ):Longint;stdcall;

//Cmd buffer setting
function APS_pt_ext_set_do_ch(  Board_ID:Longint;  PtbId:Longint;  Channel:Longint;  OnOff:Longint );
function APS_pt_ext_set_table_no(  Board_ID:Longint;  PtbId:Longint;  CtrlNo:Longint;  TableNo:Longint );

//Dpac Function
function APS_rescan_CF( Board_ID:Longint ):Longint;stdcall;
function APS_get_battery_status( Board_ID:Longint;   var Battery_status:Longint):Longint;stdcall;

//DPAC Display & Display Button
function APS_get_display_data( Board_ID:Longint;   displayDigit:Longint;   var displayIndex:Longint):Longint;stdcall;
function APS_set_display_data( Board_ID:Longint;   displayDigit:Longint;   displayIndex:Longint):Longint;stdcall;
function APS_get_button_status( Board_ID:Longint;   var buttonstatus):Longint;stdcall;

//PWM function
function APS_set_pwm_width(  Board_ID:Longint;  PWM_Ch:Longint;  Width:Longint ):Longint;stdcall;
function APS_get_pwm_width(  Board_ID:Longint;  PWM_Ch:Longint;  var Width:Longint ):Longint;stdcall;
function APS_set_pwm_frequency(  Board_ID:Longint;  PWM_Ch:Longint;  Frequency:Longint ):Longint;stdcall;
function APS_get_pwm_frequency(  Board_ID:Longint;  PWM_Ch:Longint;  var Frequency:Longint; ):Longint;stdcall;
function APS_set_pwm_on(  Board_ID:Longint;  PWM_Ch:Longint;  PWM_On:Longint ):Longint;stdcall;

//nv RAM funciton
function APS_set_nv_ram( Board_ID:Longint;   RamNo:Longint;   DataWidth:Longint;   Offset:Longint;   Data:Longint ):Longint;stdcall;
function APS_get_nv_ram( Board_ID:Longint;   RamNo:Longint;   DataWidth:Longint;   Offset:Longint;   var Data:Longint ):Longint;stdcall;
function APS_clear_nv_ram( Board_ID:Longint;   RamNo:Longint ):Longint;stdcall;

//Motion Stop Code [Only for PCI-8254/8]
function APS_get_stop_code(  Axis_ID:Longint; var Code:Longint; ):Longint;stdcall;

//[Only for PCI-7856 motion interrupt]
function APS_set_field_bus_int_factor_motion(  Axis_ID:Longint;  Factor_No:Longint;   Enable:Longint ):Longint;stdcall;
function APS_get_field_bus_int_factor_motion(  Axis_ID:Longint;  Factor_No:Longint;  var Enable:Longint ):Longint;stdcall;
function APS_set_field_bus_int_factor_error(  Axis_ID:Longint;  Factor_No:Longint;   Enable:Longint ):Longint;stdcall;
function APS_get_field_bus_int_factor_error(  Axis_ID:Longint;  Factor_No:Longint;  var Enable:Longint ):Longint;stdcall;
function APS_reset_field_bus_int_motion( Axis_ID:Longint ):Longint;stdcall;
function APS_wait_field_bus_error_int_motion(  Axis_ID:Longint;  Time_Out:Longint ):Longint;stdcall;

//PCI-82548 Only for channel I/O
function APS_write_d_channel_output( Board_ID:Longint;  DO_Group:Longint;  Ch_No:Longint;  DO_Data:Longint):Longint;stdcall;
function APS_read_d_channel_output( Board_ID:Longint;  DO_Group:Longint;  Ch_No:Longint;  var DO_Data:Longint):Longint;stdcall;

function APS_set_point_tableEx(  Axis_ID:Longint;  Index:Longint; var Point:PNT_DATA ):Longint;stdcall;
function APS_set_point_tableEx_2D(  Axis_ID:Longint;  Axis_ID_2:Longint;  Index:Longint; var Point:PNT_DATA_2D ):Longint;stdcall;
function APS_set_point_table_4DL( var Axis_ID_Array:Longint;  Index:Longint; var Point:PNT_DATA_4DL ):Longint;stdcall;

//VAO function(Laser function) [Only for PCI-8253/6]
function APS_set_vao_param(  Board_ID:Longint;  Param_No:Longint;  Param_Val:Longint ):Longint;stdcall;
function APS_get_vao_param(  Board_ID:Longint;  Param_No:Longint;  var Param_Val:Longint ):Longint;stdcall;
function APS_set_vao_table(  Board_ID:Longint;  Table_No:Longint;  MinVelocity:Longint;  VelInterval:Longint;  TotalPoints:Longint;  var MappingDataArray:Longint ):Longint;stdcall;
function APS_switch_vao_table(  Board_ID:Longint;  Table_No:Longint  ):Longint;stdcall;
function APS_start_vao(  Board_ID:Longint;  Output_Ch:Longint;  Enable:Longint ):Longint;stdcall;
function APS_get_vao_status(  Board_ID:Longint;  var Status:Longint ):Longint;stdcall;
function APS_check_vao_param(  Board_ID:Longint;  Table_No:Longint;  var Status:Longint ):Longint;stdcall;
function APS_set_vao_param_ex(  Board_ID:Longint;  Table_No:Longint; var VaoData:VAO_DATA ):Longint;stdcall;
function APS_get_vao_param_ex(  Board_ID:Longint;  Table_No:Longint; var VaoData:VAO_DATA ):Longint;stdcall;

//Watch dog timer
function APS_wdt_start(  Board_ID:Longint;  TimerNo:Longint;  TimeOut:Longint ):Longint;stdcall;
function APS_wdt_get_timeout_period(  Board_ID:Longint;  TimerNo:Longint;  var TimeOut:Longint ):Longint;stdcall;
function APS_wdt_reset_counter(  Board_ID:Longint;  TimerNo:Longint ):Longint;stdcall;
function APS_wdt_get_counter(  Board_ID:Longint;  TimerNo:Longint;  var Counter:Longint ):Longint;stdcall;
function APS_wdt_set_action_event(  Board_ID:Longint;  TimerNo:Longint;  EventByBit:Longint ):Longint;stdcall;
function APS_wdt_get_action_event(  Board_ID:Longint;  TimerNo:Longint;  var EventByBit:Longint ):Longint;stdcall;

//Only for PCI-8392 to replace APS_set_point_table & APS_get_point_table
function APS_set_point_table_ex(  Axis_ID:Longint;  Index:Longint; var Point:POINT_DATA_EX ):Longint;stdcall;
function APS_get_point_table_ex(  Axis_ID:Longint;  Index:Longint; var Point:POINT_DATA_EX ):Longint;stdcall;

//Point table Feeder (Only for PCI-825x)
function APS_set_feeder_group(  GroupId:Longint;  Dimension:Longint;  var Axis_ID_Array:Longint ):Longint;stdcall;
function APS_get_feeder_group(  GroupId:Longint;  var Dimension:Longint;  var Axis_ID_Array:Longint ):Longint;stdcall;
function APS_free_feeder_group(  GroupId:Longint ):Longint;stdcall;
function APS_reset_feeder_buffer(  GroupId:Longint ):Longint;stdcall;
function APS_set_feeder_point_2D(  GroupId:Longint; var PtArray:PNT_DATA_2D;  Size:Longint;  LastFlag:Longint; ):Longint;stdcall;
function APS_set_feeder_point_2D_ex(  GroupId:Longint; var PtArray:PNT_DATA_2D_F64;  Size:Longint;  LastFlag:Longint ):Longint;stdcall;
function APS_start_feeder_move(  GroupId:Longint ):Longint;stdcall;
function APS_get_feeder_status(  GroupId:Longint;  var State:Longit;  var ErrCode:Longint ):Longint;stdcall;
function APS_get_feeder_running_index(  GroupId:Longint;  var Index:Longint ):Longint;stdcall;
function APS_get_feeder_feed_index(  GroupId:Longint;  var Index:Longint ):Longint;stdcall;
function APS_set_feeder_ex_pause(  GroupId:Longint ):Longint;stdcall;
function APS_set_feeder_ex_rollback(  GroupId:Longint;  Max_Speed:Longint ):Longint;stdcall;
function APS_set_feeder_ex_resume(  GroupId:Longint ):Longint;stdcall;
function APS_set_feeder_cfg_acc_type(  GroupId:Longint;  Type:Longint ):Longint;stdcall;

//implementation///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
implementation

// System & Initialization
function APS_initial; external 'APS168.dll';
function APS_close; external 'APS168.dll';
function APS_version; external 'APS168.dll';
function APS_device_driver_version; external 'APS168.dll';
function APS_get_axis_info; external 'APS168.dll';
function APS_set_board_param; external 'APS168.dll';
function APS_get_board_param; external 'APS168.dll';
function APS_set_axis_param; external 'APS168.dll';
function APS_get_axis_param; external 'APS168.dll';
function APS_get_watch_timer; external 'APS168.dll';
function APS_get_device_info; external 'APS168.dll';
function APS_get_card_name; external 'APS168.dll';
function APS_disable_device; external 'APS168.dll';
function APS_get_first_axisId; external 'APS168.dll';
function APS_set_security_key; external 'APS168.dll';
function APS_check_security_key; external 'APS168.dll';
function APS_reset_security_key; external 'APS168.dll';
function APS_load_param_from_file; external 'APS168.dll';
function APS_save_param_to_file; external 'APS168.dll';
function APS_register_virtual_board; external 'APS168.dll';
function APS_get_virtual_board_info; external 'APS168.dll';
function APS_set_axis_param_f; external 'APS168.dll';
function APS_get_axis_param_f; external 'APS168.dll';
function APS_get_eep_curr_drv_ctrl_mode; external 'APS168.dll';
function APS_set_sscnet_control_mode; external 'APS168.dll';
function APS_home_escape; external 'APS168.dll';
function APS_set_field_bus_int_factor_di; external 'APS168.dll';
function APS_get_field_bus_int_factor_di; external 'APS168.dll';
function APS_set_point_table_ex; external 'APS168.dll';
function APS_get_point_table_ex; external 'APS168.dll';
function APS_get_field_bus_a_input_plc; external 'APS168.dll';

function APS_enable_trigger_fifo_cmp; external 'APS168.dll';
function APS_get_trigger_fifo_cmp; external 'APS168.dll';
function APS_get_trigger_fifo_status; external 'APS168.dll';
function APS_set_trigger_fifo_data; external 'APS168.dll';
function APS_set_trigger_encoder_counter; external 'APS168.dll';
function APS_get_trigger_encoder_counter; external 'APS168.dll';
function APS_start_timer; external 'APS168.dll';
function APS_get_timer_counter; external 'APS168.dll';
function APS_set_timer_counter; external 'APS168.dll';

//PWM function
function APS_set_pwm_width; external 'APS168.dll';
function APS_get_pwm_width; external 'APS168.dll';
function APS_set_pwm_frequency; external 'APS168.dll';
function APS_get_pwm_frequency; external 'APS168.dll';
function APS_set_pwm_on; external 'APS168.dll';


//PCI-82548 Only for channel I/O
function APS_write_d_channel_output; external 'APS168.dll';
function APS_read_d_channel_output; external 'APS168.dll';

//Motion Stop Code [Only for PCI-8254/8]
function APS_get_stop_code; external 'APS168.dll';

//Motion queue status [Only for PCI-8254/8]
function APS_get_mq_free_space; external 'APS168.dll';
function APS_get_mq_usage; external 'APS168.dll';

// Monitor functions by float [Only for PCI-8254/8]
function APS_get_command_f; external 'APS168.dll';
function APS_set_command_f; external 'APS168.dll';
function APS_get_position_f; external 'APS168.dll';
function APS_set_position_f; external 'APS168.dll';
function APS_get_command_velocity_f; external 'APS168.dll';
function APS_get_target_position_f; external 'APS168.dll';
function APS_get_error_position_f; external 'APS168.dll';
function APS_get_feedback_velocity_f; external 'APS168.dll';

// Sampling functions extension[Only for PCI-82548 for up to 8 channel]
function APS_set_sampling_param_ex; external 'APS168.dll';
function APS_get_sampling_param_ex; external 'APS168.dll';
function APS_wait_trigger_sampling_ex; external 'APS168.dll';
function APS_wait_trigger_sampling_async_ex; external 'APS168.dll';
function APS_get_sampling_data_ex; external 'APS168.dll';

// Flash function [Only for PCI-8253/56; PCI-8392(H)]
function APS_save_parameter_to_flash; external 'APS168.dll';
function APS_load_parameter_from_flash; external 'APS168.dll';
function APS_load_parameter_from_default; external 'APS168.dll';

//Program download - APS
function APS_load_vmc_program; external 'APS168.dll';
function APS_save_vmc_program; external 'APS168.dll';
function APS_load_amc_program; external 'APS168.dll';
function APS_save_amc_program; external 'APS168.dll';
function APS_set_task_mode; external 'APS168.dll';
function APS_get_task_mode; external 'APS168.dll';
function APS_start_task; external 'APS168.dll';
function APS_get_task_info; external 'APS168.dll';
function APS_get_task_msg; external 'APS168.dll';

// SSCNET-3 functions [Only for PCI-8392(H)]
function APS_start_sscnet; external 'APS168.dll';
function APS_stop_sscnet; external 'APS168.dll';
function APS_get_sscnet_servo_param; external 'APS168.dll';
function APS_set_sscnet_servo_param; external 'APS168.dll';
function APS_get_sscnet_servo_alarm; external 'APS168.dll';
function APS_reset_sscnet_servo_alarm; external 'APS168.dll';
function APS_save_sscnet_servo_param; external 'APS168.dll';
function APS_get_sscnet_servo_abs_position; external 'APS168.dll';
function APS_save_sscnet_servo_abs_position; external 'APS168.dll';
function APS_load_sscnet_servo_abs_position; external 'APS168.dll';
function APS_get_sscnet_link_status; external 'APS168.dll';
function APS_set_sscnet_servo_monitor_src; external 'APS168.dll';
function APS_get_sscnet_servo_monitor_src; external 'APS168.dll';
function APS_get_sscnet_servo_monitor_data; external 'APS168.dll';

//Point table + IO - Pause / Resume
function APS_set_table_move_ex_pause; external 'APS168.dll';
function APS_set_table_move_ex_rollback; external 'APS168.dll';
function APS_set_table_move_ex_resume; external 'APS168.dll';

// Motion IO & motion status
function APS_get_command; external 'APS168.dll';
function APS_set_command; external 'APS168.dll';
function APS_motion_status; external 'APS168.dll';
function APS_motion_io_status; external 'APS168.dll';
function APS_set_servo_on; external 'APS168.dll';
function APS_get_position; external 'APS168.dll';
function APS_set_position; external 'APS168.dll';
function APS_get_command_velocity; external 'APS168.dll';
function APS_get_feedback_velocity; external 'APS168.dll';
function APS_get_error_position; external 'APS168.dll';
function APS_get_target_position; external 'APS168.dll';

//Multi-axes simultaneuos move start/stop
function APS_move_trigger; external 'APS168.dll';
function APS_stop_move_multi; external 'APS168.dll';
function APS_emg_stop_multi; external 'APS168.dll';

// Single axis motion
function APS_relative_move; external 'APS168.dll';
function APS_absolute_move; external 'APS168.dll';
function APS_velocity_move; external 'APS168.dll';
function APS_home_move; external 'APS168.dll';
function APS_stop_move; external 'APS168.dll';
function APS_emg_stop; external 'APS168.dll';
function APS_relative_move2; external 'APS168.dll';
function APS_absolute_move2; external 'APS168.dll';
function APS_home_move2; external 'APS168.dll';

//Point table Feeder (Only for PCI-825x)
function APS_set_feeder_group; external 'APS168.dll';
function APS_get_feeder_group; external 'APS168.dll';
function APS_free_feeder_group; external 'APS168.dll';
function APS_reset_feeder_buffer; external 'APS168.dll';
function APS_set_feeder_point_2D; external 'APS168.dll';
function APS_set_feeder_point_2D_ex; external 'APS168.dll';
function APS_start_feeder_move; external 'APS168.dll';
function APS_get_feeder_status; external 'APS168.dll';
function APS_get_feeder_running_index; external 'APS168.dll';
function APS_get_feeder_feed_index; external 'APS168.dll';
function APS_set_feeder_ex_pause; external 'APS168.dll';
function APS_set_feeder_ex_rollback; external 'APS168.dll';
function APS_set_feeder_ex_resume; external 'APS168.dll';
function APS_set_feeder_cfg_acc_type; external 'APS168.dll';

//Override functions [Only for MNET-1XMO/MNET-4XMO/MNET-4XMO-C]
function APS_speed_override; external 'APS168.dll';
function APS_relative_move_ovrd; external 'APS168.dll';
function APS_absolute_move_ovrd; external 'APS168.dll';

//JOG functions [Only for PCI-8392; PCI-8253/56]
function APS_set_jog_param; external 'APS168.dll';
function APS_get_jog_param; external 'APS168.dll';
function APS_jog_mode_switch; external 'APS168.dll';
function APS_jog_start; external 'APS168.dll';

// Interpolation
function APS_absolute_linear_move; external 'APS168.dll';
function APS_relative_linear_move; external 'APS168.dll';
function APS_absolute_arc_move; external 'APS168.dll';
function APS_relative_arc_move; external 'APS168.dll';

// Helical interpolation [Only for PCI-8392; PCI-8253/56]
function APS_absolute_helix_move; external 'APS168.dll';
function APS_relative_helix_move; external 'APS168.dll';

// Circular interpolation( Support 2D and 3D ) [Only for PCI-8392; PCI-8253/56]
function APS_absolute_arc_move_3pe; external 'APS168.dll';
function APS_relative_arc_move_3pe; external 'APS168.dll';

//Profile buffer setting
function APS_pt_set_absolute; external 'APS168.dll';
function APS_pt_set_relative; external 'APS168.dll';
function APS_pt_set_trans_buffered; external 'APS168.dll';
function APS_pt_set_trans_inp; external 'APS168.dll';
function APS_pt_set_trans_blend_dec; external 'APS168.dll';
function APS_pt_set_trans_blend_dist; external 'APS168.dll';
function APS_pt_set_trans_blend_pcnt; external 'APS168.dll';
function APS_pt_set_acc; external 'APS168.dll';
function APS_pt_set_dec; external 'APS168.dll';
function APS_pt_set_acc_dec; external 'APS168.dll';
function APS_pt_set_s; external 'APS168.dll';
function APS_pt_set_vm; external 'APS168.dll';
function APS_pt_set_ve; external 'APS168.dll';

//VAO function(Laser function) [Only for PCI-8253/6]
function APS_set_vao_param; external 'APS168.dll';
function APS_get_vao_param; external 'APS168.dll';
function APS_set_vao_table; external 'APS168.dll';
function APS_switch_vao_table; external 'APS168.dll';
function APS_start_vao; external 'APS168.dll';
function APS_get_vao_status; external 'APS168.dll';
function APS_check_vao_param; external 'APS168.dll';
function APS_set_vao_param_ex; external 'APS168.dll';
function APS_get_vao_param_ex; external 'APS168.dll';

//For Single latch for PCI8154/58/MNET-4XMO-(C)
function APS_manual_latch2; external 'APS168.dll';
function APS_get_latch_data2; external 'APS168.dll';

// Interrupt functions
function APS_int_enable; external 'APS168.dll';
function APS_set_int_factor; external 'APS168.dll';
function APS_get_int_factor; external 'APS168.dll';
//HANDLE FNTYPE APS_set_int_factorH( Board_ID:Longint;   Item_No:Longint;   Factor_No:Longint;   Enable:Longint ):Longint;stdcall;

function APS_wait_single_int; external 'APS168.dll';
function APS_wait_multiple_int; external 'APS168.dll';
function APS_reset_int; external 'APS168.dll';
function APS_set_int; external 'APS168.dll';
	//[Only for PCI-8154/58]
function APS_wait_error_int; external 'APS168.dll';

// Sampling functions [Only for PCI-8392; PCI-8253/56]
function APS_set_sampling_param; external 'APS168.dll';
function APS_get_sampling_param; external 'APS168.dll';
function APS_wait_trigger_sampling; external 'APS168.dll';
function APS_wait_trigger_sampling_async; external 'APS168.dll';
function APS_get_sampling_count; external 'APS168.dll';
function APS_stop_wait_sampling; external 'APS168.dll';
function APS_read_a_output_value; external 'APS168.dll';

//DIO & AIO
function APS_write_d_output; external 'APS168.dll';
function APS_read_d_output; external 'APS168.dll';
function APS_read_d_input; external 'APS168.dll';

function APS_read_a_input_value; external 'APS168.dll';
function APS_read_a_input_data; external 'APS168.dll';
function APS_write_a_output_value; external 'APS168.dll';
function APS_write_a_output_data; external 'APS168.dll';

//Point table move
function APS_set_point_table; external 'APS168.dll';
function APS_get_point_table; external 'APS168.dll';
function APS_get_running_point_index; external 'APS168.dll';
function APS_get_start_point_index; external 'APS168.dll';
function APS_get_end_point_index; external 'APS168.dll';
function APS_set_table_move_pause; external 'APS168.dll';
function APS_set_table_move_repeat; external 'APS168.dll';
function APS_point_table_move; external 'APS168.dll';

//Point table move2
function APS_set_point_table_mode2; external 'APS168.dll';
function APS_set_point_table2; external 'APS168.dll';
function APS_point_table_continuous_move2; external 'APS168.dll';
function APS_point_table_single_move2; external 'APS168.dll';
function APS_get_running_point_index2; external 'APS168.dll';
function APS_point_table_status2; external 'APS168.dll';

function APS_set_point_tableEx; external 'APS168.dll';
function APS_set_point_tableEx_2D; external 'APS168.dll';
function APS_set_point_table_4DL; external 'APS168.dll';

//Gear/Gantry function
function APS_start_gear; external 'APS168.dll';
function APS_get_gear_status; external 'APS168.dll';

//Point table Only for HSL-4XMO
function APS_set_point_table3; external 'APS168.dll';
function APS_point_table_move3; external 'APS168.dll';
function APS_set_point_table_param3; external 'APS168.dll';

// Gantry functions. [Only for PCI-8392; PCI-8253/56]
function APS_set_gantry_param; external 'APS168.dll';
function APS_get_gantry_param; external 'APS168.dll';
function APS_set_gantry_axis; external 'APS168.dll';
function APS_get_gantry_axis; external 'APS168.dll';
function APS_get_gantry_error; external 'APS168.dll';

// Digital filter functions. [Only for PCI-8253/56]
function APS_set_filter_param; external 'APS168.dll';
function APS_get_filter_param; external 'APS168.dll';
function APS_manual_set_filter; external 'APS168.dll';
function APS_get_filter_coef; external 'APS168.dll';

//Field bus master fucntions For PCI-8392(H)
function APS_set_field_bus_param; external 'APS168.dll';
function APS_get_field_bus_param; external 'APS168.dll';
function APS_start_field_bus; external 'APS168.dll';
function APS_stop_field_bus; external 'APS168.dll';

function APS_get_field_bus_device_info; external 'APS168.dll';
function APS_get_field_bus_last_scan_info; external 'APS168.dll';
function APS_get_field_bus_master_type; external 'APS168.dll';
function APS_get_field_bus_slave_type; external 'APS168.dll';
function APS_get_field_bus_slave_name; external 'APS168.dll';
function APS_get_field_bus_slave_first_axisno; external 'APS168.dll';

//Field bus slave general functions
function APS_set_field_bus_slave_param; external 'APS168.dll';
function APS_get_field_bus_slave_param; external 'APS168.dll';
function APS_get_slave_connect_quality; external 'APS168.dll';
function APS_get_slave_online_status; external 'APS168.dll';

//Field bus DIO slave fucntions For PCI-8392(H)
function APS_set_field_bus_d_output; external 'APS168.dll';
function APS_get_field_bus_d_output; external 'APS168.dll';
function APS_get_field_bus_d_input; external 'APS168.dll';

//Field bus AIO slave function
function APS_set_field_bus_a_output; external 'APS168.dll';
function APS_get_field_bus_a_output; external 'APS168.dll';
function APS_get_field_bus_a_input; external 'APS168.dll';

//Field bus Comparing trigger functions
function APS_set_field_bus_trigger_param; external 'APS168.dll';
function APS_get_field_bus_trigger_param; external 'APS168.dll';
function APS_set_field_bus_trigger_linear; external 'APS168.dll';
function APS_set_field_bus_trigger_table; external 'APS168.dll';
function APS_set_field_bus_trigger_manual; external 'APS168.dll';
function APS_set_field_bus_trigger_manual_s; external 'APS168.dll';
function APS_get_field_bus_trigger_table_cmp; external 'APS168.dll';
function APS_get_field_bus_trigger_linear_cmp; external 'APS168.dll';
function APS_get_field_bus_trigger_count; external 'APS168.dll';
function APS_reset_field_bus_trigger_count; external 'APS168.dll';
function APS_get_field_bus_linear_cmp_remain_count; external 'APS168.dll';
function APS_get_field_bus_table_cmp_remain_count; external 'APS168.dll';
function APS_get_field_bus_encoder; external 'APS168.dll';
function APS_set_field_bus_encoder; external 'APS168.dll';
function APS_field_bus_A_get_input_plc; external 'APS168.dll';

// Comparing trigger functions
function APS_set_trigger_param; external 'APS168.dll';
function APS_get_trigger_param; external 'APS168.dll';
function APS_set_trigger_linear; external 'APS168.dll';
function APS_set_trigger_table; external 'APS168.dll';
function APS_set_trigger_manual; external 'APS168.dll';
function APS_set_trigger_manual_s; external 'APS168.dll';
function APS_get_trigger_table_cmp; external 'APS168.dll';
function APS_get_trigger_linear_cmp; external 'APS168.dll';
function APS_get_trigger_count; external 'APS168.dll';
function APS_reset_trigger_count; external 'APS168.dll';

// Pulser counter function
function APS_get_pulser_counter; external 'APS168.dll';
function APS_set_pulser_counter; external 'APS168.dll';

// Reserved functions
function APS_field_bus_slave_set_param; external 'APS168.dll';
function APS_field_bus_slave_get_param; external 'APS168.dll';

function APS_field_bus_d_set_output; external 'APS168.dll';
function APS_field_bus_d_get_output; external 'APS168.dll';
function APS_field_bus_d_get_input; external 'APS168.dll';

function APS_field_bus_A_set_output; external 'APS168.dll';
function APS_field_bus_A_get_output; external 'APS168.dll';
function APS_field_bus_A_get_input; external 'APS168.dll';

//Dpac Function
function APS_rescan_CF; external 'APS168.dll';
function APS_get_battery_status; external 'APS168.dll';

//DPAC Display & Display Button
function APS_get_display_data; external 'APS168.dll';
function APS_set_display_data; external 'APS168.dll';
function APS_get_button_status; external 'APS168.dll';

//nv RAM funciton
function APS_set_nv_ram; external 'APS168.dll';
function APS_get_nv_ram; external 'APS168.dll';
function APS_clear_nv_ram; external 'APS168.dll';

//Watch dog timer
function APS_wdt_start; external 'APS168.dll';
function APS_wdt_get_timeout_period; external 'APS168.dll';
function APS_wdt_reset_counter; external 'APS168.dll';
function APS_wdt_get_counter; external 'APS168.dll';
function APS_wdt_set_action_event; external 'APS168.dll';
function APS_wdt_get_action_event; external 'APS168.dll';

//Cmd buffer setting
function APS_pt_ext_set_do_ch; external 'APS168.dll';
function APS_pt_ext_set_table_no; external 'APS168.dll';

//Simultaneous move [Only for MNET series]
function APS_set_relative_simultaneous_move; external 'APS168.dll';
function APS_set_absolute_simultaneous_move; external 'APS168.dll';
function APS_start_simultaneous_move; external 'APS168.dll';
function APS_stop_simultaneous_move; external 'APS168.dll';
function APS_emg_stop_simultaneous_move; external 'APS168.dll';

//New Interface
function APS_ptp; external 'APS168.dll';
function APS_ptp_v; external 'APS168.dll';
function APS_ptp_all; external 'APS168.dll';
function APS_vel; external 'APS168.dll';
function APS_vel_all; external 'APS168.dll';
function APS_line; external 'APS168.dll';
function APS_line_v; external 'APS168.dll';
function APS_line_all; external 'APS168.dll';
function APS_arc2_ca; external 'APS168.dll';
function APS_arc2_ca_v; external 'APS168.dll';
function APS_arc2_ca_all; external 'APS168.dll';
function APS_arc2_ce; external 'APS168.dll';
function APS_arc2_ce_v; external 'APS168.dll';
function APS_arc2_ce_all; external 'APS168.dll';
function APS_arc3_ca; external 'APS168.dll';
function APS_arc3_ca_v; external 'APS168.dll';
function APS_arc3_ca_all; external 'APS168.dll';
function APS_arc3_ce; external 'APS168.dll';
function APS_arc3_ce_v; external 'APS168.dll';
function APS_arc3_ce_all; external 'APS168.dll';
function APS_spiral_ca; external 'APS168.dll';
function APS_spiral_ca_v; external 'APS168.dll';
function APS_spiral_ca_all; external 'APS168.dll';
function APS_spiral_ce; external 'APS168.dll';
function APS_spiral_ce_v; external 'APS168.dll';
function APS_spiral_ce_all; external 'APS168.dll';

//enable & disable
function APS_pt_enable; external 'APS168.dll';
function APS_pt_disable; external 'APS168.dll';
function APS_get_pt_info; external 'APS168.dll';
function APS_pt_set_vs; external 'APS168.dll';
function APS_pt_get_vs; external 'APS168.dll';
function APS_pt_start; external 'APS168.dll';
function APS_pt_stop; external 'APS168.dll';
function APS_get_pt_status; external 'APS168.dll';
function APS_reset_pt_buffer; external 'APS168.dll';
function APS_pt_roll_back; external 'APS168.dll';
function APS_pt_get_error; external 'APS168.dll';

//field bus
function APS_set_field_bus_d_channel_output; external 'APS168.dll';
function APS_get_field_bus_d_channel_output; external 'APS168.dll';
function APS_get_field_bus_d_channel_input; external 'APS168.dll';

function APS_set_velocity_simultaneous_move; external 'APS168.dll';
function APS_Release_simultaneous_move; external 'APS168.dll';

//[Only for PCI-7856 motion interrupt]
function APS_set_field_bus_int_factor_motion; external 'APS168.dll';
function APS_get_field_bus_int_factor_motion; external 'APS168.dll';
function APS_set_field_bus_int_factor_error; external 'APS168.dll';
function APS_get_field_bus_int_factor_error; external 'APS168.dll';
function APS_reset_field_bus_int_motion; external 'APS168.dll';
function APS_wait_field_bus_error_int_motion; external 'APS168.dll';

function APS_auto_sampling; external 'APS168.dll';
function APS_get_sampling_data; external 'APS168.dll';

//Raw command counter [Only for PCI-8254/8]
function APS_get_command_counter; external 'APS168.dll';

//Point table Feeder (Only for PCI-8254/8)
function APS_pt_dwell; external 'APS168.dll';
function APS_pt_line; external 'APS168.dll';
function APS_pt_arc2_ca; external 'APS168.dll';
function APS_pt_arc2_ce; external 'APS168.dll';
function APS_pt_arc3_ca; external 'APS168.dll';
function APS_pt_arc3_ce; external 'APS168.dll';
function APS_pt_spiral_ca; external 'APS168.dll';
function APS_pt_spiral_ce; external 'APS168.dll';

//Latch functins
function APS_get_encoder; external 'APS168.dll';
function APS_get_latch_counter; external 'APS168.dll';
function APS_get_latch_event; external 'APS168.dll';

//Latch Function: for latching multi-points
function APS_set_ltc_counter; external 'APS168.dll';
function APS_get_ltc_counter; external 'APS168.dll';
function APS_set_ltc_fifo_param; external 'APS168.dll';
function APS_get_ltc_fifo_param; external 'APS168.dll';
function APS_manual_latch; external 'APS168.dll';
function APS_enable_ltc_fifo; external 'APS168.dll';
function APS_reset_ltc_fifo; external 'APS168.dll';
function APS_get_ltc_fifo_data; external 'APS168.dll';
function APS_get_ltc_fifo_usage; external 'APS168.dll';
function APS_get_ltc_fifo_free_space; external 'APS168.dll';
function APS_get_ltc_fifo_status; external 'APS168.dll';
function APS_set_backlash_en; external 'APS168.dll';
function APS_get_backlash_en; external 'APS168.dll';





end.