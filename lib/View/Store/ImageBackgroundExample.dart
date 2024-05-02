import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageBackgroundExample extends StatefulWidget {
  final String imageUrl;

  ImageBackgroundExample({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _ImageBackgroundExampleState createState() => _ImageBackgroundExampleState();
}

class _ImageBackgroundExampleState extends State<ImageBackgroundExample> {
  PaletteGenerator? _paletteGenerator;

  @override
  void initState() {
    super.initState();
    _generatePalette();
  }

  Future<void> _generatePalette() async {
    final PaletteGenerator paletteGenerator =
    await PaletteGenerator.fromImageProvider(CachedNetworkImageProvider(widget.imageUrl));
    setState(() {
      _paletteGenerator = paletteGenerator;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Background Example'),
      ),
      body: _paletteGenerator != null && _paletteGenerator!.dominantColor != null
          ? Container(
        color: _paletteGenerator!.dominantColor!.color.withOpacity(0.2),
        child: Center(
          child: Text(
            'Dynamic Background Color',
            style: TextStyle(color: _paletteGenerator!.dominantColor!.titleTextColor),
          ),
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
