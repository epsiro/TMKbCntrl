/*
                The HumbleHacker Keyboard Firmware Project
                   Copyright � 2008, David Whetstone
              david DOT whetstone AT humblehacker DOT com

  This file is a part of the HumbleHacker Keyboard Firmware project.

  The HumbleHacker Keyboard Firmware project is free software: you can
  redistribute it and/or modify it under the terms of the GNU General
  Public License as published by the Free Software Foundation, either
  version 3 of the License, or (at your option) any later version.

  The HumbleHacker Keyboard Firmware project is distributed in the
  hope that it will be useful, but WITHOUT ANY WARRANTY; without even
  the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  PURPOSE.  See the GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with The HumbleHacker Keyboard Firmware project.  If not, see
  <http://www.gnu.org/licenses/>.

  --------------------------------------------------------------------

  This code is based on the keyboard demonstration application by
  Denver Gingerich.

  Copyright 2008  Denver Gingerich (denver [at] ossguy [dot] com)

  --------------------------------------------------------------------

  Gingerich's keyboard demonstration application is based on the MyUSB
  Mouse demonstration application, written by Dean Camera.

             LUFA Library
     Copyright (C) Dean Camera, 2010.

  dean [at] fourwalledcubicle [dot] com
      www.fourwalledcubicle.com
  --------------------------------------------------------------------
*/

/** \file
 *
 *  Main source file for the Keyboard demo. This file contains the main tasks of the demo and
 *  is responsible for the initial application hardware configuration.
 */

#include <assert.h>
#include "Keyboard.h"
#include "keymaps.h"
#include "mapping.c"
#include "keyboard_state.h"
#include "kb_leds.h"

typedef enum
{
  NONE  = 0,
  L_CTL = (1<<0),
  L_SHF = (1<<1),
  L_ALT = (1<<2),
  L_GUI = (1<<3),
  R_CTL = (1<<4),
  R_SHF = (1<<5),
  R_ALT = (1<<6),
  R_GUI = (1<<7),
} ModKey;

/** Buffer to hold the previously generated Keyboard HID report, for comparison purposes inside the HID class driver. */
uint8_t PrevKeyboardHIDReportBuffer[sizeof(USB_KeyboardReport_Data_t)];

/** LUFA HID Class driver interface configuration and state information. This structure is
 *  passed to all HID Class driver functions, so that multiple instances of the same class
 *  within a device can be differentiated from one another.
 */
USB_ClassInfo_HID_Device_t Keyboard_HID_Interface =
 	{
		.Config =
			{
				.InterfaceNumber              = 0,

				.ReportINEndpointNumber       = KEYBOARD_EPNUM,
				.ReportINEndpointSize         = KEYBOARD_EPSIZE,
				.ReportINEndpointDoubleBank   = false,

				.PrevReportINBuffer           = PrevKeyboardHIDReportBuffer,
				.PrevReportINBufferSize       = sizeof(PrevKeyboardHIDReportBuffer),
			},
    };

uint8_t g_num_lock, g_caps_lock, g_scrl_lock;

/* Local Variables */

// TODO: Generate this value or get rid of it
#define NUM_MODE_KEYS 8

/* each row contains data for 3 Ports */
static KeyMap s_saved_map;
static KeyMap s_current_kb_map;
static KeyMap s_active_mode_kb_map;
//static KeyMap s_prev_kb_map[NUM_MODE_KEYS];
static uint32_t s_row_data[NUM_ROWS];             // Keep
static uint16_t s_timeout;
// static uint8_t s_idleDuration[3];

// -- EEPROM Data --
//static KeyMap  EEMEM ee_persistent_map;

/* Local functions */
static     void get_active_cells(void);
static     void scan_matrix(void);
static     bool momentary_mode_engaged(void);
static     bool modifier_keys_engaged(void);
static     void check_mode_toggle(void);
static     void process_mode_keys(void);
static     void process_keys(void);
static     void fill_report(USB_KeyboardReport_Data_t* report);
static     void push_temporary_mode(KeyMap mode_map);
static    Usage map_get_usage(Mapping *map, uint8_t cell);
static     void maybe_pop_temporary_mode(void);
static   ModKey get_modifier(Usage usage);
// static     void process_consumer_control_endpoint(void);
static const Mapping* get_mapping(Modifiers modifiers, Cell cell, KeyMap keymap);

