Attribute VB_Name = "Module2"
Option Explicit
'// Initial option
Public Const INIT_AUTO_CARD_ID = &H0           '// (Bit 0  CardId assigned by system, Input parameter of APS_initial( cardId, "MODE"
Public Const INIT_MANUAL_ID = &H1                  '// (Bit 0  CardId manual by dip switch, Input parameter of APS_initial( cardId, "MODE"
Public Const INIT_PARALLEL_FIXED = &H2             '// (Bit 1  Fixed axis indexing mode in Parallel type
Public Const INIT_SERIES_FIXED = &H4               '// (Bit 2  Fixed axis indexing mode in Series type
Public Const INIT_NOT_RESET_DO = &H8               '// (Bit 3  HSL Digital output not reset, (DO status will follow the slave status.
Public Const INIT_PARAM_IGNORE = &H0           '// (Bit 4-5  Load parameter method - ignore, keep current value
Public Const INIT_PARAM_LOAD_DEFAULT = &H10    '// (Bit 4-5  Load parameter method - load parameter as default value
Public Const INIT_PARAM_LOAD_FLASH = &H20      '// (Bit 4-5  Load parameter method - load parameter from flash memory
Public Const INIT_MNET_INTERRUPT = &H40           '// (Bit 6  Enable MNET interrupt mode. (Support motion interrupt for MotionNet series

'// Board parameter define (General
Public Const PRB_EMG_LOGIC = &H0          '// Board EMG logic

Public Const MHS_GET_SERVO_OFF_INFO = &H16
Public Const MHS_RESET_SERVO_OFF_INFO = &H17
Public Const MHS_GET_ALL_STATE = &H18

'//Only for PCI-8254/8, AMP-204/8C
Public Const SAMP_COM_POS_F64 = &H10                                           '// Command position
Public Const SAMP_FBK_POS_F64 = &H11                                           '// Feedback position
Public Const SAMP_CMD_VEL_F64 = &H12                                           '// Command velocity
Public Const SAMP_FBK_VEL_F64 = &H13                                           '// Feedback velocity
Public Const SAMP_CONTROL_VOL_F64 = &H14                               '// Control command voltage
Public Const SAMP_ERR_POS_F64 = &H15                                           '// Error position
Public Const SAMP_PWM_FREQUENCY_F64 = &H18               '// PWM frequency (Hz)
Public Const SAMP_PWM_DUTY_CYCLE_F64 = &H19            '// PWM duty cycle (%)
Public Const SAMP_PWM_WIDTH_F64 = &H1A                                 '// PWM width (ns)
Public Const SAMP_VAO_COMP_VEL_F64 = &H1B                      '// Composed velocity for Laser power control (pps)
Public Const SAMP_PTBUFF_COMP_VEL_F64 = &H1C           '// Composed velocity of point table
Public Const SAMP_PTBUFF_COMP_ACC_F64 = &H1D           '// Composed acceleration of point table

'Latch parameter number define. [Only for PCI-8158A]
Public Const LTC_ENC_IPT_MODE = &H0
Public Const LTC_ENC_EA_INV = &H1
Public Const LTC_ENC_EB_INV = &H2
Public Const LTC_ENC_EZ_CLR_LOGIC = &H3
Public Const LTC_ENC_EZ_CLR_EN = &H4
Public Const LTC_ENC_SIGNAL_FILITER_EN = &H5
Public Const LTC_FIFO_HIGH_LEVEL = &H6
Public Const LTC_SIGNAL_FILITER_EN = &H7
Public Const LTC_SIGNAL_TRIG_LOGIC = &H8

'Trigger parameter number define. [Only for PCI-8158A]
Public Const TIG_LCMP0_SRC = &H0
Public Const TIG_LCMP1_SRC = &H1
Public Const TIG_LCMP2_SRC = &H2
Public Const TIG_LCMP3_SRC = &H3
Public Const TIG_LCMP4_SRC = &H4
Public Const TIG_LCMP5_SRC = &H5
Public Const TIG_LCMP6_SRC = &H6
Public Const TIG_LCMP7_SRC = &H7
Public Const TIG_TCMP0_SRC = &H8
Public Const TIG_TCMP1_SRC = &H9
Public Const TIG_TCMP2_SRC = &HA
Public Const TIG_TCMP3_SRC = &HB
Public Const TIG_TCMP4_SRC = &HC
Public Const TIG_TCMP5_SRC = &HD
Public Const TIG_TCMP6_SRC = &HE
Public Const TIG_TCMP7_SRC = &HF
Public Const TIG_TRG0_EN = &H10
Public Const TIG_TRG1_EN = &H11
Public Const TIG_TRG2_EN = &H12
Public Const TIG_TRG3_EN = &H13
Public Const TIG_TRG4_EN = &H14
Public Const TIG_TRG5_EN = &H15
Public Const TIG_TRG6_EN = &H16
Public Const TIG_TRG7_EN = &H17
Public Const TIG_TRG0_SRC = &H18
Public Const TIG_TRG1_SRC = &H19
Public Const TIG_TRG2_SRC = &H1A
Public Const TIG_TRG3_SRC = &H1B
Public Const TIG_TRG4_SRC = &H1C
Public Const TIG_TRG5_SRC = &H1D
Public Const TIG_TRG6_SRC = &H1E
Public Const TIG_TRG7_SRC = &H1F
Public Const TIG_TRG0_PWD = &H20
Public Const TIG_TRG1_PWD = &H21
Public Const TIG_TRG2_PWD = &H20
Public Const TIG_TRG3_PWD = &H23
Public Const TIG_TRG4_PWD = &H24
Public Const TIG_TRG5_PWD = &H25
Public Const TIG_TRG6_PWD = &H26
Public Const TIG_TRG7_PWD = &H27
Public Const TIG_TRG0_LOGIC = &H28
Public Const TIG_TRG1_LOGIC = &H29
Public Const TIG_TRG2_LOGIC = &H2A
Public Const TIG_TRG3_LOGIC = &H2B
Public Const TIG_TRG4_LOGIC = &H2C
Public Const TIG_TRG5_LOGIC = &H2D
Public Const TIG_TRG6_LOGIC = &H2E
Public Const TIG_TRG7_LOGIC = &H2F
Public Const TIG_TRG0_TGL = &H30
Public Const TIG_TRG1_TGL = &H31
Public Const TIG_TRG2_TGL = &H32
Public Const TIG_TRG3_TGL = &H33
Public Const TIG_TRG4_TGL = &H34
Public Const TIG_TRG5_TGL = &H35
Public Const TIG_TRG6_TGL = &H36
Public Const TIG_TRG7_TGL = &H37
Public Const TIG_PWMTMR0_ITV = &H40
Public Const TIG_PWMTMR1_ITV = &H41
Public Const TIG_PWMTMR2_ITV = &H42
Public Const TIG_PWMTMR3_ITV = &H43
Public Const TIG_PWMTMR4_ITV = &H44
Public Const TIG_PWMTMR5_ITV = &H45
Public Const TIG_PWMTMR6_ITV = &H46
Public Const TIG_PWMTMR7_ITV = &H47
Public Const TIG_TMR0_ITV = &H50
Public Const TIG_TMR0_DIR = &H51

