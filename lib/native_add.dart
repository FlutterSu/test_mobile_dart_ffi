import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:ffi_helper/ffi_helper.dart';

// x + y
final DynamicLibrary nativeAddLib =
    Platform.isAndroid ? DynamicLibrary.open("libnative_add.so") : DynamicLibrary.process();

final int Function(int x, int y) nativeAdd =
    nativeAddLib.lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add").asFunction();

class MyStruct extends Struct {
  @Int32()
  int len;
  Pointer<Uint8> array;

  factory MyStruct.allocate(int len, List<int> array) => allocate<MyStruct>().ref
    ..array = Uint8Array.fromUint8(Uint8List.fromList(array)).ptr
    ..len = len;
}

typedef get_array_func = Pointer<MyStruct> Function();

class Redouble {
  static final inputBuffer = nativeAddLib.lookup<MyStruct>('native_input_buffer');
  static final outputBuffer = nativeAddLib.lookup<MyStruct>('native_output_buffer');

  static final getArrayPointer =
      nativeAddLib.lookup<NativeFunction<get_array_func>>('native_redouble_buffer').asFunction<get_array_func>();

  static List<int> ListValue(List<int> list) {
    inputBuffer.ref.len = list.length;
    inputBuffer.ref.array = Uint8Array.fromUint8(Uint8List.fromList(list)).ptr;

    getArrayPointer();

    print(outputBuffer.ref.len);
    print(outputBuffer.ref.array.asTypedList(outputBuffer.ref.len));

    return outputBuffer.ref.array.asTypedList(outputBuffer.ref.len);
  }
}
