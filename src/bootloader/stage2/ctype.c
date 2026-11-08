#pragma once
#include "stdint.h"

bool Islower(char chr) { return chr >= 'a' && chr <= 'z'; }

char Toupper(char chr) {
  if (Islower(chr))
    return chr - ('a' - 'A');

  return chr;
}