/** Main program entry point. This routine contains the overall program flow, including initial
 *  setup of all components and the main program loop.
 */
int main(void)
{
	SetupHardware();

//LEDs_SetAllLEDs(LEDMASK_USB_NOTREADY);

	for (;;)
	{
		HID_Device_USBTask(&Keyboard_HID_Interface);
		USB_USBTask();
	}
}

/** Configures the board hardware and chip peripherals for the demo's functionality. */
void SetupHardware()
{
	/* Disable watchdog if enabled by bootloader/fuses */
	MCUSR &= ~(1 << WDRF);
	wdt_disable();

	/* Disable clock division */
	clock_prescale_set(clock_div_1);

	/* Hardware Initialization */
	USB_Init();

  /* Task init */
  init_cols();
  init_leds();
  keyboard_state__init();

  g_num_lock           = g_caps_lock = g_scrl_lock = 0;
  s_active_mode_kb_map = NULL;
  s_current_kb_map     = (KeyMap) pgm_read_word(&kbd_map_mx_default);
  s_timeout            = 500;

  led_on(LED_NUM);

#if defined(BOOTLOADER_TEST)
  uint8_t bootloader = eeprom_read_byte(&ee_bootloader);
  if (bootloader == 0xff) // eeprom has been reset
  {
    eeprom_write_byte(&ee_bootloader, FALSE);
  }
  else if (bootloader == TRUE)
  {
    asm("jmp 0xF000");
  }
#endif
}

/** Event handler for the library USB Connection event. */
void EVENT_USB_Device_Connect(void)
{
//LEDs_SetAllLEDs(LEDMASK_USB_ENUMERATING);
}

/** Event handler for the library USB Disconnection event. */
void EVENT_USB_Device_Disconnect(void)
{
//LEDs_SetAllLEDs(LEDMASK_USB_NOTREADY);
}

/** Event handler for the library USB Configuration Changed event. */
void EVENT_USB_Device_ConfigurationChanged(void)
{
//LEDs_SetAllLEDs(LEDMASK_USB_READY);

	if (!(HID_Device_ConfigureEndpoints(&Keyboard_HID_Interface)))
    ;
//  LEDs_SetAllLEDs(LEDMASK_USB_ERROR);

	USB_Device_EnableSOFEvents();
}

/** Event handler for the library USB Unhandled Control Request event. */
void EVENT_USB_Device_UnhandledControlRequest(void)
{
	HID_Device_ProcessControlRequest(&Keyboard_HID_Interface);
}

/** Event handler for the USB device Start Of Frame event. */
void EVENT_USB_Device_StartOfFrame(void)
{
	HID_Device_MillisecondElapsed(&Keyboard_HID_Interface);
}

/** HID class driver callback function for the creation of HID reports to the host.
 *
 *  \param[in] HIDInterfaceInfo  Pointer to the HID class interface configuration structure being referenced
 *  \param[in,out] ReportID  Report ID requested by the host if non-zero, otherwise callback should set to the generated report ID
 *  \param[in] ReportType  Type of the report to create, either REPORT_ITEM_TYPE_In or REPORT_ITEM_TYPE_Feature
 *  \param[out] ReportData  Pointer to a buffer where the created report should be stored
 *  \param[out] ReportSize  Number of bytes written in the report (or zero if no report is to be sent
 *
 *  \return Boolean true to force the sending of the report, false to let the library determine if it needs to be sent
 */