Public Const PRB_DO_LOGIC = &H14                        '//DO logic, 0: no invert; 1: invert
Public Const PRB_DI_LOGIC = &H15                        '//DI logic, 0: no invert; 1: invert

Public Const PRB_WDT0_VALUE = &H10        '// Set / Get watch dog limit.
Public Const PRB_WDT0_COUNTER = &H11      '// Reset Wdt / Get Wdt_Count_Value
Public Const PRB_WDT0_UNIT = &H12         '// wdt_unit
Public Const PRB_WDT0_ACTION = &H13       '// wdt_action

Public Const PRB_TMR0_BASE = &H20         '// Set TMR Value
Public Const PRB_TMR0_VALUE = &H21        '// Get timer int count value

Public Const PRB_SYS_TMP_MONITOR = &H30   '// Get system temperature monitor data
Public Const PRB_CPU_TMP_MONITOR = &H31   '// Get CPU temperature monitor data
Public Const PRB_AUX_TMP_MONITOR = &H32   '// Get AUX temperature monitor data

Public Const PRB_UART_MULTIPLIER = &H40   '// Set UART Multiplier

Public Const PRB_PSR_MODE = &H90          '// Config pulser mode
Public Const PRB_PSR_EA_LOGIC = &H91      '// Set EA inverted
Public Const PRB_PSR_EB_LOGIC = &H92      '// Set EB inverted

'// Board parameter define (For PCI-8253/56
Public Const PRB_DENOMINATOR = &H80       '// Floating number denominator
'//Public Const PRB_PSR_MODE      = &h90   '// Config pulser mode
Public Const PRB_PSR_ENABLE = &H91        '// Enable/disable pulser mode
Public Const PRB_BOOT_SETTING = &H100     '// Load motion parameter method when DSP boot

Public Const PRB_PWM0_MAP_DO = &H110       '// Enable & Map PWM0 to Do channels
Public Const PRB_PWM1_MAP_DO = &H111       '// Enable & Map PWM1 to Do channels
Public Const PRB_PWM2_MAP_DO = &H112       '// Enable & Map PWM2 to Do channels
Public Const PRB_PWM3_MAP_DO = &H113       '// Enable & Map PWM3 to Do channels

'// Board parameter define (For PCI-8392 SSCNET
Public Const PRB_SSC_APPLICATION = &H10000      '// Reserved
Public Const PRB_SSC_CYCLE_TIME = &H10000       '// SSCNET cycle time selection(vaild befor start sscnet
Public Const PRB_PARA_INIT_OPT = &H20           '// Initial boot mode.

'// Board parameter define (For DPAC
Public Const PRB_DPAC_DISPLAY_MODE = &H10001            '//DPAC Display mode
Public Const PRB_DPAC_DI_MODE = &H10002                 '//Set DI pin modes

Public Const PRB_DPAC_THERMAL_MONITOR_NO = &H20001      '//DPAC TEST
Public Const PRB_DPAC_THERMAL_MONITOR_VALUE = &H20002   '//DPAC TEST

'// Axis parameter define (General
Public Const PRA_EL_LOGIC = &H0           '// EL logic
Public Const PRA_ORG_LOGIC = &H1          '// ORG logic
Public Const PRA_EL_MODE = &H2            '// EL stop mode
Public Const PRA_MDM_CONDI = &H3          '// Motion done condition
Public Const PRA_EL_EXCHANGE = &H4        '// PEL, MEL exchange enable

Public Const PRA_ALM_LOGIC = &H4          '// ALM logic [PCI-8253/56 only]
Public Const PRA_ZSP_LOGIC = &H5          '// ZSP logic [PCI-8253/56 only]
Public Const PRA_EZ_LOGIC = &H6           '// EZ logic  [PCI-8253/56 only]
Public Const PRA_STP_DEC = &H7            '// Stop deceleration
Public Const PRA_SPEL_EN = &H8            '// SPEL Enable
Public Const PRA_SMEL_EN = &H9            '// SMEL Enable
Public Const PRA_EFB_POS0 = &HA           '// EFB position 0
Public Const PRA_EFB_POS1 = &HB           '// EFB position 1
Public Const PRA_EFB_CONDI0 = &HC         '// EFB position 0 condition
Public Const PRA_EFB_CONDI1 = &HD         '// EFB position 1 condition
Public Const PRA_EFB_SRC0 = &HE           '// EFB position 0 source
Public Const PRA_EFB_SRC1 = &HF           '// EFB position 1 source
Public Const PRA_HOME_MODE = &H10         '// home mode
Public Const PRA_HOME_DIR = &H11          '// homing direction
Public Const PRA_HOME_CURVE = &H12        '// homing curve parten(T or s curve
Public Const PRA_HOME_ACC = &H13          '// Acceleration deceleration rate
Public Const PRA_HOME_VS = &H14           '// homing start velocity
Public Const PRA_HOME_VM = &H15           '// homing max velocity
Public Const PRA_HOME_VA = &H16           '// homing approach velocity [PCI-8253/56 only]
Public Const PRA_HOME_SHIFT = &H17      '// The shift from ORG [PCI-8254/58 only]
Public Const PRA_HOME_EZA = &H18          '// EZ alignment enable
Public Const PRA_HOME_VO = &H19           '// Homing leave ORG velocity
Public Const PRA_HOME_OFFSET = &H1A      '// The escape pulse amounts(Leaving home by position
Public Const PRA_HOME_POS = &H1B              '// The position from ORG [PCI-8254/58 only]

