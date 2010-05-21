/*
                    The HumbleHacker Keyboard Project
                 Copyright � 2008-2010, David Whetstone
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

#ifndef __BOUND_KEY_H__
#define __BOUND_KEY_H__

#include <stdbool.h>
#include "binding.h"

enum {DEACTIVATED=((uint8_t)-1)};

typedef struct
{
  Cell              cell;
  const KeyBinding *binding;
} BoundKey;

extern bool BoundKey__is_active(BoundKey *key);
extern void BoundKey__deactivate(BoundKey *key);
extern void BoundKey__update_binding(BoundKey *key, Modifiers mods, KeyMap keymap);

#endif // __BOUND_KEY_H__
