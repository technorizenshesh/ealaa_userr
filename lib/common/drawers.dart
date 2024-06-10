import '../import_ealaa_user.dart';
import 'common_widgets.dart';

/// OpenFilterDrawer ....
Widget filterDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.white,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(top: 40, bottom: 20),
          child: const Text('Filter',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange)),
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'Category',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.orangeAccent,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text(
                    'Type',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.orangeAccent,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text(
                    'City',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.orangeAccent,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text(
                    'Show english Ads only',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.orangeAccent,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text(
                    'Real Estate Agent',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.orangeAccent,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text(
                    'Amenties',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.orangeAccent,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text(
                    'Listed By',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.orangeAccent,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                CommonWidget.commonElevatedButton(
                    onPressed: () {},
                    context: context,
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    buttonMargin:
                    const EdgeInsets.only(left: 10, right: 10, top: 10))
              ],
            ),
          ),
        )
      ],
    ),
  );
}

/// OpenShortDrawer ....
Widget shortDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.white,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(top: 40, bottom: 20),
          child: const Text('Sort',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange)),
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'Listed By',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.orangeAccent,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                CommonWidget.commonElevatedButton(
                    onPressed: () {},
                    context: context,
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    buttonMargin:
                    const EdgeInsets.only(left: 10, right: 10, top: 10))
              ],
            ),
          ),
        )
      ],
    ),
  );
}