Public Const PRA_CURVE = &H20             '// Move curve pattern
Public Const PRA_SF = &H20                '// Move s-factor
Public Const PRA_ACC = &H21               '// Move acceleration
Public Const PRA_DEC = &H22               '// Move deceleration
Public Const PRA_VS = &H23                '// Move start velocity
Public Const PRA_VM = &H24                '// Move max velocity
Public Const PRA_VE = &H25                '// Move end velocity
Public Const PRA_SACC = &H26              '// S curve acceleration
Public Const PRA_SDEC = &H27              '// S curve deceleration
Public Const PRA_ACC_SR = &H28            '// S curve ratio in acceleration( S curve with linear acceleration
Public Const PRA_DEC_SR = &H29            '// S curve ratio in deceleration( S curve with linear deceleration

Public Const PRA_PRE_EVENT_DIST = &H2A       '//Pre-event distance
Public Const PRA_POST_EVENT_DIST = &H2B      '//Post-event distance
'//following only for V2...
Public Const PRA_DIST = &H30              '// Move distance
Public Const PRA_MAX_VELOCITY = &H31      '// Maximum velocity
Public Const PRA_SCUR_PERCENTAGE = &H32   '// Scurve percentage
Public Const PRA_BLENDING_MODE = &H33     '// Blending mode
Public Const PRA_STOP_MODE = &H34         '// Stop mode
Public Const PRA_STOP_DELRATE = &H35      '// Stop function deceleration rate
'//================================================================================

Public Const PRA_PT_STOP_ENDO = &H32      '// Disable do when point table stopping.
Public Const PRA_PT_STOP_DO = &H33        '// Set do value when point table stopping.
Public Const PRA_PWM_OFF = &H34           '// Disable specified PWM output when ASTP input signal is active.
Public Const PRA_DO_OFF = &H35            '// Set DO value when ASTP input signal is active.

Public Const PRA_JG_MODE = &H40           '// Jog mode
Public Const PRA_JG_DIR = &H41            '// Jog move direction
Public Const PRA_JG_CURVE = &H42          '// Jog curve parten(T or s curve
Public Const PRA_JG_ACC = &H43            '// Jog move acceleration
Public Const PRA_JG_DEC = &H44            '// Jog move deceleration
Public Const PRA_JG_VM = &H45             '// Jog move max velocity
Public Const PRA_JG_STEP = &H46           '// Jog offset (For step mode
Public Const PRA_JG_DELAY = &H47          '// Jog delay (For step mode
Public Const PRA_JG_MAP_DI_EN = &H48       '// (I32  Enable Digital input map to jog command signal
Public Const PRA_JG_P_JOG_DI = &H49        '// (I32  Mapping configuration for positive jog and digital input.
Public Const PRA_JG_N_JOG_DI = &H4A        '// (I32  Mapping configuration for negative jog and digital input.
Public Const PRA_JG_JOG_DI = &H4B          '// (I32  Mapping configuration for jog and digital input.

Public Const PRA_MDN_DELAY = &H50         '// NSTP delay setting
Public Const PRA_SINP_WDW = &H51          '// Soft INP window setting
Public Const PRA_SINP_STBL = &H52         '// Soft INP stable cycle
Public Const PRA_SERVO_LOGIC = &H53      '//  SERVO logic

Public Const PRA_GEAR_MASTER = &H60         '// (I32  Select gearing master
Public Const PRA_GEAR_ENGAGE_RATE = &H61    '// (F64  Gear engage rate
Public Const PRA_GEAR_RATIO = &H62          '// (F64  Gear ratio
Public Const PRA_GANTRY_PROTECT_1 = &H63    '// (F64  E-gear gantry mode protection level 1
Public Const PRA_GANTRY_PROTECT_2 = &H64    '// (F64  E-gear gantry mode protection level 2

'// Axis parameter define (For PCI-8253/56
Public Const PRA_PLS_IPT_MODE = &H80      '// Pulse input mode setting
Public Const PRA_PLS_OPT_MODE = &H81      '// Pulse output mode setting
Public Const PRA_MAX_E_LIMIT = &H82       '// Maximum encoder count limit
Public Const PRA_ENC_FILTER = &H83        '// Encoder filter
Public Const PRA_EGEAR = &H84                           '// E-Gear ratio
Public Const PRA_ENCODER_DIR = &H85             '// Encoder direction
Public Const PRA_POS_UNIT_FACTOR = &H86      '// position unit factor setting

'Public Const _PRA_ENCODER_FILTER  = &H83  '// (I32
Public Const APS_PRA_ENCODER_FILTER = &H83   '// (I32
'//Public Const __8258_PRA_EGEAR         = &h84  '// 8253/6 use this para as unit factor, but 8258 use 0x86.

Public Const PRA_KP_GAIN = &H90           '// PID controller Kp gain
Public Const PRA_KI_GAIN = &H91           '// PID controller Ki gain
Public Const PRA_KD_GAIN = &H92           '// PID controller Kd gain
Public Const PRA_KFF_GAIN = &H93          '// Velocity feedforward Kff gain
Public Const PRA_KVGTY_GAIN = &H94        '// Gantry controller Kvgty gain
Public Const PRA_KPGTY_GAIN = &H95        '// Gantry controller Kpgty gain
Public Const PRA_IKP_GAIN = &H96          '// PID controller Kp gain in torque mode
Public Const PRA_IKI_GAIN = &H97          '// PID controller Ki gain in torque mode
Public Const PRA_IKD_GAIN = &H98          '// PID controller Kd gain in torque mode
Public Const PRA_IKFF_GAIN = &H99         '// Velocity feedforward Kff gain in torque mode
Public Const PRA_KAFF_GAIN = &H9A         '// Acceleration feedforward Kaff gain

'//following only for V2...
Public Const PRA_VOLTAGE_MAX = &H9B       '// Maximum output limit
Public Const PRA_VOLTAGE_MIN = &H9C       '// Minimum output limit
'//================================================================================