bool CALLBACK_HID_Device_CreateHIDReport(USB_ClassInfo_HID_Device_t* const HIDInterfaceInfo, uint8_t* const ReportID,
                                         const uint8_t ReportType, void* ReportData, uint16_t* ReportSize)
{
  keyboard_state__reset_current_state();
  scan_matrix();
	get_active_cells();

  if (!keyboard_state__is_error())
  {
    s_active_mode_kb_map = s_current_kb_map;
    g_current_kb_state->modifiers.all = 0;
    loop:
    if (momentary_mode_engaged())
      goto loop;
    if (modifier_keys_engaged())
      goto loop;
    check_mode_toggle();
    process_keys();
    maybe_pop_temporary_mode();
  }
	USB_KeyboardReport_Data_t* KeyboardReport = (USB_KeyboardReport_Data_t*)ReportData;
  fill_report(KeyboardReport);
  *ReportSize = sizeof(USB_KeyboardReport_Data_t);

  // if processing macro, don't swap states until macro is complete
  if (!keyboard_state__is_processing_macro())
    keyboard_state__swap_states();

	return false;
}

/** HID class driver callback function for the processing of HID reports from the host.
 *
 *  \param[in] HIDInterfaceInfo  Pointer to the HID class interface configuration structure being referenced
 *  \param[in] ReportID  Report ID of the received report from the host
 *  \param[in] ReportData  Pointer to a buffer where the created report has been stored
 *  \param[in] ReportSize  Size in bytes of the received HID report
 */
void CALLBACK_HID_Device_ProcessHIDReport(USB_ClassInfo_HID_Device_t* const HIDInterfaceInfo, const uint8_t ReportID,
                                          const void* ReportData, const uint16_t ReportSize)
{
  uint8_t* LEDReport = (uint8_t*)ReportData;

	g_num_lock  = (*LEDReport & (1<<0));
	g_caps_lock = (*LEDReport & (1<<1));
	g_scrl_lock = (*LEDReport & (1<<2));

	led_set(LED_CAPS, g_caps_lock);
	led_set(LED_SCRL, g_scrl_lock);
  led_set(LED_NUM,  g_num_lock);
}

#if 0
static
void
process_keyboard_endpoint(void)
{
	Endpoint_SelectEndpoint(KEYBOARD_EPNUM);
	if (!Endpoint_ReadWriteAllowed())
		return;

  get_keyboard_state();

  // check for changes
  uint8_t changed = keyboard_state__has_changed();

  // only send data if changed or timeout has occured
  if (changed == TRUE || s_timeout == 0)
  {
    s_timeout = 500; // milliseconds

    // prevents empty timeout reports from being sent.
    if (changed || !keyboard_state__is_empty())
    {
      if (!keyboard_state__is_error())
      {
        s_active_mode_kb_map = s_current_kb_map;
        process_mode_keys();
        process_keys();
      }
      send_keys();
    }

    // if processing macro, don't swap states until macro is complete
    if (changed == TRUE && keyboard_state__is_processing_macro() == FALSE )
      keyboard_state__swap_states();
  }
}
#endif

static
void
scan_matrix()
{
  for (uint8_t row = 0; row < NUM_ROWS; ++row)
  {
    activate_row(row);

    // Insert NOPs for synchronization
    micro_pause(20);

    // Place data on all column pins for active row into a single
    // 32 bit value.
    s_row_data[row] = read_cols();
  }
}

static
void
get_active_cells()
{
  uint8_t row, col;
  uint8_t irow, ncols;
  // now process row/column data to get raw keypresses
  for (row = 0; row < NUM_ROWS; ++row)
  {
    ncols = 0;
    for (col = 0; col < NUM_COLS; ++col)
    {
      if (s_row_data[row] & (1UL << col))
      {
        if (g_current_kb_state->num_active_cells > MAX_ACTIVE_CELLS)
        {
          g_current_kb_state->error_roll_over = TRUE;
          return;
        }
        ++ncols;
        g_current_kb_state->active_cells[g_current_kb_state->num_active_cells++] = MATRIX_CELL(row, col);
      }
    }

    // if 2 or more keys pressed in a row, check for ghost-key
    if (ncols > 1)
    {
      for (irow = 0; irow < NUM_ROWS; ++irow)
      {
        if (irow == row)
          continue;

        // if any other row has a key pressed in the same column as any
        // of the two or more keys pressed in the current row, we have a
        // ghost-key condition.
        if (s_row_data[row] & s_row_data[irow])
        {
          g_current_kb_state->error_roll_over = TRUE;
          return;
        }
      }
    }
  }
}

