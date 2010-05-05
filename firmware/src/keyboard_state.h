/*
                    The HumbleHacker Keyboard Project
                    Copyright � 2008, David Whetstone
               david DOT whetstone AT humblehacker DOT com

This file is a part of The HumbleHacker Keyboard Project.  

The HumbleHacker Keyboard Project is free software: you can redistribute 
it and/or modify it under the terms of the GNU General Public License as 
published by the Free Software Foundation, either version 3 of the 
License, or (at your option) any later version.  

The HumbleHacker Keyboard Project is distributed in the hope that it will 
be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General 
Public License for more details.  

You should have received a copy of the GNU General Public License along 
with The HumbleHacker Keyboard Project.  If not, see 
<http://www.gnu.org/licenses/>.  

*/

#ifndef __KEYBOARD_STATE_H__
#define __KEYBOARD_STATE_H__

#include "ModeKeys.h"
#include "Macros.h"

#define NUM_MODIFIERS 8
#define MAX_KEYS      6
#define MAX_ACTIVE_CELLS (MAX_KEYS + NUM_MODE_KEYS + NUM_MODIFIERS)

typedef struct
{
  uint8_t modifiers;
  uint8_t mode_keys;
  uint8_t keys[MAX_KEYS];
  uint8_t num_keys;
  Cell active_cells[MAX_ACTIVE_CELLS];
  uint8_t num_active_cells;
  uint16_t consumer_key;
  const Macro * macro;
  uint8_t macro_key_index;
  uint8_t pre_macro_modifiers;
  uint8_t error_roll_over;
} KeyboardState;

extern KeyboardState *g_current_kb_state;
extern uint8_t g_num_blocked_keys;
extern uint8_t g_blocked_keys[MAX_ACTIVE_CELLS];

void keyboard_state__init(void);
void keyboard_state__reset_current_state(void);
void keyboard_state__reset_blocked_keys(void);
void keyboard_state__swap_states(void);

uint8_t   keyboard_state__has_changed(void);
uint8_t   keyboard_state__cooked_keys_have_changed(void);
uint8_t   keyboard_state__mode_keys_have_changed(void);
uint8_t   keyboard_state__is_error(void);
uint8_t   keyboard_state__is_empty(void);
uint8_t   keyboard_state__is_processing_macro(void);
uint8_t   keyboard_state__key_is_blocked(uint8_t key);
uint8_t   keyboard_state__should_send_empty_consumer_key(void);

#endif // __KEYBOARD_STATE_H__