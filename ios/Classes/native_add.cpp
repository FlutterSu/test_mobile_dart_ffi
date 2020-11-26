#include <stdint.h>
#include "struct.h"

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t x, int32_t y) {
    return x + y;
}

struct MyStruct native_input_buffer;
struct MyStruct native_output_buffer;

extern "C" __attribute__((visibility("default"))) __attribute__((used))
MyStruct native_redouble_buffer() {
    native_output_buffer.array = new uint8_t[native_input_buffer.len];

    for (int i = 0; i < native_input_buffer.len; i++) {
       native_output_buffer.array[i] = native_input_buffer.array[i] * 2;
    }

    native_output_buffer.len = native_input_buffer.len;

    return native_output_buffer;
}