Public Const PRA_M_INTERFACE = &H100      '// Motion interface

Public Const PRA_M_VOL_RANGE = &H110      '// Motor voltage input range
Public Const PRA_M_MAX_SPEED = &H111      '// Motor maximum speed
Public Const PRA_M_ENC_RES = &H112        '// Motor encoder resolution

Public Const PRA_V_OFFSET = &H120         '// Voltage offset
Public Const PRA_DZ_LOW = &H121           '// Dead zone low side
Public Const PRA_DZ_UP = &H122            '// Dead zone up side
Public Const PRA_SAT_LIMIT = &H123        '// Voltage saturation output limit
Public Const PRA_ERR_C_LEVEL = &H124      '// Error counter check level
Public Const PRA_V_INVERSE = &H125        '// Output voltage inverse
Public Const PRA_DZ_VAL = &H126           '// Dead zone output value
Public Const PRA_IW_MAX = &H127           '// Integral windup maximum value
Public Const PRA_IW_MIN = &H128           '// Integral windup minimum value
Public Const PRA_BKL_DIST = &H129         '// Backlash distance
Public Const PRA_BKL_CNSP = &H12A         '// Backlash consumption
Public Const PRA_INTEGRAL_LIMIT = &H12B   '// (I32  Integral limit
Public Const PRA_D_SAMPLE_TIME = &H12C    '// (I32  Derivative Sample Time

Public Const PRA_PSR_LINK = &H130         '// Connect pulser number
Public Const PRA_PSR_RATIO = &H131        '// Set pulser ratio

Public Const PRA_BIQUAD0_A1 = &H132       '// (F64  Biquad filter0 coefficient A1
Public Const PRA_BIQUAD0_A2 = &H133       '// (F64  Biquad filter0 coefficient A2
Public Const PRA_BIQUAD0_B0 = &H134       '// (F64  Biquad filter0 coefficient B0
Public Const PRA_BIQUAD0_B1 = &H135       '// (F64  Biquad filter0 coefficient B1
Public Const PRA_BIQUAD0_B2 = &H136       '// (F64  Biquad filter0 coefficient B2
Public Const PRA_BIQUAD0_DIV = &H137      '// (F64  Biquad filter0 divider
Public Const PRA_BIQUAD1_A1 = &H138       '// (F64  Biquad filter1 coefficient A1
Public Const PRA_BIQUAD1_A2 = &H139       '// (F64  Biquad filter1 coefficient A2
Public Const PRA_BIQUAD1_B0 = &H13A       '// (F64  Biquad filter1 coefficient B0
Public Const PRA_BIQUAD1_B1 = &H13B       '// (F64  Biquad filter1 coefficient B1
Public Const PRA_BIQUAD1_B2 = &H13C       '// (F64  Biquad filter1 coefficient B2
Public Const PRA_BIQUAD1_DIV = &H13D      '// (F64  Biquad filter1 divider
Public Const PRA_FRIC_GAIN = &H13E            '// (F64) Friction voltage compensation


Public Const PRA_DA_TYPE = &H140          '// DAC output type
Public Const PRA_CONTROL_MODE = &H141     '// Closed loop control mode

'// Axis parameter define (For PCI-8154/58
'// Input/Output Mode
Public Const PRA_PLS_IPT_LOGIC = &H200    '//Reverse pulse input counting
Public Const PRA_FEEDBACK_SRC = &H201     '//Select feedback conter

'//IO Config
Public Const PRA_ALM_MODE = &H210         '//ALM Mode
Public Const PRA_INP_LOGIC = &H211        '//INP Logic
Public Const PRA_SD_EN = &H212            '//SD Enable -- Bit 8
Public Const PRA_SD_MODE = &H213          '//SD Mode
Public Const PRA_SD_LOGIC = &H214         '//SD Logic
Public Const PRA_SD_LATCH = &H215         '//SD Latch
Public Const PRA_ERC_MODE = &H216         '//ERC Mode
Public Const PRA_ERC_LOGIC = &H217        '//ERC logic
Public Const PRA_ERC_LEN = &H218          '//ERC pulse width
Public Const PRA_RESET_COUNTER = &H219    '//Reset counter when home move is complete
Public Const PRA_PLS_IPT_FLT = &H21B      '//EA/EB Filter Enable
Public Const PRA_INP_MODE = &H21C         '//INP Mode
Public Const PRA_LTC_LOGIC = &H21D        '//LTC LOGIC
Public Const PRA_COMPENSATION_PULSE = &H221   '//BACKLASH PULSE
Public Const PRA_COMPENSATION_MODE = &H222    '//BACKLASH MODE
Public Const PRA_LTC_SRC = &H223          '//LTC Source
Public Const PRA_LTC_DEST = &H224         '//LTC Destination
Public Const PRA_LTC_DATA = &H225         '//Get LTC DATA
Public Const PRA_GCMP_EN = &H226          '// CMP Enable
Public Const PRA_GCMP_POS = &H227         '// Get CMP position
Public Const PRA_GCMP_SRC = &H228         '// CMP source
Public Const PRA_GCMP_ACTION = &H229      '// CMP Action
Public Const PRA_GCMP_STS = &H22A         '// CMP Status
Public Const PRA_VIBSUP_RT = &H22B        '// Vibration Reverse Time
Public Const PRA_VIBSUP_FT = &H22C        '// Vibration Forward Time
Public Const PRA_LTC_DATA_SPD = &H22D     '// Choose latch data for current speed or error position

Public Const PRA_GPDO_SEL = &H230         '//Select DO/CMP Output mode
Public Const PRA_GPDI_SEL = &H231         '//Select DO/CMP Output mode
Public Const PRA_GPDI_LOGIC = &H232       '//Set gpio input logic
Public Const PRA_RDY_LOGIC = &H233        '//RDY logic

'//Fixed Speed
Public Const PRA_SPD_LIMIT = &H240        '// Set Fixed Speed
Public Const PRA_MAX_ACCDEC = &H241       '// Get max acceleration by fixed speed
Public Const PRA_MIN_ACCDEC = &H242       '// Get min acceleration by fixed speed
Public Const PRA_ENABLE_SPD = &H243       '// Disable/Enable Fixed Speed only for HSL-4XMO.

