import 'package:b2b_app/Models/Product.dart';
import 'package:b2b_app/Models/Seller.dart';
import 'package:b2b_app/Models/User.dart';
import 'package:b2b_app/Pages/cart_page.dart';
import 'package:b2b_app/Pages/category_list.dart';
import 'package:b2b_app/Pages/chat_page.dart';
import 'package:b2b_app/Pages/home_page.dart';
import 'package:b2b_app/Pages/loading_page.dart';
import 'package:b2b_app/Pages/login_page.dart';
import 'package:b2b_app/Pages/notification_page.dart';
import 'package:b2b_app/Pages/profile_page.dart';
import 'package:b2b_app/Pages/sell_on_app_1.dart';
import 'package:b2b_app/Pages/sell_on_app_2.dart';
import 'package:b2b_app/Pages/shortlist_page.dart';
import 'package:b2b_app/Shared/app_style.dart';
import 'package:b2b_app/Widgets/drawer.dart';
import 'package:b2b_app/locator.dart';
import 'package:fancy_bottom_bar/fancy_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

//draggable floating action button
void main() {
  setupLocator();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(
          create: (context) => User(),
        ),
        ChangeNotifierProvider<Seller>(
          create: (context) => Seller(),
        ),
        ChangeNotifierProvider<ProductStore>(
          create: (context) => ProductStore(),
        ),
      ],
      child: DynamicTheme(
        defaultBrightness: Brightness.dark,
        data: (brightness) =>
        new ThemeData(
          primarySwatch: Colors.cyan,
          brightness: brightness,
        ),
        themedWidgetBuilder: (context, theme) =>
            MaterialApp(

              routes: {
                '/chats': (context) => ChatPage(),
                '/home': (context) => HomePage(),
                '/login': (context) => LoginPage(),
                '/notif': (context) => NotifPage(),
                '/scaffold': (context) => MyAppScaffold(),
                '/loading': (context) => LoadingPage(),
                '/wishlist': (context) => WishPage(),
                '/profile': (context) => ProfilePage(),
                '/category': (context) => CategoryListPage(),
                '/cart': (context) => CartPage(),
                '/sellcategory': (context) => SellCategoryPage(),
                '/sellform': (context) => SellOnAppForm(),
              },
              title: 'B2B App',
              debugShowCheckedModeBanner: false,
              theme: theme
              ,
              home: LoginPage(),
        ),
      ),
    );
  }
}

class MyAppScaffold extends StatefulWidget {
  @override
  _MyAppScaffoldState createState() => _MyAppScaffoldState();
}

class _MyAppScaffoldState extends State<MyAppScaffold> {
  int currentNavTab = 0;
  List<Widget> pages = [HomePage(), ChatPage(), WishView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xffffe0b2),
        resizeToAvoidBottomPadding: true,
        bottomNavigationBar: FancyBottomBar(
          height: 50,
          selectedPosition: currentNavTab,
          indicatorColor: Colors.red,
          selectedColor: Colors.amber,
          onItemSelected: (index) {
            setState(() {
              currentNavTab = index;
            });
          },
          items: [
            FancyBottomItem(title: Text('Home'), icon: Icon(Icons.home)),
            FancyBottomItem(title: Text('Chats'), icon: Icon(Icons.chat)),
            FancyBottomItem(
                title: Text('Shortlist'),
                icon: Icon(Icons.format_list_numbered)),
            FancyBottomItem(
                title: Text('My Profile'), icon: Icon(Icons.account_circle))
          ],
        ),
        drawer:

        NavDrawer(),
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                margin: EdgeInsets.only(top: 0, bottom: 10),
                padding: EdgeInsets.only(left: 7, right: 7),
                child: CupertinoTextField(
                  suffix: Transform.scale(
                      scale: 0.85,
                      child: RaisedButton(
                        color: Colors.blue,
                        onPressed: () {},
                        child: Text('Search'),
                      )),
                  suffixMode: OverlayVisibilityMode.editing,
                  focusNode: FocusNode(canRequestFocus: false),
                  cursorColor: Colors.red,
                  placeholderStyle: AppStyle.subtitleStyle1,
                  placeholder: 'Search for products, sellers, and more',
                  prefix: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 50,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.green,
                      )),
                ),
              ),
              preferredSize: Size.fromHeight(60)),
          actions: <Widget>[

            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/notif');
                },
                icon: Icon(Icons.notifications)),
            IconButton(onPressed: () {
              Navigator.pushNamed(context, '/cart');
            }, icon: Icon(Icons.add_shopping_cart)),
          ],
          title: Text('B2B'),
        ),
        body: pages[currentNavTab],
      ),
    );
  }
}
