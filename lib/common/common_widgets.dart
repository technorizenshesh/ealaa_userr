import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

class CommonWidget {
  ///For Full Size Use In Column Not In ROW
  static Widget commonElevatedButton({
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? splashColor,
    bool wantContentSizeButton = false,
    Color? buttonColor,
    TextStyle? textStyle,
    double? elevation,
    required VoidCallback onPressed,
    required BuildContext context,
    Widget? child,
    Widget? childText,
    Decoration? decoration,
    BoxBorder? border,
  }) {
    return Container(
      height: wantContentSizeButton ? height : 60,
      width: wantContentSizeButton ? width : double.infinity,
      margin: buttonMargin,
      decoration: decoration ??
          BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(borderRadius ?? 14),
          ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 0,
          padding: contentPadding,
          textStyle: textStyle ??
              Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 14),
          ),
          backgroundColor: buttonColor ?? Colors.orange,
          foregroundColor:
              splashColor ?? Theme.of(context).scaffoldBackgroundColor,
          shadowColor: Colors.transparent,
        ),
        child: child ?? const Text(''),
      ),
    );
  }

  static imageView({
    double? width,
    double? height,
    double? radius,
    required String image,
    String? defaultNetworkImage,
    BoxFit? fit,
    BorderRadiusGeometry? borderRadius,
  }) {
    return SizedBox(
      height: height ?? 64,
      width: width ?? double.infinity,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 8),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: fit ?? BoxFit.cover,
          errorWidget: (context, error, stackTrace) {
            return Container(
              height: height ?? 64,
              width: width ?? double.infinity,
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(.2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius ?? 8),
                child: Icon(Icons.error, color: Theme.of(context).primaryColor),
              ),
            );
          },
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return SizedBox(
              height: height ?? 64,
              width: width ?? double.infinity,
              child: Shimmer.fromColors(
                baseColor:
                    Theme.of(context).colorScheme.onSecondary.withOpacity(.4),
                highlightColor: Theme.of(context).colorScheme.onSecondary,
                child: Container(
                  color:
                      Theme.of(context).colorScheme.onSecondary.withOpacity(.4),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static Widget dataNotFound() {
    return Center(
      child: Image.asset(MyImages.MyAccount),
    );
  }

  static Widget appIcons(
      {required String assetName,
      double? width,
      double? height,
      double? borderRadius,
      Color? color,
      BoxFit? fit}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 4),
      child: Image.asset(
        assetName,
        height: height ?? 24,
        width: width ?? 24,
        color: color,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            height: height ?? 24,
            width: width ?? 24,
          );
        },
      ),
    );
  }

  ///For Simmer for loading time
  static Widget commonShimmer({
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? buttonColor,
    int itemCount = 1,
    bool enabled = true,
    required Widget shimmerWidget,
    //required Widget child
  }) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white,
        enabled: enabled,
        child: SizedBox(
          height: height,
          width: width,
        ));
  }

// static void showMyToastMessage(String message) {
//   Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       textColor: primaryColor,
//       backgroundColor: primary3Color,
//       fontSize: 16.0);
// }
//
// static Widget customProgressBar(
//     {required bool inAsyncCall,
//     double? width,
//     Widget? child,
//     double? height}) {
//   return Container(
//     height: height ?? double.infinity,
//     width: width ?? double.infinity,
//     alignment: Alignment.center,
//     decoration: BoxDecoration(
//       color: inAsyncCall ? Colors.grey.withOpacity(0.5) : primary3Color,
//     ),
//     child: inAsyncCall
//         ? Stack(
//             alignment: Alignment.center,
//             children: [
//               const CircularProgressIndicator(
//                 color: primary3Color,
//               ),
//               appIcons(
//                   assetName: IconConstants.icLogo,
//                   width: 25,
//                   height: 25,
//                   fit: BoxFit.fill)
//             ],
//           )
//         : child ?? const SizedBox(),
//   );
// }
}

enum ErrorAnimationType { shake, clear }


commonTextFormField(
    {required String hintText,
      int? maxLines = 1,
      GestureTapCallback? onTap,
      bool readOnly = false,
      double? width,
      double? height,
      bool suffixIcon = false,
      TextEditingController? controller}) {
  return Container(
    width: width,
    height: height,
    child: TextFormField(
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      cursorColor: Colors.orange,
      //cursorHeight: 16,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        suffixIcon: suffixIcon
            ? const Icon(CupertinoIcons.arrowtriangle_down_circle,
            color: Colors.orange)
            : null,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          color: Colors.black54,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Colors.orange,
            width: 1,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
    ),
  );
}