'//Continuous Move
Public Const PRA_CONTI_MODE = &H250       '// Continuous Mode
Public Const PRA_CONTI_BUFF = &H251       '// Continuous Buffer

'//Simultaneous Move
Public Const PRA_SYNC_STOP_MODE = &H260       '// Sync Mode

'// PCI-8144 axis parameter define
Public Const PRA_CMD_CNT_EN = &H10000
Public Const PRA_MIO_SEN = &H10001
Public Const PRA_START_STA = &H10002
Public Const PRA_SPEED_CHN = &H10003
Public Const PRA_ORG_STP = &H1A

'// Axis parameter define (For PCI-8392 SSCNET
Public Const PRA_SSC_SERVO_PARAM_SRC = &H10000      '//Servo parameter source
Public Const PRA_SSC_SERVO_ABS_POS_OPT = &H10001    '//Absolute position system option
Public Const PRA_SSC_SERVO_ABS_CYC_CNT = &H10002    '//Absolute cycle counter of servo driver
Public Const PRA_SSC_SERVO_ABS_RES_CNT = &H10003    '//Absolute resolution counter of servo driver
Public Const PRA_SSC_TORQUE_LIMIT_P = &H10004       '//Torque limit positive (0.1%
Public Const PRA_SSC_TORQUE_LIMIT_N = &H10005       '//Torque limit negative (0.1%
Public Const PRA_SSC_TORQUE_CTRL = &H10006          '//Torque control
Public Const PRA_SSC_RESOLUTION = &H10007           '//resolution (E-gear
Public Const PRA_SSC_GMR = &H10008                  '//resolution (New E-gear
Public Const PRA_SSC_GDR = &H10009                  '//resolution (New E-gear

'// Sampling parameter define
Public Const SAMP_PA_RATE = &H0         '//Sampling rate
Public Const SAMP_PA_EDGE = &H2         '//Edge select
Public Const SAMP_PA_LEVEL = &H3        '//Level select
Public Const SAMP_PA_TRIGCH = &H5       '//Select trigger channel
'//following only for V2
Public Const SAMP_PA_SEL = &H6
'//================================================================================

Public Const SAMP_PA_SRC_CH0 = &H10      '//Sample source of channel 0
Public Const SAMP_PA_SRC_CH1 = &H11      '//Sample source of channel 1
Public Const SAMP_PA_SRC_CH2 = &H12      '//Sample source of channel 2
Public Const SAMP_PA_SRC_CH3 = &H13      '//Sample source of channel 3

'// Sampling source
Public Const SAMP_AXIS_MASK = &HF00
Public Const SAMP_PARAM_MASK = &HFF
Public Const SAMP_COM_POS = &H0          '//command position
Public Const SAMP_FBK_POS = &H1          '//feedback position
Public Const SAMP_CMD_VEL = &H2          '//command velocity
Public Const SAMP_FBK_VEL = &H3          '//feedback velocity
Public Const SAMP_MIO = &H4              '//motion IO
Public Const SAMP_MSTS = &H5             '//motion status
Public Const SAMP_MSTS_ACC = &H6         '//motion status acc
Public Const SAMP_MSTS_MV = &H7          '//motion status at max velocity
Public Const SAMP_MSTS_DEC = &H8         '//motion status at dec
Public Const SAMP_MSTS_CSTP = &H9        '//motion status CSTP
Public Const SAMP_MSTS_NSTP = &HA        '//motion status NSTP
Public Const SAMP_MIO_INP = &HB          '//motion status INP
Public Const SAMP_MIO_ZERO = &HC         '//motion status ZERO
Public Const SAMP_MIO_ORG = &HD          '//motion status OGR

Public Const SAMP_SSC_MON_0 = &H10        '// SSCNET servo monitor ch0
Public Const SAMP_SSC_MON_1 = &H11        '// SSCNET servo monitor ch1
Public Const SAMP_SSC_MON_2 = &H12        '// SSCNET servo monitor ch2
Public Const SAMP_SSC_MON_3 = &H13        '// SSCNET servo monitor ch3

Public Const SAMP_CONTROL_VOL = &H20      '//
Public Const SAMP_GTY_DEVIATION = &H21
Public Const SAMP_ENCODER_RAW = &H22
Public Const SAMP_ERROR_COUNTER = &H23
Public Const SAMP_PTBUFF_RUN_INDEX = &H24 '//Point table running index

'//FieldBus parameter define
Public Const PRF_COMMUNICATION_TYPE = &H0       '// FiledBus Communication Type(Full/half duplex
Public Const PRF_TRANSFER_RATE = &H1            '// FiledBus Transfer Rate
Public Const PRF_HUB_NUMBER = &H2               '// FiledBus Hub Number
Public Const PRF_INITIAL_TYPE = &H3             '// FiledBus Initial Type(Clear/Reserve Do area
Public Const PRF_CHKERRCNT_LAYER = &H4          '// Set the check error count layer.

'//Gantry parameter number define [Only for PCI-8392, PCI-8253/56]
Public Const GANTRY_MODE = &H0
Public Const GENTRY_DEVIATION = &H1
Public Const GENTRY_DEVIATION_STP = &H2

'// Filter parameter number define [Only for PCI-8253/56]
Public Const FTR_TYPE_ST0 = &H0                       '// Station 0 filter type
Public Const FTR_FC_ST0 = &H1                         '// Station 0 filter cutoff frequency
Public Const FTR_BW_ST0 = &H2                         '// Station 0 filter bandwidth
Public Const FTR_ENABLE_ST0 = &H3                     '// Station 0 filter enable/disable
Public Const FTR_TYPE_ST1 = &H10                      '// Station 1 filter type
Public Const FTR_FC_ST1 = &H11                        '// Station 1 filter cutoff frequency
Public Const FTR_BW_ST1 = &H12                        '// Station 1 filter bandwidth
Public Const FTR_ENABLE_ST1 = &H13                    '// Station 1 filter enable/disable

