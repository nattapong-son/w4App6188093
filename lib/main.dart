import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
/*App Home*/
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeWork_MobileApp',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lightBlue,
          accentColor: Colors.cyan,
      ),
      home:GameShop(),
    );
  }
}
/*-----------------------------------------------------------*/
class GameShop extends StatefulWidget {
  @override
  _GameShopState createState() => _GameShopState();
}
/*Main Page*/
class _GameShopState extends State<GameShop>{
  List<productInfo> cart = [];
  int sum = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('GameShop'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: 'GamesList',),
                Tab(text: 'Summary',),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              //calcualte prices
              GameList((chooseGame) {
                setState(() {
                  cart.add(chooseGame);
                  sum = 0;
                  cart.forEach((item) {
                    sum = sum + item.cost;
                 });
                });
             }),
              Summary(cart, sum),
           ],
         ),
        ),
    );
  }
}

/*-----------------------------------------------------------*/
/*Game List class*/
class GameList extends StatelessWidget {
  final ValueSetter<productInfo> _valueSetter;
  GameList(this._valueSetter);

  List<productInfo> items = [
    productInfo(image: "assets/images/ac.jpg", name: 'Animal Crossing', cost: 1650),
    productInfo(image: "assets/images/na.jpg", name: 'Nier: Automata', cost: 2450),
    productInfo(image: "assets/images/cv.jpg", name: 'Code;Vein', cost: 1650),
    productInfo(image: "assets/images/gta.jpg", name: 'GTA5', cost: 650),
    productInfo(image: "assets/images/mhw.png", name: 'Monster Hunter: World', cost: 1650),
    productInfo(image: "assets/images/zd.jpg", name: 'The Legend of Zelda', cost: 1650),
    productInfo(image: "assets/images/ff.jpg", name: 'FFVII', cost: 1450),
    productInfo(image: "assets/images/ov.jpg", name: 'Overwatch', cost: 1250),
    productInfo(image: "assets/images/ps.png", name: 'Persona5', cost: 1650),
    productInfo(image: "assets/images/re.jpg", name: 'Resident Evil2', cost: 1650)
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
        itemBuilder: (context, index){
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(items[index].image),
            ),
            title: Text(items[index].name),
            trailing: Text(
              '\฿${items[index].cost}',
              style: TextStyle(
                  color: Colors.deepOrange,fontSize: 20,
                  fontWeight: FontWeight.bold),),
            onTap: (){
              _valueSetter(items[index]);
            },
          );
    },
    separatorBuilder: (context, index){
          return Divider();
    },
    itemCount: items.length
    );
  }
}
/*-----------------------------------------------------------*/
/*Set data value*/
class productInfo {
  String image, name;
  int cost;

  productInfo({this.image, this.name, this.cost});
}
/*-----------------------------------------------------------*/

/*Summary*/
class Summary extends StatelessWidget{
  final cart;
  final sum;

  Summary(this.cart, this.sum);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListView.separated(
          itemBuilder: (context,index){
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(cart[index].image),
            ),
            title: Text(cart[index].name),
            trailing: Text('\฿${cart[index].cost}',
              style: TextStyle(color: Colors.blueAccent,
                  fontSize: 20, fontWeight: FontWeight.bold),),
            onTap: (){

            },
          );
        },
        separatorBuilder: (context, index){
          return Divider();
        },
          itemCount: cart.length,
          shrinkWrap: true,
        ),
        Divider(),
        Text('Total: \฿$sum'),
      ],
    );
  }
}

