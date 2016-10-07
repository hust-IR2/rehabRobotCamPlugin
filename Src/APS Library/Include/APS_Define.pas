unit APS_Define;

interface

        	 const
           // Initial option
           INIT_MANUAL_ID:Longint=$1;	//CardId manual by dip switch; Input parameter of APS_initial:Longint= cardId; "MODE" ;

           // Board parameter define :Longint=General;
           PRB_EMG_LOGIC		:Longint=$0;  // Board EMG logic

           PRB_WDT0_VALUE		:Longint=$10;  // Set / Get watch dog limit.
           PRB_WDT0_COUNTER	:Longint=$11;  // Reset Wdt / Get Wdt_Count_Value
           PRB_WDT0_UNIT		:Longint=$12;  // wdt_unit
           PRB_WDT0_ACTION	:Longint=$13;  // wdt_action

           PRB_TMR0_BASE		:Longint=$20;  // Set TMR Value
           PRB_TMR0_VALUE  	:Longint=$21;  // Get timer int count value

           PRB_SYS_TMP_MONITOR	:Longint=$30;  // Get system temperature monitor data
           PRB_CPU_TMP_MONITOR	:Longint=$31;  // Get CPU temperature monitor data
           PRB_AUX_TMP_MONITOR	:Longint=$32;  // Get AUX temperature monitor data
           
           // PointTable, option
					 PT_OPT_ABS      :Longint=$00000000;    // move, absolute
					 PT_OPT_REL      :Longint=$00000001;    // move, relative
					 PT_OPT_LINEAR   :Longint=$00000000;    // move, linear
					 PT_OPT_ARC      :Longint=$00000004;    // move, arc
					 PT_OPT_FC_CSTP  :Longint=$00000000;    // signal, command stop (finish condition)
					 PT_OPT_FC_INP   :Longint=$00000010;    // signal, in position
					 PT_OPT_LAST_POS :Longint=$00000020;    // last point index
					 PT_OPT_DWELL    :Longint=$00000040;    // dwell
					 PT_OPT_RAPID    :Longint=$00000080;    // rapid positioning
					 PT_OPT_NOARC    :Longint=$00010000;    // do not add arc
					 PT_OPT_SCUVE    :Longint=$00000002;    // s-curve
					 
					 // PTP buffer mode define
					 PTP_OPT_ABORTING       :Longint=$00000000;
					 PTP_OPT_BUFFERED       :Longint=$00001000;
					 PTP_OPT_BLEND_LOW      :Longint=$00002000;
					 PTP_OPT_BLEND_PREVIOUS :Longint=$00003000;
					 PTP_OPT_BLEND_NEXT     :Longint=$00004000;
					 PTP_OPT_BLEND_HIGH     :Longint=$00005000;
					 ITP_OPT_ABORT_BLEND     :Longint=$00000000;
					 ITP_OPT_ABORT_FORCE     :Longint=$00001000;
					 ITP_OPT_ABORT_STOP      :Longint=$00002000;
					 ITP_OPT_BUFFERED        :Longint=$00003000;
					 ITP_OPT_BLEND_DEC_EVENT :Longint=$00004000;
					 ITP_OPT_BLEND_RES_DIST  :Longint=$00005000;
					 ITP_OPT_BLEND_RES_DIST_PERCENT :Longint=$00006000;
					 
					 //Latch parameter number define. [Only for PCI-8158A]
						//////////////////////////////////////
						 LTC_ENC_IPT_MODE          :Longint=$00;
						 LTC_ENC_EA_INV            :Longint=$01;
						 LTC_ENC_EB_INV            :Longint=$02;
						 LTC_ENC_EZ_CLR_LOGIC      :Longint=$03;
						 LTC_ENC_EZ_CLR_EN         :Longint=$04;
						 LTC_ENC_SIGNAL_FILITER_EN :Longint=$05;
						 LTC_FIFO_HIGH_LEVEL       :Longint=$06;
						 LTC_SIGNAL_FILITER_EN     :Longint=$07;
						 LTC_SIGNAL_TRIG_LOGIC     :Longint=$08;
						//////////////////////////////////////
					 
					 // move option define
					 OPT_ABSOLUTE      :Longint=$00000000;
					 OPT_RELATIVE      :Longint=$00000001;
					 OPT_WAIT          :Longint=$00000100;
           
           PRB_PWM0_MAP_DO		:Longint=$110;  // Enable & Map PWM0 to Do channels
					 PRB_PWM1_MAP_DO		:Longint=$111;  // Enable & Map PWM1 to Do channels
					 PRB_PWM2_MAP_DO		:Longint=$112;  // Enable & Map PWM2 to Do channels
					 PRB_PWM3_MAP_DO		:Longint=$113;  // Enable & Map PWM3 to Do channels
					 
					 // Filter parameter number define [Only for PCI-8253/56]
					 FTR_TYPE_ST0                    :Longint=$00;  // Station 0 filter type
					 FTR_FC_ST0                      :Longint=$01;  // Station 0 filter cutoff frequency
					 FTR_BW_ST0                      :Longint=$02;  // Station 0 filter bandwidth
					 FTR_ENABLE_ST0                  :Longint=$03;  // Station 0 filter enable/disable
					 FTR_TYPE_ST1                    :Longint=$10;  // Station 1 filter type
					 FTR_FC_ST1                      :Longint=$11;  // Station 1 filter cutoff frequency
					 FTR_BW_ST1                      :Longint=$12;  // Station 1 filter bandwidth
					 FTR_ENABLE_ST1                  :Longint=$13;  // Station 1 filter enable/disable
					 
					 	//Following definition for PCI-8254/8
					 MTS_MDN        :Longint=5;         // Motion done. 0: In motion, 1: Motion done ( It could be abnormal stop)
					 MTS_WAIT       :Longint=10;        // Axis is in waiting state. ( Wait move trigger )
					 MTS_PTB         :Longint=11;        // Axis is in point buffer moving. ( When this bit on, MDN and ASTP will be cleared )
					 MTS_BLD		    :Longint=17;       // Axis (Axes) in blending moving
					 MTS_PRED       :Longint=18;        // Pre-distance event, 1: event arrived. The event will be clear when axis start moving 
					 MTS_POSTD     :Longint=19;        // Post-distance event. 1: event arrived. The event will be clear when axis start moving
					 MTS_GER         :Longint=28;        // 1: In geared ( This axis as slave axis and it follow a master specified in axis parameter. )
					 
					 //Trigger parameter number define. [Only for PCI-8158A]
					 TIG_LCMP0_SRC :Longint=$00;
					 TIG_LCMP1_SRC :Longint=$01;
					 TIG_LCMP2_SRC :Longint=$02;
					 TIG_LCMP3_SRC :Longint=$03;
					 TIG_LCMP4_SRC :Longint=$4;
					 TIG_LCMP5_SRC :Longint=$5;
					 TIG_LCMP6_SRC :Longint=$6;
					 TIG_LCMP7_SRC :Longint=$7;
					 TIG_TCMP0_SRC :Longint=$8;
					 TIG_TCMP1_SRC :Longint=$9;
					 TIG_TCMP2_SRC :Longint=$A;
					 TIG_TCMP3_SRC :Longint=$B;
					 TIG_TCMP4_SRC :Longint=$C;
					 TIG_TCMP5_SRC :Longint=$D;
					 TIG_TCMP6_SRC :Longint=$E;
					 TIG_TCMP7_SRC :Longint=$F;
					 TIG_TRG0_EN :Longint=$10;
					 TIG_TRG1_EN :Longint=$11;
					 TIG_TRG2_EN :Longint=$12;
					 TIG_TRG3_EN :Longint=$13;
					 TIG_TRG4_EN :Longint=$14;
					 TIG_TRG5_EN :Longint=$15;
					 TIG_TRG6_EN :Longint=$16;
					 TIG_TRG7_EN :Longint=$17;
					 TIG_TRG0_SRC:Longint=$18;
					 TIG_TRG1_SRC :Longint=$19;
					 TIG_TRG2_SRC :Longint=$1A;
					 TIG_TRG3_SRC :Longint=$1B;
					 TIG_TRG4_SRC :Longint=$1C;
					 TIG_TRG5_SRC :Longint=$1D;
					 TIG_TRG6_SRC :Longint=$1E;
					 TIG_TRG7_SRC :Longint=$1F;
					 TIG_TRG0_PWD :Longint=$20;
					 TIG_TRG1_PWD :Longint=$21;
					 TIG_TRG2_PWD :Longint=$20;
					 TIG_TRG3_PWD :Longint=$23;
					 TIG_TRG4_PWD :Longint=$24;
					 TIG_TRG5_PWD :Longint=$25;
				   TIG_TRG6_PWD :Longint=$26;
					 TIG_TRG7_PWD :Longint=$27;
					 TIG_TRG0_LOGIC :Longint=$28;
					 TIG_TRG1_LOGIC :Longint=$29;
					 TIG_TRG2_LOGIC :Longint=$2A;
					 TIG_TRG3_LOGIC :Longint=$2B;
					 TIG_TRG4_LOGIC :Longint=$2C;
					 TIG_TRG5_LOGIC :Longint=$2D;
					 TIG_TRG6_LOGIC :Longint=$2E;
					 TIG_TRG7_LOGIC :Longint=$2F;
					 TIG_TRG0_TGL :Longint=$30;
					 TIG_TRG1_TGL :Longint=$31;
					 TIG_TRG2_TGL :Longint=$32;
					 TIG_TRG3_TGL :Longint=$33;
					 TIG_TRG4_TGL :Longint=$34;
					 TIG_TRG5_TGL :Longint=$35;
					 TIG_TRG6_TGL :Longint=$36;
					 TIG_TRG7_TGL :Longint=$37;
					 TIG_PWMTMR0_ITV :Longint=$40;
					 TIG_PWMTMR1_ITV :Longint=$41;
					 TIG_PWMTMR2_ITV :Longint=$42;
					 TIG_PWMTMR3_ITV :Longint=$43;
					 TIG_PWMTMR4_ITV :Longint=$44;
					 TIG_PWMTMR5_ITV :Longint=$45;
					 TIG_PWMTMR6_ITV :Longint=$46;
					 TIG_PWMTMR7_ITV :Longint=$47;
					 TIG_TMR0_ITV :Longint=$50;
					 TIG_TMR0_DIR :Longint=$51;
					 
					 //Trigger parameter number define. [Only for PCI-8258]
					 TGR_LCMP0_SRC    :Longint=$00;
					 TGR_LCMP1_SRC    :Longint=$01;
					 TGR_TCMP0_SRC    :Longint=$02;
					 TGR_TCMP1_SRC    :Longint=$03;
					
					 TGR_TCMP0_DIR    :Longint=$04;
					 TGR_TCMP1_DIR    :Longint=$05;
					 TGR_TRG_EN		    :Longint=$06;
					
					 TGR_TRG0_SRC     :Longint=$10;
					 TGR_TRG1_SRC     :Longint=$11;
					 TGR_TRG2_SRC     :Longint=$12;
					 TGR_TRG3_SRC     :Longint=$13;
					
					 TGR_TRG0_PWD     :Longint=$14;
					 TGR_TRG1_PWD     :Longint=$15;
					 TGR_TRG2_PWD     :Longint=$16;
					 TGR_TRG3_PWD     :Longint=$17;
					
					 TGR_TRG0_LOGIC     :Longint=$18; 
					 TGR_TRG1_LOGIC     :Longint=$19; 
					 TGR_TRG2_LOGIC     :Longint=$1A;
					 TGR_TRG3_LOGIC     :Longint=$1B;
					
					 TGR_TRG0_TGL	     :Longint=$1C; 
					 TGR_TRG1_TGL		 :Longint=$1D; 
					 TGR_TRG2_TGL		 :Longint=$1E;
					 TGR_TRG3_TGL		 :Longint=$1F;
					
					#define TIMR_ITV				(0x20)
					#define TIMR_DIR				(0x21)
					#define TIMR_RING_EN     (0x22)
					#define TIMR_EN				(0x23)
					 
					 //Trigger parameter number define. [Only for DB-8150]
					 //////////////////////////////////////
					 TG_PWM0_PULSE_WIDTH    :Longint=$00;
					 TG_PWM1_PULSE_WIDTH    :Longint=$01;
					 TG_PWM0_MODE           :Longint=$02;
					 TG_PWM1_MODE           :Longint=$03;
					 TG_TIMER0_INTERVAL     :Longint=$04;
					 TG_TIMER1_INTERVAL     :Longint=$05;
					 TG_ENC0_CNT_DIR        :Longint=$06;
					 TG_ENC1_CNT_DIR        :Longint=$07;				
					 TG_IPT0_MODE           :Longint=$08;
					 TG_IPT1_MODE           :Longint=$09;					
					 TG_EZ0_CLEAR_EN        :Longint=$0A;
					 TG_EZ1_CLEAR_EN        :Longint=$0B;					
					 TG_EZ0_CLEAR_LOGIC     :Longint=$0C;
					 TG_EZ1_CLEAR_LOGIC     :Longint=$0D;		
					 TG_CNT0_SOURCE         :Longint=$0E;
					 TG_CNT1_SOURCE         :Longint=$0F;				
					 TG_FTR0_EN		          :Longint=$10;
					 TG_FTR1_EN		          :Longint=$11;
					 TG_DI_LATCH0_EN        :Longint=$12;
					 TG_DI_LATCH1_EN        :Longint=$13;					
					 TG_DI_LATCH0_EDGE      :Longint=$14;
					 TG_DI_LATCH1_EDGE      :Longint=$15;				
					 TG_DI_LATCH0_VALUE     :Longint=$16;
					 TG_DI_LATCH1_VALUE     :Longint=$17;					
					 TG_TRGOUT_MAP          :Longint=$18;
					 TG_TRGOUT_LOGIC        :Longint=$19;				
					 TG_FIFO_LEVEL          :Longint=$1A;				
					 TG_PWM0_SOURCE         :Longint=$1B;
					 TG_PWM1_SOURCE         :Longint=$1C;
					 //////////////////////////////////////
					 
					 //Only for PCI-8254/8, AMP-204/8C
				   SAMP_COM_POS_F64						:Longint=$10; // Command position
				   SAMP_FBK_POS_F64						:Longint=$11; // Feedback position
				   SAMP_CMD_VEL_F64						:Longint=$12; // Command velocity
				   SAMP_FBK_VEL_F64						:Longint=$13; // Feedback velocity
				   SAMP_CONTROL_VOL_F64				:Longint=$14; // Control command voltage
				   SAMP_ERR_POS_F64						:Longint=$15; // Error position
				   SAMP_PWM_FREQUENCY_F64		  :Longint=$18; // PWM frequency (Hz)
				   SAMP_PWM_DUTY_CYCLE_F64		:Longint=$19; // PWM duty cycle (%)
				   SAMP_PWM_WIDTH_F64					:Longint=$1A; // PWM width (ns)
				   SAMP_VAO_COMP_VEL_F64			:Longint=$1B; // Composed velocity for Laser power control (pps)
				   SAMP_PTBUFF_COMP_VEL_F64		:Longint=$1C; // Composed velocity of point table
				   SAMP_PTBUFF_COMP_ACC_F64		:Longint=$1D; // Composed acceleration of point table
					 
					 //Continuous Move
					 PRA_CONTI_MODE      :Longint=$250; // Continuous Mode
					 PRA_CONTI_BUFF      :Longint=$251; // Continuous Buffer
					 
					 PRA_BIQUAD0_A1      :Longint=$132; // (F64) Biquad filter0 coefficient A1
					 PRA_BIQUAD0_A2      :Longint=$133; // (F64) Biquad filter0 coefficient A2
					 PRA_BIQUAD0_B0      :Longint=$134; // (F64) Biquad filter0 coefficient B0
					 PRA_BIQUAD0_B1      :Longint=$135; // (F64) Biquad filter0 coefficient B1
					 PRA_BIQUAD0_B2      :Longint=$136; // (F64) Biquad filter0 coefficient B2
					 PRA_BIQUAD0_DIV     :Longint=$137; // (F64) Biquad filter0 divider
					 PRA_BIQUAD1_A1      :Longint=$138; // (F64) Biquad filter1 coefficient A1
					 PRA_BIQUAD1_A2      :Longint=$139; // (F64) Biquad filter1 coefficient A2
					 PRA_BIQUAD1_B0      :Longint=$13A; // (F64) Biquad filter1 coefficient B0
					 PRA_BIQUAD1_B1      :Longint=$13B; // (F64) Biquad filter1 coefficient B1
					 PRA_BIQUAD1_B2      :Longint=$13C; // (F64) Biquad filter1 coefficient B2
					 PRA_BIQUAD1_DIV    :Longint=$13D; // (F64) Biquad filter1 divider
					 PRA_FRIC_GAIN		  :Longint=$13E; // (F64) Friction voltage compensation
					 
					 //following only for V2...
					 PRA_VOLTAGE_MAX     :Longint=$9B;  // Maximum output limit
					 PRA_VOLTAGE_MIN     :Longint=$9C;  // Minimum output limit
					 
           PRA_PT_STOP_ENDO    :Longint=$32;  // Disable do when point table stopping.
					 PRA_PT_STOP_DO      :Longint=$33;  // Set do value when point table stopping.
					 PRA_PWM_OFF         :Longint=$34;  // Disable specified PWM output when ASTP input signal is active.
					 PRA_DO_OFF          :Longint=$35;  // Set DO value when ASTP input signal is active.
					 
					 PRA_GEAR_MASTER       :Longint=$60;  // (I32) Select gearing master
					 PRA_GEAR_ENGAGE_RATE  :Longint=$61;  // (F64) Gear engage rate
					 PRA_GEAR_RATIO        :Longint=$62;  // (F64) Gear ratio
					 PRA_GANTRY_PROTECT_1  :Longint=$63;  // (F64) E-gear gantry mode protection level 1
					 PRA_GANTRY_PROTECT_2  :Longint=$64;  // (F64) E-gear gantry mode protection level 2
           
           MHS_GET_SERVO_OFF_INFO	   :Longint=$16;
           MHS_RESET_SERVO_OFF_INFO	 :Longint=$17;
           MHS_GET_ALL_STATE	       :Longint=$18;
           
           //following only for V2...
					 PRA_DIST            :Longint=$30;  // Move distance
					 PRA_MAX_VELOCITY    :Longint=$31;  // Maximum velocity
					 PRA_SCUR_PERCENTAGE :Longint=$32;  // Scurve percentage
					 PRA_BLENDING_MODE   :Longint=$33;  // Blending mode
					 PRA_STOP_MODE       :Longint=$34;  // Stop mode
					 PRA_STOP_DELRATE    :Longint=$35;  // Stop function deceleration rate
           
           PRB_DO_LOGIC			:Longint=$14;	//DO logic, 0: no invert; 1: invert
           PRB_DI_LOGIC			:Longint=$15;	//DI logic, 0: no invert; 1: invert
           
           PRA_PRE_EVENT_DIST		:Longint=$2A; //Pre-event distance
					 PRA_POST_EVENT_DIST	:Longint=$2B; //Post-event distance

           PRB_UART_MULTIPLIER	:Longint=$40;  // Set UART Multiplier

           PRB_PSR_MODE		:Longint=$90;	// Config pulser mode
           PRB_PSR_EA_LOGIC	:Longint=$91;	// Set EA inverted
           PRB_PSR_EB_LOGIC	:Longint=$92;	// Set EB inverted

           // Board parameter define (For PCI-8253/56;
           PRB_DENOMINATOR		:Longint=$80;	// Floating number denominator
               //PRB_PSR_MODE		:Longint=$90;	// Config pulser mode
           PRB_PSR_ENABLE		:Longint=$91;	// Enable/disable pulser mode
           PRB_BOOT_SETTING	:Longint=$100;	// Load motion parameter method when DSP boot
           
           // Initial option
					 INIT_AUTO_CARD_ID       :Longint=$0;   // (Bit 0) CardId assigned by system, Input parameter of APS_initial( cardId, "MODE" )
					 INIT_MANUAL_ID      		 :Longint=$1;   // (Bit 0) CardId manual by dip switch, Input parameter of APS_initial( cardId, "MODE" )
					 INIT_PARALLEL_FIXED 		 :Longint=$2;   // (Bit 1) Fixed axis indexing mode in Parallel type
					 INIT_SERIES_FIXED   		 :Longint=$4;   // (Bit 2) Fixed axis indexing mode in Series type
					 INIT_NOT_RESET_DO   		 :Longint=$8;   // (Bit 3) HSL Digital output not reset, (DO status will follow the slave status.)
					 INIT_PARAM_IGNORE       :Longint=$0;   // (Bit 4-5) Load parameter method - ignore, keep current value
					 INIT_PARAM_LOAD_DEFAULT :Longint=$10;  // (Bit 4-5) Load parameter method - load parameter as default value 
					 INIT_PARAM_LOAD_FLASH   :Longint=$20;  // (Bit 4-5) Load parameter method - load parameter from flash memory
					 INIT_MNET_INTERRUPT 		 :Longint=$40;  // (Bit 6) Enable MNET interrupt mode. (Support motion interrupt for MotionNet series)

           // Board parameter define (For PCI-8392 SSCNET;
           PRB_SSC_APPLICATION		:Longint=$10000; // Reserved
           PRB_SSC_CYCLE_TIME		:Longint=$10000; // SSCNET cycle time selection(vaild befor start sscnet;
           PRB_PARA_INIT_OPT		:Longint=$00020; // Initial boot mode.

           // Board parameter define (For DPAC;
           PRB_DPAC_DISPLAY_MODE			:Longint=$10001; //DPAC Display mode
           PRB_DPAC_DI_MODE    			:Longint=$10002; //Set DI pin modes

           PRB_DPAC_THERMAL_MONITOR_NO     :Longint=$20001; //DPAC TEST
           PRB_DPAC_THERMAL_MONITOR_VALUE  :Longint=$20002; //DPAC TEST

           // Axis parameter define (General;
           PRA_EL_LOGIC		:Longint=$00;	// EL logic
           PRA_ORG_LOGIC		:Longint=$01;	// ORG logic
           PRA_EL_MODE			:Longint=$02;  // EL stop mode
           PRA_MDM_CONDI		:Longint=$03;  // Motion done condition
           PRA_EL_EXCHANGE		:Longint=$04;  // PEL; MEL exchange enable

           PRA_ALM_LOGIC		:Longint=$04;	// ALM logic [PCI-8253/56 only]
           PRA_ZSP_LOGIC       :Longint=$05;	// ZSP logic [PCI-8253/56 only]
           PRA_EZ_LOGIC		:Longint=$06;	// EZ logic  [PCI-8253/56 only]
           PRA_STP_DEC			:Longint=$07;	// Stop deceleration
           PRA_SPEL_EN			:Longint=$08;	// SPEL Enable
           PRA_SMEL_EN			:Longint=$09;	// SMEL Enable
           PRA_EFB_POS0		:Longint=$0A;	// EFB position 0
           PRA_EFB_POS1		:Longint=$0B;	// EFB position 1
           PRA_EFB_CONDI0		:Longint=$0C;	// EFB position 0 condition
           PRA_EFB_CONDI1		:Longint=$0D;	// EFB position 1 condition
           PRA_EFB_SRC0		:Longint=$0E;	// EFB position 0 source
           PRA_EFB_SRC1		:Longint=$0F;	// EFB position 1 source
           PRA_HOME_MODE		:Longint=$10;	// home mode
           PRA_HOME_DIR		:Longint=$11;	// homing direction
           PRA_HOME_CURVE		:Longint=$12;	// homing curve parten(T or s curve;
           PRA_HOME_ACC		:Longint=$13;	// Acceleration deceleration rate
           PRA_HOME_VS			:Longint=$14;	// homing start velocity
           PRA_HOME_VM			:Longint=$15;	// homing max velocity
           PRA_HOME_VA			:Longint=$16;	// homing approach velocity	[PCI-8253/56 only]
           PRA_HOME_EZA		:Longint=$18;	// EZ alignment enable
           PRA_HOME_VO			:Longint=$19;	// Homing leave ORG velocity
           PRA_HOME_OFFSET		:Longint=$1A;	// The escape pulse amounts(Leaving home by position;
           PRA_HOME_POS			:Longint=$1B;  // The position from ORG [PCI-8254/58 only]

           PRA_CURVE		:Longint=$20;	 // Move curve pattern
           PRA_ACC			:Longint=$21;	 // Move acceleration
           PRA_DEC			:Longint=$22;	 // Move deceleration
           PRA_VS				:Longint=$23;	 // Move start velocity
           PRA_VE				:Longint=$25;  // Move end velocity
           PRA_SACC			:Longint=$26;  // Scrve acceleration
           PRA_SDEC			:Longint=$27;  // Scrve deceleration
           PRA_ACC_SR   :Longint=$28;  // S curve ratio in acceleration( S curve with linear acceleration)
           PRA_DEC_SR   :Longint=$29;  // S curve ratio in deceleration( S curve with linear deceleration)
           
           
           _PRA_ENCODER_FILTER  :Longint=$83; // (I32)
				   PRA_ENCODER_DIR     :Longint=$85; // (I32) 
				   PRA_POS_UNIT_FACTOR :Longint=$86; // (F64) position unit factor setting

           PRA_JG_MODE			:Longint=$40;	// Jog mode
           PRA_JG_DIR			:Longint=$41;	// Jog move direction
           PRA_JG_CURVE		:Longint=$42;	// Jog curve parten(T or s curve;
           PRA_JG_ACC			:Longint=$43;	// Jog move acceleration
           PRA_JG_DEC			:Longint=$44;	// Jog move deceleration
           PRA_JG_VM			:Longint=$45;  // Jog move max velocity
           PRA_JG_STEP			:Longint=$46;	// Jog offset (For step mode;
           PRA_JG_DELAY		:Longint=$47;	// Jog delay (For step mode;
           PRA_JG_MAP_DI_EN      :Longint=$48; // (I32) Enable Digital input map to jog command signal
					 PRA_JG_P_JOG_DI       :Longint=$49; // (I32) Mapping configuration for positive jog and digital input.
					 PRA_JG_N_JOG_DI       :Longint=$4A; // (I32) Mapping configuration for negative jog and digital input.
					 PRA_JG_JOG_DI         :Longint=$4B; // (I32) Mapping configuration for jog and digital input.

           PRA_MDN_DELAY		:Longint=$50;	// NSTP delay setting
           PRA_SINP_WDW		:Longint=$51;	// Soft INP window setting
           PRA_SINP_STBL		:Longint=$52;	// Soft INP stable cycle
           PRA_SERVO_LOGIC		:Longint=$53; //  SERVO logic

           // Axis parameter define (For PCI-8253/56;
           PRA_PLS_IPT_MODE	:Longint=$80;	// Pulse input mode setting
           PRA_PLS_OPT_MODE    :Longint=$81;	// Pulse output mode setting
           PRA_MAX_E_LIMIT		:Longint=$82;	// Maximum encoder count limit
           PRA_ENC_FILTER		:Longint=$83;	// Encoder filter
           PRA_EGEAR			:Longint=$84;	// E-Gear ratio
           PRA_ENCODER_DIR           :Longint=$85;  // Encoder direction
           PRA_POS_UNIT_FACTOR    :Longint=$86;  // position unit factor setting

           PRA_KP_GAIN			:Longint=$90;	// PID controller Kp gain
           PRA_KI_GAIN			:Longint=$91;	// PID controller Ki gain
           PRA_KD_GAIN			:Longint=$92;	// PID controller Kd gain
           PRA_KFF_GAIN		:Longint=$93;	// Feed forward Kff gain
           PRA_KVGTY_GAIN		:Longint=$94;	// Gantry controller Kvgty gain
           PRA_KPGTY_GAIN		:Longint=$95;	// Gantry controller Kpgty gain
           PRA_IKP_GAIN		:Longint=$96;	// PID controller Kp gain in torque mode
           PRA_IKI_GAIN		:Longint=$97;	// PID controller Ki gain in torque mode
           PRA_IKD_GAIN		:Longint=$98;	// PID controller Kd gain in torque mode
           PRA_IKFF_GAIN		:Longint=$99;	// Feed forward Kff gain in torque mode

           PRA_M_INTERFACE		:Longint=$100;	// Motion interface

           PRA_M_VOL_RANGE		:Longint=$110;	// Motor voltage input range
           PRA_M_MAX_SPEED		:Longint=$111;	// Motor maximum speed
           PRA_M_ENC_RES		:Longint=$112;	// Motor encoder resolution

           PRA_V_OFFSET		:Longint=$120;	// Voltage offset
           PRA_DZ_LOW			:Longint=$121;	// Dead zone low side
           PRA_DZ_UP			:Longint=$122;	// Dead zone up side
           PRA_SAT_LIMIT		:Longint=$123;	// Voltage saturation output limit
           PRA_ERR_C_LEVEL		:Longint=$124;	// Error counter check level
           PRA_V_INVERSE		:Longint=$125;	// Output voltage inverse
           PRA_DZ_VAL         :Longint=$126; // Dead zone output value
					 PRA_IW_MAX          :Longint=$127; // Integral windup maximum value
					 PRA_IW_MIN          :Longint=$128; // Integral windup minimum value
					 PRA_BKL_DIST        :Longint=$129; // Backlash distance
					 PRA_BKL_CNSP        :Longint=$12a; // Backlash consumption
					 PRA_INTEGRAL_LIMIT  :Longint=$12B; // (I32) Integral limit
					 PRA_D_SAMPLE_TIME   :Longint=$12C; // (I32) Derivative Sample Time

           PRA_PSR_LINK		:Longint=$130; // Connect pulser number
           PRA_PSR_RATIO		:Longint=$131; // Set pulser ratio

           PRA_DA_TYPE			:Longint=$140;	// DAC output type
           PRA_CONTROL_MODE	:Longint=$141;	// Closed loop control mode

           // Axis parameter define (For PCI-8154/58;
           // Input/Output Mode
           PRA_PLS_IPT_LOGIC	:Longint=$200; //Reverse pulse input counting
           PRA_FEEDBACK_SRC	:Longint=$201; //Select feedback conter

           //IO Config
           PRA_ALM_MODE		:Longint=$210; //ALM Mode
           PRA_INP_LOGIC		:Longint=$211; //INP Logic
           PRA_SD_EN			:Longint=$212; //SD Enable -- Bit 8
           PRA_SD_MODE			:Longint=$213; //SD Mode
           PRA_SD_LOGIC		:Longint=$214; //SD Logic
           PRA_SD_LATCH		:Longint=$215; //SD Latch
           PRA_ERC_MODE		:Longint=$216; //ERC Mode
           PRA_ERC_LOGIC		:Longint=$217; //ERC logic
           PRA_ERC_LEN			:Longint=$218; //ERC pulse width
           PRA_CLR_MODE		:Longint=$219; //CLR Mode
           PRA_CLR_TARGET		:Longint=$21A; //CLR Target counter
           PRA_PIN_FLT			:Longint=$21B; //EA/EB Filter Enable
           PRA_INP_MODE		:Longint=$21C; //INP Mode
           PRA_LTC_LOGIC		:Longint=$21D; //LTC LOGIC
           PRA_SOFT_PLIMIT		:Longint=$21E; //SOFT PLIMIT
           PRA_SOFT_MLIMIT		:Longint=$21F; //SOFT MLIMIT
           PRA_SOFT_LIMIT_EN	:Longint=$220; //SOFT ENABLE
           PRA_BACKLASH_PULSE  :Longint=$221; //BACKLASH PULSE
           PRA_BACKLASH_MODE   :Longint=$222; //BACKLASH MODE
           PRA_LTC_SRC		    :Longint=$223; //LTC Source
           PRA_LTC_DEST		:Longint=$224; //LTC Destination
           PRA_LTC_DATA		:Longint=$225; //Get LTC DATA
           PRA_GCMP_EN			:Longint=$226;	// CMP Enable
           PRA_GCMP_POS		:Longint=$227;	// Get CMP position
           PRA_GCMP_SRC		:Longint=$228;	// CMP source
           PRA_GCMP_ACTION		:Longint=$229;	// CMP Action
           PRA_GCMP_STS		:Longint=$22A;	// CMP Status
           PRA_VIBSUP_RT       :Longint=$22B; // Vibration Reverse Time
					 PRA_VIBSUP_FT       :Longint=$22C; // Vibration Forward Time
					 PRA_LTC_DATA_SPD       :Longint=$22D; // Choose latch data for current speed or error position

           PRA_GPDO_SEL		:Longint=$230; //Select DO/CMP Output mode
           PRA_GPDI_SEL		:Longint=$231; //Select DO/CMP Output mode
           PRA_GPDI_LOGIC		:Longint=$232; //Set gpio input logic
           PRA_RDY_LOGIC		:Longint=$233; //RDY logic

           //Fixed Speed
           PRA_SPD_LIMIT		:Longint=$240; // Set Fixed Speed
           PRA_MAX_ACCDEC		:Longint=$241; // Get max acceleration by fixed speed
           PRA_MIN_ACCDEC		:Longint=$242; // Get max acceleration by fixed speed
           PRA_ENABLE_SPD   :Longint=$243; // Disable/Enable Fixed Speed only for HSL-4XMO.

           // PCI-8144 axis parameter define
           PRA_CMD_CNT_EN		:Longint=$10000;
           PRA_MIO_SEN			:Longint=$10001;
           PRA_START_STA		:Longint=$10002;
           PRA_SPEED_CHN		:Longint=$10003;
           PRA_ORG_STP			:Longint=$1A;

           // Axis parameter define (For PCI-8392 SSCNET;
           PRA_SSC_SERVO_PARAM_SRC		:Longint=$10000; //Servo parameter source
           PRA_SSC_SERVO_ABS_POS_OPT	:Longint=$10001; //Absolute position system option
           PRA_SSC_SERVO_ABS_CYC_CNT	:Longint=$10002; //Absolute cycle counter of servo driver
           PRA_SSC_SERVO_ABS_RES_CNT	:Longint=$10003; //Absolute resolution counter of servo driver
           PRA_SSC_TORQUE_LIMIT_P 		:Longint=$10004; //Torque limit positive (0.1%;
           PRA_SSC_TORQUE_LIMIT_N		:Longint=$10005; //Torque limit negative (0.1%;
           PRA_SSC_TORQUE_CTRL			:Longint=$10006; //Torque control
           PRA_SSC_RESOLUTION			:Longint=$10007; //resolution (E-gear)
           PRA_SSC_GMR					:Longint=$10008; //resolution (New E-gear)
           PRA_SSC_GDR					:Longint=$10009; //resolution (New E-gear)

           // Sampling parameter define
           SAMP_PA_RATE		  :Longint=$0; //Sampling rate
           SAMP_PA_EDGE		  :Longint=$2; //Edge select
           SAMP_PA_LEVEL		:Longint=$3; //Level select
           SAMP_PA_TRIGCH		:Longint=$5; //Select trigger channel
           SAMP_PA_SEL      :Longint=$6;

           SAMP_PA_SRC_CH0		:Longint=$10; //Sample source of channel 0
           SAMP_PA_SRC_CH1		:Longint=$11; //Sample source of channel 1
           SAMP_PA_SRC_CH2		:Longint=$12; //Sample source of channel 2
           SAMP_PA_SRC_CH3		:Longint=$13; //Sample source of channel 3

           // Sampling source
           SAMP_AXIS_MASK		:Longint=$F00;
           SAMP_PARAM_MASK		:Longint=$FF;
           SAMP_COM_POS		:Longint=$00; //command position
           SAMP_FBK_POS		:Longint=$01; //feedback position
           SAMP_CMD_VEL		:Longint=$02; //command velocity
           SAMP_FBK_VEL		:Longint=$03; //feedback velocity
           SAMP_MIO			:Longint=$04; //motion IO
           SAMP_MSTS			:Longint=$05; //motion status
           SAMP_MSTS_ACC		:Longint=$06; //motion status acc
           SAMP_MSTS_MV		:Longint=$07; //motion status at max velocity
           SAMP_MSTS_DEC		:Longint=$08; //motion status at dec
           SAMP_MSTS_CSTP		:Longint=$09; //motion status CSTP
           SAMP_MSTS_NSTP		:Longint=$0A; //motion status NSTP
           SAMP_MIO_INP		:Longint=$0B; //motion status INP
           SAMP_MIO_ZERO		:Longint=$0C; //motion status ZERO
           SAMP_MIO_ORG		:Longint=$0D; //motion status OGR

           SAMP_SSC_MON_0		:Longint=$10;  // SSCNET servo monitor ch0
           SAMP_SSC_MON_1		:Longint=$11;  // SSCNET servo monitor ch1
           SAMP_SSC_MON_2		:Longint=$12;  // SSCNET servo monitor ch2
           SAMP_SSC_MON_3		:Longint=$13;  // SSCNET servo monitor ch3

           SAMP_CONTROL_VOL	:Longint=$20;  //
           SAMP_GTY_DEVIATION  :Longint=$21;
           SAMP_ENCODER_RAW    :Longint=$22;
           SAMP_ERROR_COUNTER  :Longint=$23;

           //FieldBus parameter define
           PRF_COMMUNICATION_TYPE		:Longint=$00;// FiledBus Communication Type(Full/half duplex;
           PRF_TRANSFER_RATE			:Longint=$01;// FiledBus Transfer Rate
           PRF_HUB_NUMBER				:Longint=$02;// FiledBus Hub Number
           PRF_INITIAL_TYPE			:Longint=$03;// FiledBus Initial Type(Clear/Reserve Do area;
           PRF_CHKERRCNT_LAYER  :Longint=$04;// Set the check error count layer.

           //Gantry parameter number define [Only for PCI-8392; PCI-8253/56]
           GANTRY_MODE					:Longint=$0;
           GENTRY_DEVIATION			:Longint=$1;
           GENTRY_DEVIATION_STP		:Longint=$2;

           // Filter parameter number define [Only for PCI-8253/56]
           FTR_TYPE					:Longint=$00;	// Filter type
           FTR_FC						:Longint=$01;	// Filter cutoff frequency
           FTR_BW						:Longint=$02;	// Filter bandwidth
           FTR_ENABLE					:Longint=$03;	// Filter enable/disable

           // Device name define
           DEVICE_NAME_NULL			:Longint=$FFFF;
           DEVICE_NAME_PCI_8392		:Longint=0;
           DEVICE_NAME_PCI_825X		:Longint=1;
           DEVICE_NAME_PCI_8154		:Longint=2;
           DEVICE_NAME_PCI_785X		:Longint=3;
           DEVICE_NAME_PCI_8158		:Longint=4;
           DEVICE_NAME_PCI_7856		:Longint=5;
           DEVICE_NAME_ISA_DPAC1000	:Longint=6;
           DEVICE_NAME_ISA_DPAC3000	:Longint=7;
           DEVICE_NAME_PCI_8144		    :Longint=8;
           DEVICE_NAME_PCI_8258       :Longint=9;
					 DEVICE_NAME_PCI_8102       :Longint=10;
					 DEVICE_NAME_PCI_V8258      :Longint=11;
					 DEVICE_NAME_PCI_V8254      :Longint=12;
					 DEVICE_NAME_PCI_8158A      :Longint=13;
					 DEVICE_NAME_AMP_82548      :Longint=14;


           ///////////////////////////////////////////////
           //   HSL Slave module definition
           ///////////////////////////////////////////////
           SLAVE_NAME_UNKNOWN			:Longint=$000;
           SLAVE_NAME_HSL_DI32			:Longint=$100;
           SLAVE_NAME_HSL_DO32			:Longint=$101;
           SLAVE_NAME_HSL_DI16DO16		:Longint=$102;
           SLAVE_NAME_HSL_AO4			:Longint=$103;
           SLAVE_NAME_HSL_AI16AO2_VV	:Longint=$104;
           SLAVE_NAME_HSL_AI16AO2_AV	:Longint=$105;
           SLAVE_NAME_HSL_DI16UL		:Longint=$106;
           SLAVE_NAME_HSL_DI16RO8		:Longint=$107;
           SLAVE_NAME_HSL_4XMO			:Longint=$108;
           SLAVE_NAME_HSL_DI16_UCT     :Longint=$109;
					 SLAVE_NAME_HSL_DO16_UCT     :Longint=$10A;
					 SLAVE_NAME_HSL_DI8DO8       :Longint=$10B;

					 ///////////////////////////////////////////////
					 //   MNET Slave module definition
					 ///////////////////////////////////////////////
           SLAVE_NAME_MNET_1XMO		:Longint=$200;
           SLAVE_NAME_MNET_4XMO		:Longint=$201;
           SLAVE_NAME_MNET_4XMO_C		:Longint=$202;


					 //Trigger parameter number define. [Only for PCI-8253/56]
           TG_LCMP0_SRC	:Longint=$00;
           TG_LCMP1_SRC	:Longint=$01;
           TG_TCMP0_SRC	:Longint=$02;
           TG_TCMP1_SRC	:Longint=$03;

           TG_LCMP0_EN		:Longint=$04;
           TG_LCMP1_EN		:Longint=$05;
           TG_TCMP0_EN		:Longint=$06;
           TG_TCMP1_EN		:Longint=$07;

           TG_TRG0_SRC		:Longint=$10;
           TG_TRG1_SRC		:Longint=$11;
           TG_TRG2_SRC		:Longint=$12;
           TG_TRG3_SRC		:Longint=$13;

           TG_TRG0_PWD		:Longint=$14;
           TG_TRG1_PWD		:Longint=$15;
           TG_TRG2_PWD		:Longint=$16;
           TG_TRG3_PWD		:Longint=$17;

           TG_TRG0_CFG		:Longint=$18;
           TG_TRG1_CFG		:Longint=$19;
           TG_TRG2_CFG		:Longint=$1A;
           TG_TRG3_CFG		:Longint=$1B;

           TMR_ITV			:Longint=$20;
           TMR_EN			:Longint=$21;

					 //Trigger parameter number define. [Only for MNET-4XMO-C]
           TG_CMP0_SRC				:Longint=$00;
           TG_CMP1_SRC				:Longint=$01;
           TG_CMP2_SRC				:Longint=$02;
           TG_CMP3_SRC				:Longint=$03;
           TG_CMP0_EN				:Longint=$04;
           TG_CMP1_EN				:Longint=$05;
           TG_CMP2_EN				:Longint=$06;
           TG_CMP3_EN				:Longint=$07;
           TG_CMP0_TYPE			:Longint=$08;
           TG_CMP1_TYPE			:Longint=$09;
           TG_CMP2_TYPE			:Longint=$0A;
           TG_CMP3_TYPE			:Longint=$0B;
           TG_CMPH_EN				:Longint=$0C;
           TG_CMPH_DIR_EN			:Longint=$0D;
           TG_CMPH_DIR				:Longint=$0E;

					 //TG_TRG0_SRC			:Longint=$10;
					 //TG_TRG1_SRC			:Longint=$11;
					 //TG_TRG2_SRC			:Longint=$12;
					 //TG_TRG3_SRC			:Longint=$13;

					 //TG_TRG0_PWD			:Longint=$14;
					 //TG_TRG1_PWD			:Longint=$15;
					 //TG_TRG2_PWD			:Longint=$16;
   				 //TG_TRG3_PWD			:Longint=$17;

					 //TG_TRG0_CFG			:Longint=$18;
				   //TG_TRG1_CFG			:Longint=$19;
					 //TG_TRG2_CFG			:Longint=$1A;
				 	 //TG_TRG3_CFG			:Longint=$1B;

           TG_ENCH_CFG				:Longint=$20;

           TG_TRG0_CMP_DIR			:Longint=$21;
           TG_TRG1_CMP_DIR			:Longint=$22;
           TG_TRG2_CMP_DIR			:Longint=$23;
           TG_TRG3_CMP_DIR			:Longint=$24;

					 // Motion IO status bit number define.
           MIO_ALM			:Longint=0;		// Servo alarm.
           MIO_PEL			:Longint=1;		// Positive end limit.
           MIO_MEL			:Longint=2;		// Negative end limit.
           MIO_ORG			:Longint=3;		// ORG :Longint=Home;
           MIO_EMG			:Longint=4;		// Emergency stop
           MIO_EZ			:Longint=5;		// EZ.
           MIO_INP			:Longint=6;		// In position.
           MIO_SVON		:Longint=7;		// Servo on signal.
           MIO_RDY			:Longint=8;		// Ready.
           MIO_WARN		:Longint=9;		// Warning.
           MIO_ZSP			:Longint=10;	// Zero speed.
           MIO_SPEL		:Longint=11;	// Soft positive end limit.
           MIO_SMEL		:Longint=12;	// Soft negative end limit.
           MIO_TLC			:Longint=13;	// Torque is limited by torque limit value.
           MIO_ABSL		:Longint=14;	// Absolute position lost.
           MIO_STA			:Longint=15;	// External start signal.
           MIO_PSD			:Longint=16;	// Positive slow down signal
           MIO_MSD			:Longint=17;	// Negative slow down signal

					 // Motion status bit number define.
           MTS_CSTP		:Longint=0;			// Command stop signal. 
           MTS_VM			:Longint=1;			// At maximum velocity.
           MTS_ACC			:Longint=2;			// In acceleration.
           MTS_DEC			:Longint=3;			// In deceleration.
           MTS_DIR			:Longint=4;			// :Longint=Last;Moving direction.
           MTS_NSTP		:Longint=5;			// Normal stop:Longint=Motion done;.
           MTS_HMV			:Longint=6;			// In home operation.
           MTS_SMV			:Longint=7;			// Single axis move:Longint= relative; absolute; velocity move;.
           MTS_LIP			:Longint=8;			// Linear interpolation.
           MTS_CIP			:Longint=9;			// Circular interpolation.
           MTS_VS			:Longint=10;		// At start velocity.
           MTS_PMV			:Longint=11;		// Point table move.
           MTS_PDW			:Longint=12;		// Point table dwell move.
           MTS_PPS			:Longint=13;		// Point table pause state.
           MTS_SLV			:Longint=14;		// Slave axis move.
           MTS_JOG			:Longint=15;		// Jog move.
           MTS_ASTP		:Longint=16;		// Abnormal stop.
           MTS_SVONS		:Longint=17;		// Servo off stopped.
           MTS_EMGS		:Longint=18;		// EMG / SEMG stopped.
           MTS_ALMS		:Longint=19;		// Alarm stop.
           MTS_WANS		:Longint=20;		// Warning stopped.
           MTS_PELS		:Longint=21;		// PEL stopped.
           MTS_MELS		:Longint=22;		// MEL stopped.
           MTS_ECES		:Longint=23;		// Error counter check level reaches and stopped.
           MTS_SPELS		:Longint=24;		// Soft PEL stopped.
           MTS_SMELS		:Longint=25;		// Soft MEL stopped.
           MTS_STPOA		:Longint=26;		// Stop by others axes.
           MTS_GDCES		:Longint=27;		// Gantry deviation error level reaches and stopped.
           MTS_GTM			:Longint=28;		// Gantry mode turn on.
           MTS_PAPB		:Longint=29;		// Pulsar mode turn on.

					 // Motion IO status bit value define.
           MIO_ALM_V		:Longint=$1;		// Servo alarm.
           MIO_PEL_V		:Longint=$2;		// Positive end limit.
           MIO_MEL_V		:Longint=$4;		// Negative end limit.
           MIO_ORG_V		:Longint=$8;		// ORG :Longint=Home;.
           MIO_EMG_V		:Longint=$10;		// Emergency stop.
           MIO_EZ_V		:Longint=$20;		// EZ.
           MIO_INP_V		:Longint=$40;		// In position.
           MIO_SVON_V		:Longint=$80;		// Servo on signal.
           MIO_RDY_V		:Longint=$100;		// Ready.
           MIO_WARN_V		:Longint=$200;		// Warning.
           MIO_ZSP_V		:Longint=$400;		// Zero speed.
           MIO_SPEL_V		:Longint=$800;		// Soft positive end limit.
           MIO_SMEL_V		:Longint=$1000;	// Soft negative end limit.
           MIO_TLC_V		:Longint=$2000;	// Torque is limited by torque limit value.
           MIO_ABSL_V		:Longint=$4000;	// Absolute position lost.
           MIO_STA_V		:Longint=$8000;	// External start signal.
           MIO_PSD_V		:Longint=$10000;	// Positive slow down signal.
           MIO_MSD_V		:Longint=$20000;	// Negative slow down signal.

					 // Motion status bit value define.
           MTS_CSTP_V		:Longint=$1;			// Command stop signal. 
           MTS_VM_V		:Longint=$2;			// At maximum velocity.
           MTS_ACC_V		:Longint=$4;			// In acceleration.
           MTS_DEC_V		:Longint=$8;			// In deceleration.
           MTS_DIR_V		:Longint=$10;			// :Longint=Last;Moving direction.
           MTS_NSTP_V		:Longint=$20;			// Normal stop:Longint=Motion done;.
           MTS_HMV_V		:Longint=$40;			// In home operation.
           MTS_SMV_V		:Longint=$80;			// Single axis move:Longint= relative; absolute; velocity move;.
           MTS_LIP_V		:Longint=$100;			// Linear interpolation.
           MTS_CIP_V		:Longint=$200;			// Circular interpolation.
           MTS_VS_V		:Longint=$400;			// At start velocity.
           MTS_PMV_V		:Longint=$800;			// Point table move.
           MTS_PDW_V		:Longint=$1000;		// Point table dwell move.
           MTS_PPS_V		:Longint=$2000;		// Point table pause state.
           MTS_SLV_V		:Longint=$4000;		// Slave axis move.
           MTS_JOG_V		:Longint=$8000;		// Jog move.
           MTS_ASTP_V		:Longint=$10000;		// Abnormal stop.
           MTS_SVONS_V		:Longint=$20000;		// Servo off stopped.
           MTS_EMGS_V		:Longint=$40000;		// EMG / SEMG stopped.
           MTS_ALMS_V		:Longint=$80000;		// Alarm stop.
           MTS_WANS_V		:Longint=$100000;		// Warning stopped.
           MTS_PELS_V		:Longint=$200000;		// PEL stopped.
           MTS_MELS_V		:Longint=$400000;		// MEL stopped.
           MTS_ECES_V		:Longint=$800000;		// Error counter check level reaches and stopped.
           MTS_SPELS_V		:Longint=$1000000;		// Soft PEL stopped.
           MTS_SMELS_V		:Longint=$2000000;		// Soft MEL stopped.
           MTS_STPOA_V		:Longint=$4000000;		// Stop by others axes.
           MTS_GDCES_V		:Longint=$8000000;		// Gantry deviation error level reaches and stopped.
           MTS_GTM_V		:Longint=$10000000;	// Gantry mode turn on.
           MTS_PAPB_V		:Longint=$20000000;	// Pulsar mode turn on.
           
           //Error Code define
           ERR_NoError						:Longint=0;		//No Error	
					 ERR_OSVersion					:Longint=-1;	// Operation System type mismatched
					 ERR_OpenDriverFailed			:Longint=-2;	// Open device driver failed - Create driver interface failed
					 ERR_InsufficientMemory			:Longint=-3;	// System memory insufficiently
					 ERR_DeviceNotInitial			:Longint=-4;	// Cards not be initialized
					 ERR_NoDeviceFound				:Longint=-5;	// Cards not found(No card in your system)
					 ERR_CardIdDuplicate				:Longint=-6;	// Cards' ID is duplicated. 
					 ERR_DeviceAlreadyInitialed		:Longint=-7;	// Cards have been initialed 
					 ERR_InterruptNotEnable			:Longint=-8;	// Cards' interrupt events not enable or not be initialized
					 ERR_TimeOut						:Longint=-9;	// Function time out
					 ERR_ParametersInvalid			:Longint=-10;	// Function input parameters are invalid
					 ERR_SetEEPROM					:Longint=-11;	// Set data to EEPROM (or nonvolatile memory) failed
					 ERR_GetEEPROM					:Longint=-12;	// Get data from EEPROM (or nonvolatile memory) failed
					 ERR_FunctionNotAvailable		:Longint=-13;	// Function is not available in this step, The device is not support this function or Internal process failed
					 ERR_FirmwareError				:Longint=-14;   // Firmware error, please reboot the system
					 ERR_CommandInProcess			:Longint=-15;	// Previous command is in process
					 ERR_AxisIdDuplicate				:Longint=-16;	// Axes' ID is duplicated.
					 ERR_ModuleNotFound				:Longint=-17;   // Slave module not found.
					 ERR_InsufficientModuleNo		:Longint=-18;	// System ModuleNo insufficiently
					 ERR_HandShakeFailed				:Longint=-19;   // HandSake with the DSP out of time.
					 ERR_FILE_FORMAT					:Longint=-20;	// Config file format error.(cannot be parsed)
					 ERR_ParametersReadOnly			:Longint=-21;	// Function parameters read only.
					 ERR_DistantNotEnough			:Longint=-22;	// Distant is not enough for motion.
					 ERR_FunctionNotEnable			:Longint=-23;	// Function is not enabled.
					 ERR_ServerAlreadyClose		:Longint=-24;	// Server already closed.
					 ERR_DllNotFound					:Longint=-25;	// Related dll is not found, not in correct path.
					 ERR_TrimDAC_Channel				:Longint=-26;
					 ERR_Satellite_Type				:Longint=-27;
					 ERR_Over_Voltage_Spec			:Longint=-28;
					 ERR_Over_Current_Spec			:Longint=-29;
					 ERR_SlaveIsNotAI				:Longint=-30;
					 ERR_Over_AO_Channel_Scope		:Longint=-31;
					 ERR_DllFuncFailed				:Longint=-32;	// Failed to invoke dll function. Extension Dll version is wrong.
					 ERR_FeederAbnormalStop		:Longint=-33; //Feeder abnormal stop, External stop or feeding stop
					 ERR_Read_ModuleType_Dismatch	:Longint=-33;					
					 ERR_Win32Error					:Longint=-1000; // No such INT number, or WIN32_API error, contact with ADLINK's FAE staff.		
					 ERR_DspStart					:Longint=-2000; // The base for DSP error


implementation



end.