'// Device name define
Public Const DEVICE_NAME_NULL = &HFFFF
Public Const DEVICE_NAME_PCI_8392 = (0)
Public Const DEVICE_NAME_PCI_825X = (1)
Public Const DEVICE_NAME_PCI_8154 = (2)
Public Const DEVICE_NAME_PCI_785X = (3)
Public Const DEVICE_NAME_PCI_8158 = (4)
Public Const DEVICE_NAME_PCI_7856 = (5)
Public Const DEVICE_NAME_ISA_DPAC1000 = (6)
Public Const DEVICE_NAME_ISA_DPAC3000 = (7)
Public Const DEVICE_NAME_PCI_8144 = (8)
Public Const DEVICE_NAME_PCI_8258 = (9)
Public Const DEVICE_NAME_PCI_8102 = (10)
Public Const DEVICE_NAME_PCI_V8258 = (11)
Public Const DEVICE_NAME_PCI_V8254 = (12)
Public Const DEVICE_NAME_PCI_8158A = (13)
Public Const DEVICE_NAME_AMP_82548 = (14)

'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'///
'//   HSL Slave module definition
'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'///
Public Const SLAVE_NAME_UNKNOWN = &H0
Public Const SLAVE_NAME_HSL_DI32 = &H100
Public Const SLAVE_NAME_HSL_DO32 = &H101
Public Const SLAVE_NAME_HSL_DI16DO16 = &H102
Public Const SLAVE_NAME_HSL_AO4 = &H103
Public Const SLAVE_NAME_HSL_AI16AO2_VV = &H104
Public Const SLAVE_NAME_HSL_AI16AO2_AV = &H105
Public Const SLAVE_NAME_HSL_DI16UL = &H106
Public Const SLAVE_NAME_HSL_DI16RO8 = &H107
Public Const SLAVE_NAME_HSL_4XMO = &H108
Public Const SLAVE_NAME_HSL_DI16_UCT = &H109
Public Const SLAVE_NAME_HSL_DO16_UCT = &H10A
Public Const SLAVE_NAME_HSL_DI8DO8 = &H10B
'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'///
'//   MNET Slave module definition
'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'///
Public Const SLAVE_NAME_MNET_1XMO = &H200
Public Const SLAVE_NAME_MNET_4XMO = &H201
Public Const SLAVE_NAME_MNET_4XMO_C = &H202



'//Trigger parameter number define. [Only for DB-8150]
'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//
Public Const TG_PWM0_PULSE_WIDTH = &H0
Public Const TG_PWM1_PULSE_WIDTH = &H1

Public Const TG_PWM0_MODE = &H2
Public Const TG_PWM1_MODE = &H3

Public Const TG_TIMER0_INTERVAL = &H4
Public Const TG_TIMER1_INTERVAL = &H5

Public Const TG_ENC0_CNT_DIR = &H6
Public Const TG_ENC1_CNT_DIR = &H7

Public Const TG_IPT0_MODE = &H8
Public Const TG_IPT1_MODE = &H9

Public Const TG_EZ0_CLEAR_EN = &HA
Public Const TG_EZ1_CLEAR_EN = &HB

Public Const TG_EZ0_CLEAR_LOGIC = &HC
Public Const TG_EZ1_CLEAR_LOGIC = &HD

Public Const TG_CNT0_SOURCE = &HE
Public Const TG_CNT1_SOURCE = &HF

Public Const TG_FTR0_EN = &H10
Public Const TG_FTR1_EN = &H11

Public Const TG_DI_LATCH0_EN = &H12
Public Const TG_DI_LATCH1_EN = &H13

Public Const TG_DI_LATCH0_EDGE = &H14
Public Const TG_DI_LATCH1_EDGE = &H15

Public Const TG_DI_LATCH0_VALUE = &H16
Public Const TG_DI_LATCH1_VALUE = &H17

Public Const TG_TRGOUT_MAP = &H18
Public Const TG_TRGOUT_LOGIC = &H19

Public Const TG_FIFO_LEVEL = &H1A

Public Const TG_PWM0_SOURCE = &H1B
Public Const TG_PWM1_SOURCE = &H1C
'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//'//

'//Trigger parameter number define. [Only for PCI-8253/56]
Public Const TG_LCMP0_SRC = &H0
Public Const TG_LCMP1_SRC = &H1
Public Const TG_TCMP0_SRC = &H2
Public Const TG_TCMP1_SRC = &H3
Public Const TG_LCMP0_EN = &H4
Public Const TG_LCMP1_EN = &H5
Public Const TG_TCMP0_EN = &H6
Public Const TG_TCMP1_EN = &H7
Public Const TG_TRG0_SRC = &H10
Public Const TG_TRG1_SRC = &H11
Public Const TG_TRG2_SRC = &H12
Public Const TG_TRG3_SRC = &H13
Public Const TG_TRG0_PWD = &H14
Public Const TG_TRG1_PWD = &H15
Public Const TG_TRG2_PWD = &H16
Public Const TG_TRG3_PWD = &H17
Public Const TG_TRG0_CFG = &H18      '//Also for HSL-4XMO
Public Const TG_TRG1_CFG = &H19      '//Also for HSL-4XMO
Public Const TG_TRG2_CFG = &H1A      '//Also for HSL-4XMO
Public Const TG_TRG3_CFG = &H1B      '//Also for HSL-4XMO

Public Const TMR_ITV = &H20
Public Const TMR_EN = &H21

'//Trigger parameter number define. [Only for MNET-4XMO-C & HSL-4XMO]
Public Const TG_CMP0_SRC = &H0
Public Const TG_CMP1_SRC = &H1
Public Const TG_CMP2_SRC = &H2
Public Const TG_CMP3_SRC = &H3

Public Const TG_CMP0_EN = &H4
Public Const TG_CMP1_EN = &H5
Public Const TG_CMP2_EN = &H6
Public Const TG_CMP3_EN = &H7

Public Const TG_CMP0_TYPE = &H8
Public Const TG_CMP1_TYPE = &H9
Public Const TG_CMP2_TYPE = &HA
Public Const TG_CMP3_TYPE = &HB

Public Const TG_CMPH_EN = &HC                '//Not for HSL-4XMO
Public Const TG_CMPH_DIR_EN = &HD            '//Not for HSL-4XMO
Public Const TG_CMPH_DIR = &HE               '//Not for HSL-4XMO