static
const Mapping *
get_mapping(Modifiers modifiers, Cell cell, KeyMap keymap)
{
  return NULL;
  const Mapping **mappings = (const Mapping**)pgm_read_word(keymap + cell);
  if (!mappings)
    return NULL;
  int i = 0;
  while (mappings[i])
  {
    if (mappings[i]->premods.all == modifiers.all)
      return mappings[i];
  }
  return NULL;
}

static
void
push_temporary_mode(KeyMap mode_map)
{
  s_saved_map = s_active_mode_kb_map;
  s_active_mode_kb_map = mode_map;
}

static
void
maybe_pop_temporary_mode(void)
{
  if (s_saved_map)
  {
    s_active_mode_kb_map = s_saved_map;
    s_saved_map = NULL;
  }
}

bool
momentary_mode_engaged()
{
  Cell active_cell;
  int i;
  for (i = 0; i < g_current_kb_state->num_active_cells; ++i)
  {
    active_cell = g_current_kb_state->active_cells[i];
    if (active_cell != DEACTIVATED)
      continue;
    const Mapping *mapping = get_mapping(g_current_kb_state->modifiers, active_cell, s_active_mode_kb_map);
    if (mapping->kind == MODE)
    {
      ModeMapping *mode_mapping = (ModeMapping*)mapping;
      if (mode_mapping->type == MOMENTARY)
      {
        push_temporary_mode(mode_mapping->mode_map);
        g_current_kb_state->active_cells[i] = DEACTIVATED;
        return true;
      }
    }
  }
  return false;
}

bool
modifier_keys_engaged()
{
  Cell active_cell;
  int i;
  for (i = 0; i < g_current_kb_state->num_active_cells; ++i)
  {
    active_cell = g_current_kb_state->active_cells[i];
    if (active_cell != DEACTIVATED)
      continue;
    const Mapping *mapping = get_mapping(g_current_kb_state->modifiers, active_cell, s_active_mode_kb_map);
    if (mapping->kind == MAP)
    {
      const MapMapping *map_mapping = (const MapMapping*)mapping;
      ModKey this_modifier = 0;
      if ((this_modifier = get_modifier(map_mapping->usage)) != 0)
      {
        g_current_kb_state->modifiers.all |= this_modifier;
        g_current_kb_state->active_cells[i] = DEACTIVATED;
      }
    }
  }
  return g_current_kb_state->modifiers.all != 0;
}

static
void
check_mode_toggle(void)
{
}

static
void
process_mode_keys()
{
#if 0
  g_current_kb_state->mode_keys = 0;

  // First, check if any of the momentary-type mode keys are down
  ModeKey modeKey;
  Usage usage;
  uint8_t i, mode;
  for (i = 0; i < g_current_kb_state->num_active_cells; ++i)
  {
    for (mode = 0; mode < NUM_MODE_KEYS; ++mode)
    {
      memcpy_P(&modeKey,&(modeKeys[mode]),sizeof(ModeKey));
      if (modeKey.type != MOMENTARY)
        continue;

      usage = map_get_usage(s_current_kb_map, modeKey.cell);

      if (USAGE_PAGE(usage) == HID_USAGE_PAGE_CUSTOM
       && USAGE_ID(usage) == mode
       && g_current_kb_state->active_cells[i] == modeKey.cell)
      {
        g_current_kb_state->mode_keys |= (1<<mode);
        s_active_mode_kb_map = modeKey.selecting_map;
        // TODO: modeKeys[i].leds
        break;
      }
    }
  }

  // Now, process toggle-type mode keys
  for (i = 0; i < g_current_kb_state->num_active_cells; ++i)
  {
    for (mode = 0; mode < NUM_MODE_KEYS; ++mode)
    {
      memcpy_P(&modeKey,&(modeKeys[mode]),sizeof(ModeKey));
      if (modeKey.type != TOGGLE)
        continue;

      usage = map_get_usage(s_active_mode_kb_map, modeKey.cell);

      if (USAGE_PAGE(usage) == HID_USAGE_PAGE_CUSTOM
       && USAGE_ID(usage) == mode
       && g_current_kb_state->active_cells[i] == modeKey.cell)
      {
        g_current_kb_state->mode_keys |= (1<<mode);

        // if the current map is the same as the mode key's map,
        // set the current map back to the default, otherwise,
        // set the current map to the mode key's map.

        if (s_current_kb_map == modeKey.selecting_map)
        {
          s_current_kb_map = s_prev_kb_map[mode];
          eeprom_write_byte(&ee_persistent_map, MODE_KEY_NONE);
          // TODO: LEDs
        }
        else
        {
          s_prev_kb_map[mode] = s_current_kb_map;
          s_current_kb_map = modeKey.selecting_map;
          eeprom_write_byte(&ee_persistent_map, mode);
          // TODO: LEDs
        }
        break;
      }
    }
  }
#endif
}


