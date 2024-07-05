import 'package:ealaa_userr/View/Store/OrderSuccess.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';

class WebViewStore extends StatefulWidget {
  String url = '';
  WebViewStore({super.key,required this.url});

  @override
  State<WebViewStore> createState() => _WebViewStoreState();
}

class _WebViewStoreState extends State<WebViewStore> {
  WebViewController webController = WebViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: webController),
    );
  }

  @override
  void initState() {
    print("widget url is..........${widget.url}");
    super.initState();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) async {
            print("url::::::::::::::::::::::::::::${url}");
            print("successsss url is....${baseUrl}success");
            print("successsss url is....${baseUrl}");
            print('...............${url.contains(
                '${baseUrl}success')}')   ;
            if (url.contains(
                '${baseUrl}success')) {
              print("successsss url is....${baseUrl}success");
              showSnackbar(context, "payment successful");
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute
                (builder: (context) => OrderSuccess(),), (route)
              => false);
            } else if (url.contains(
                '${baseUrl}cancel')) {
              print("cancelll url is....${baseUrl}cancel");
              showSnackbar(context, "You cancelled the payment");
              Navigator.pop(context);

            } else {
              showSnackbar(context, "not supporting data");
              print("Other");
            }
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.url)) {
              print("launch url is....${widget.url}") ;
              return NavigationDecision.prevent;
            }
            print("launch url1 is....${widget.url}") ;
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }
}