'//Public Const TG_TRG0_SRC           = &h10
'//Public Const TG_TRG1_SRC           = &h11
'//Public Const TG_TRG2_SRC           = &h12
'//Public Const TG_TRG3_SRC           = &h13

'//Public Const TG_TRG0_PWD           = &h14
'//Public Const TG_TRG1_PWD           = &h15
'//Public Const TG_TRG2_PWD           = &h16
'//Public Const TG_TRG3_PWD           = &h17

'//Public Const TG_TRG0_CFG           = &h18
'//Public Const TG_TRG1_CFG           = &h19
'//Public Const TG_TRG2_CFG           = &h1A
'//Public Const TG_TRG3_CFG           = &h1B

Public Const TG_ENCH_CFG = &H20              '//Not for HSL-4XMO

Public Const TG_TRG0_CMP_DIR = &H21          '//Only for HSL-4XMO
Public Const TG_TRG1_CMP_DIR = &H22          '//Only for HSL-4XMO
Public Const TG_TRG2_CMP_DIR = &H23          '//Only for HSL-4XMO
Public Const TG_TRG3_CMP_DIR = &H24          '//Only for HSL-4XMO

'//Trigger parameter number define. [Only for PCI-8258]
Public Const TGR_LCMP0_SRC = &H0
Public Const TGR_LCMP1_SRC = &H1
Public Const TGR_TCMP0_SRC = &H2
Public Const TGR_TCMP1_SRC = &H3

Public Const TGR_TCMP0_DIR = &H4
Public Const TGR_TCMP1_DIR = &H5
Public Const TGR_TRG_EN = &H6

Public Const TGR_TRG0_SRC = &H10
Public Const TGR_TRG1_SRC = &H11
Public Const TGR_TRG2_SRC = &H12
Public Const TGR_TRG3_SRC = &H13

Public Const TGR_TRG0_PWD = &H14
Public Const TGR_TRG1_PWD = &H15
Public Const TGR_TRG2_PWD = &H16
Public Const TGR_TRG3_PWD = &H17

Public Const TGR_TRG0_LOGIC = &H18
Public Const TGR_TRG1_LOGIC = &H19
Public Const TGR_TRG2_LOGIC = &H1A
Public Const TGR_TRG3_LOGIC = &H1B

Public Const TGR_TRG0_TGL = &H1C
Public Const TGR_TRG1_TGL = &H1D
Public Const TGR_TRG2_TGL = &H1E
Public Const TGR_TRG3_TGL = &H1F

Public Const TIMR_ITV = &H20
Public Const TIMR_DIR = &H21
Public Const TIMR_RING_EN = &H22
Public Const TIMR_EN = &H23

'// Motion IO status bit number define.
Public Const MIO_ALM = (0)             '// Servo alarm.
Public Const MIO_PEL = (1)             '// Positive end limit.
Public Const MIO_MEL = (2)             '// Negative end limit.
Public Const MIO_ORG = (3)             '// ORG (Home
Public Const MIO_EMG = (4)             '// Emergency stop
Public Const MIO_EZ = (5)              '// EZ.
Public Const MIO_INP = (6)             '// In position.
Public Const MIO_SVON = (7)            '// Servo on signal.
Public Const MIO_RDY = (8)             '// Ready.
Public Const MIO_WARN = (9)            '// Warning.
Public Const MIO_ZSP = (10)            '// Zero speed.
Public Const MIO_SPEL = (11)           '// Soft positive end limit.
Public Const MIO_SMEL = (12)           '// Soft negative end limit.
Public Const MIO_TLC = (13)            '// Torque is limited by torque limit value.
Public Const MIO_ABSL = (14)               '// Absolute position lost.
Public Const MIO_STA = (15)                '// External start signal.
Public Const MIO_PSD = (16)                '// Positive slow down signal
Public Const MIO_MSD = (17)                '// Negative slow down signal

  '// Motion status bit number define.
Public Const MTS_CSTP = (0)                    '// Command stop signal.
Public Const MTS_VM = (1)                      '// At maximum velocity.
Public Const MTS_ACC = (2)                     '// In acceleration.
Public Const MTS_DEC = (3)                     '// In deceleration.
Public Const MTS_DIR = (4)                     '//  = (Last Moving direction.
Public Const MTS_NSTP = (5)                    '// Normal stop = (Motion done .
Public Const MTS_HMV = (6)                     '// In home operation.
Public Const MTS_SMV = (7)                     '// Single axis move = ( relative, absolute, velocity move .
Public Const MTS_LIP = (8)                     '// Linear interpolation.
Public Const MTS_CIP = (9)                     '// Circular interpolation.
Public Const MTS_VS = (10)                     '// At start velocity.
Public Const MTS_PMV = (11)                    '// Point table move.
Public Const MTS_PDW = (12)                    '// Point table dwell move.
Public Const MTS_PPS = (13)                    '// Point table pause state.
Public Const MTS_SLV = (14)                    '// Slave axis move.
Public Const MTS_JOG = (15)                    '// Jog move.
Public Const MTS_ASTP = (16)                   '// Abnormal stop.
Public Const MTS_SVONS = (17)                  '// Servo off stopped.
Public Const MTS_EMGS = (18)                   '// EMG / SEMG stopped.
Public Const MTS_ALMS = (19)                   '// Alarm stop.
Public Const MTS_WANS = (20)                   '// Warning stopped.
Public Const MTS_PELS = (21)                   '// PEL stopped.
Public Const MTS_MELS = (22)                   '// MEL stopped.
Public Const MTS_ECES = (23)                   '// Error counter check level reaches and stopped.
Public Const MTS_SPELS = (24)                  '// Soft PEL stopped.
Public Const MTS_SMELS = (25)                  '// Soft MEL stopped.
Public Const MTS_STPOA = (26)                  '// Stop by others axes.
Public Const MTS_GDCES = (27)                  '// Gantry deviation error level reaches and stopped.
Public Const MTS_GTM = (28)                    '// Gantry mode turn on.
Public Const MTS_PAPB = (29)                   '// Pulsar mode turn on.
      '//Following definition for PCI-8254/8