static
void
process_keys()
{
#if 0
  uint8_t i, modifier;
  uint8_t num_blocked_keys = 0;
  Cell raw_key;
  Usage usage;
  UsagePage usage_page;
  for (i=0; i < g_current_kb_state->num_active_cells; ++i)
  {
    if (g_current_kb_state->num_keys > MAX_KEYS)
    {
      g_current_kb_state->error_roll_over = TRUE;
      break;
    }

    raw_key = g_current_kb_state->active_cells[i];

    if (keyboard_state__mode_keys_have_changed())
    {
      g_blocked_keys[num_blocked_keys++] = raw_key;
      continue;
    }

    usage = map_get_usage(s_active_mode_kb_map, raw_key);

    modifier = get_modifier(usage);
    if (modifier)
    {
      g_current_kb_state->modifiers |= modifier;
    }
    else
    {
      if (keyboard_state__key_is_blocked(raw_key))
        continue;

      usage_page = USAGE_PAGE(usage);

      if (usage_page == HID_USAGE_PAGE_KEYBOARD_AND_KEYPAD)
      {
        g_current_kb_state->keys[g_current_kb_state->num_keys] = USAGE_ID(usage);
        ++g_current_kb_state->num_keys;
        continue;
      }

      if (usage_page == HID_USAGE_PAGE_CONSUMER_CONTROL)
      {
        if (g_current_kb_state->consumer_key)
        {
          g_current_kb_state->error_roll_over = TRUE;
          break;
        }
        g_current_kb_state->consumer_key = USAGE_ID(usage);
        continue;
      }

      if (usage_page == HID_USAGE_PAGE_MACRO)
      {
        g_current_kb_state->macro = (const Macro *)pgm_read_word(&p_macros[USAGE_ID(usage)]);
        g_current_kb_state->pre_macro_modifiers = g_current_kb_state->modifiers;
        continue;
      }

      if (usage == HID_USAGE_CUSTOM)
        continue;
    }
  }
  if (keyboard_state__mode_keys_have_changed())
    g_num_blocked_keys = num_blocked_keys;
#endif
}

