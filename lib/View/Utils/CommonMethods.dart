import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<File> compressImage(File imageFile) async {
  const int maxSizeBytes = 1*512*512; // 5MB
  List<int> bytes = await imageFile.readAsBytes();
  // Convert the bytes list to Uint8List
  Uint8List? result = Uint8List.fromList(bytes);
  // Uint8List? result = await FlutterImageCompress.compressWithFile(
  //   imageFile.absolute.path,
  //   // quality: 90, // Adjust quality as needed
  //   // minWidth: 800, // Minimum width
  //   // minHeight: 600, // Minimum height
  //   format: CompressFormat.jpeg, // Output format
  // );
  if (result!=null && result.lengthInBytes > maxSizeBytes) {
    // If the compressed image is still larger than the maximum size, adjust the quality
    result = await FlutterImageCompress.compressWithFile(
      imageFile.absolute.path,
      quality: 50, // Reduce quality further
      minWidth: 800,
      minHeight: 600,
      format: CompressFormat.jpeg,
    );
    print("heavy image...");
  }
  File file = File('${imageFile.path}');
  return await file.writeAsBytes(result!);
}