Public Const MTS_MDN = (5)                    '// Motion done. 0: In motion, 1: Motion done  = ( It could be abnormal stop
Public Const MTS_WAIT = (10)                  '// Axis is in waiting state.  = ( Wait move trigger
Public Const MTS_PTB = (11)                    '// Axis is in point buffer moving.  = ( When this bit on, MDN and ASTP will be cleared
Public Const MTS_BLD = (17)                    '// Axis  = (Axes  in blending moving
Public Const MTS_PRED = (18)                  '// Pre-distance event, 1: event arrived. The event will be clear when axis start moving
Public Const MTS_POSTD = (19)                '// Post-distance event. 1: event arrived. The event will be clear when axis start moving
Public Const MTS_GER = (28)                    '// 1: In geared  = ( This axis as slave axis and it follow a master specified in axis parameter.

'// Motion IO status bit value define.
Public Const MIO_ALM_V = &H1              '// Servo alarm.
Public Const MIO_PEL_V = &H2              '// Positive end limit.
Public Const MIO_MEL_V = &H4              '// Negative end limit.
Public Const MIO_ORG_V = &H8              '// ORG (Home .
Public Const MIO_EMG_V = &H10             '// Emergency stop.
Public Const MIO_EZ_V = &H20              '// EZ.
Public Const MIO_INP_V = &H40             '// In position.
Public Const MIO_SVON_V = &H80            '// Servo on signal.
Public Const MIO_RDY_V = &H100            '// Ready.
Public Const MIO_WARN_V = &H200           '// Warning.
Public Const MIO_ZSP_V = &H400            '// Zero speed.
Public Const MIO_SPEL_V = &H800           '// Soft positive end limit.
Public Const MIO_SMEL_V = &H1000          '// Soft negative end limit.
Public Const MIO_TLC_V = &H2000           '// Torque is limited by torque limit value.
Public Const MIO_ABSL_V = &H4000          '// Absolute position lost.
Public Const MIO_STA_V = &H8000           '// External start signal.
Public Const MIO_PSD_V = &H10000          '// Positive slow down signal.
Public Const MIO_MSD_V = &H20000          '// Negative slow down signal.

'// Motion status bit value define.
Public Const MTS_CSTP_V = &H1                 '// Command stop signal.
Public Const MTS_VM_V = &H2                   '// At maximum velocity.
Public Const MTS_ACC_V = &H4                  '// In acceleration.
Public Const MTS_DEC_V = &H8                  '// In deceleration.
Public Const MTS_DIR_V = &H10                 '// (Last Moving direction.
Public Const MTS_NSTP_V = &H20                '// Normal stop(Motion done .
Public Const MTS_HMV_V = &H40                 '// In home operation.
Public Const MTS_SMV_V = &H80                 '// Single axis move( relative, absolute, velocity move .
Public Const MTS_LIP_V = &H100                '// Linear interpolation.
Public Const MTS_CIP_V = &H200                '// Circular interpolation.
Public Const MTS_VS_V = &H400                 '// At start velocity.
Public Const MTS_PMV_V = &H800                '// Point table move.
Public Const MTS_PDW_V = &H1000               '// Point table dwell move.
Public Const MTS_PPS_V = &H2000               '// Point table pause state.
Public Const MTS_SLV_V = &H4000               '// Slave axis move.
Public Const MTS_JOG_V = &H8000               '// Jog move.
Public Const MTS_ASTP_V = &H10000             '// Abnormal stop.
Public Const MTS_SVONS_V = &H20000            '// Servo off stopped.
Public Const MTS_EMGS_V = &H40000             '// EMG / SEMG stopped.
Public Const MTS_ALMS_V = &H80000             '// Alarm stop.
Public Const MTS_WANS_V = &H100000            '// Warning stopped.
Public Const MTS_PELS_V = &H200000            '// PEL stopped.
Public Const MTS_MELS_V = &H400000            '// MEL stopped.
Public Const MTS_ECES_V = &H800000            '// Error counter check level reaches and stopped.
Public Const MTS_SPELS_V = &H1000000          '// Soft PEL stopped.
Public Const MTS_SMELS_V = &H2000000          '// Soft MEL stopped.
Public Const MTS_STPOA_V = &H4000000          '// Stop by others axes.
Public Const MTS_GDCES_V = &H8000000          '// Gantry deviation error level reaches and stopped.
Public Const MTS_GTM_V = &H10000000           '// Gantry mode turn on.
Public Const MTS_PAPB_V = &H20000000          '// Pulsar mode turn on.

'// PointTable, option
'//
Public Const PT_OPT_ABS = &H0                 '// move, absolute
Public Const PT_OPT_REL = &H1                 '// move, relative
Public Const PT_OPT_LINEAR = &H0              '// move, linear
Public Const PT_OPT_ARC = &H4                 '// move, arc
Public Const PT_OPT_FC_CSTP = &H0             '// signal, command stop (finish condition
Public Const PT_OPT_FC_INP = &H10             '// signal, in position
Public Const PT_OPT_LAST_POS = &H20           '// last point index
Public Const PT_OPT_DWELL = &H40              '// dwell
Public Const PT_OPT_RAPID = &H80              '// rapid positioning
Public Const PT_OPT_NOARC = &H10000           '// do not add arc

Public Const PT_OPT_SCUVE = &H2               '// s-curve

'// move option define
Public Const OPT_ABSOLUTE = &H0
Public Const OPT_RELATIVE = &H1
Public Const OPT_WAIT = &H100

'// PTP buffer mode define
Public Const PTP_OPT_ABORTING = &H0
Public Const PTP_OPT_BUFFERED = &H1000
Public Const PTP_OPT_BLEND_LOW = &H2000
Public Const PTP_OPT_BLEND_PREVIOUS = &H3000
Public Const PTP_OPT_BLEND_NEXT = &H4000
Public Const PTP_OPT_BLEND_HIGH = &H5000

Public Const ITP_OPT_ABORT_BLEND = &H0
Public Const ITP_OPT_ABORT_FORCE = &H1000
Public Const ITP_OPT_ABORT_STOP = &H2000
Public Const ITP_OPT_BUFFERED = &H3000
Public Const ITP_OPT_BLEND_DEC_EVENT = &H4000
Public Const ITP_OPT_BLEND_RES_DIST = &H5000
Public Const ITP_OPT_BLEND_RES_DIST_PERCENT = &H6000