#if 0
static
void
send_keys(void)
{
	Endpoint_SelectEndpoint(KEYBOARD_EPNUM);
	while(!Endpoint_ReadWriteAllowed());

  uint8_t key;

  if (keyboard_state__is_error())
  {
    Endpoint_Write_Byte(g_current_kb_state->modifiers); // Byte0: Modifiers still reported
    Endpoint_Write_Byte(0);                // Byte1: Reserved
    for (key = 1; key < 7; ++key)
      Endpoint_Write_Byte(USAGE_ID(HID_USAGE_KEYBOARD_ERRORROLLOVER));
		Endpoint_ClearCurrentBank();
    return;
  }

  if (!keyboard_state__is_processing_macro())
  {
    if (keyboard_state__cooked_keys_have_changed())
    {
      Endpoint_Write_Byte(g_current_kb_state->modifiers); // Byte0: Modifier
      Endpoint_Write_Byte(0);                // Byte1: Reserved

      for (key = 0; key < g_current_kb_state->num_keys; ++key)
      {
        Endpoint_Write_Byte(g_current_kb_state->keys[key]);
      }
      for (; key < 7; ++key)
      {
        Endpoint_Write_Byte(0);
      }
			Endpoint_ClearCurrentBank();
    }
  }
  else
  {
    const Macro * macro = g_current_kb_state->macro;
    MacroKey mkey;
    mkey.mod.all = pgm_read_byte(&macro->keys[g_current_kb_state->macro_key_index].mod);
    mkey.usage = pgm_read_word(&macro->keys[g_current_kb_state->macro_key_index].usage);
    uint8_t num_macro_keys = pgm_read_byte(&macro->num_keys);
    Endpoint_Write_Byte(g_current_kb_state->pre_macro_modifiers | mkey.mod.all);
    Endpoint_Write_Byte(0);
    Endpoint_Write_Byte(USAGE_ID(mkey.usage));
    for (key = 2; key < 7; ++key)
      Endpoint_Write_Byte(0);
		Endpoint_ClearCurrentBank();
    g_current_kb_state->macro_key_index++;
    if (g_current_kb_state->macro_key_index >= num_macro_keys)
    {
      g_current_kb_state->macro = NULL;
      g_current_kb_state->macro_key_index = 0;
    }
    return;
  }

#ifdef LEDS_DONE
  if (g_current_kb_state->num_keys)
    led_on(LED_GRN_1);
  else
    led_off(LED_GRN_1);
#endif
}
#endif

static
void
fill_report(USB_KeyboardReport_Data_t* report)
{
  uint8_t key;

  if (keyboard_state__is_error())
  {
    report->Modifier = g_current_kb_state->modifiers.all;
    for (key = 1; key < 7; ++key)
      report->KeyCode[key] = USAGE_ID(HID_USAGE_ERRORROLLOVER);
    return;
  }

  if (!keyboard_state__is_processing_macro())
  {
    report->Modifier = g_current_kb_state->modifiers.all;

    for (key = 0; key < g_current_kb_state->num_keys; ++key)
      report->KeyCode[key] = g_current_kb_state->keys[key];
  }
  else
  {
#if 0
    const Macro * macro = g_current_kb_state->macro;
    MacroKey mkey;
    mkey.mod.all = pgm_read_byte(&macro->keys[g_current_kb_state->macro_key_index].mod);
    mkey.usage = pgm_read_word(&macro->keys[g_current_kb_state->macro_key_index].usage);
    uint8_t num_macro_keys = pgm_read_byte(&macro->num_keys);
    report->Modifier = g_current_kb_state->pre_macro_modifiers | mkey.mod.all;
    report->KeyCode[0] = USAGE_ID(mkey.usage);
    g_current_kb_state->macro_key_index++;
    if (g_current_kb_state->macro_key_index >= num_macro_keys)
    {
      g_current_kb_state->macro = NULL;
      g_current_kb_state->macro_key_index = 0;
    }
    return;
#endif
  }
}

static
inline
Usage
map_get_usage(Mapping *map, uint8_t cell)
{
  return pgm_read_word(map + cell);
}

static
ModKey
get_modifier(Usage usage)
{
  switch(usage)
  {
  case HID_USAGE_LEFTCONTROL:
    return L_CTL;
  case HID_USAGE_LEFTSHIFT:
    return L_SHF;
  case HID_USAGE_LEFTALT:
    return L_ALT;
  case HID_USAGE_LEFT_GUI:
    return L_GUI;
  case HID_USAGE_RIGHTCONTROL:
    return R_CTL;
  case HID_USAGE_RIGHTSHIFT:
    return R_SHF;
  case HID_USAGE_RIGHTALT:
    return R_ALT;
  case HID_USAGE_RIGHT_GUI:
    return R_GUI;
  default:
    return 0;
  }
}


