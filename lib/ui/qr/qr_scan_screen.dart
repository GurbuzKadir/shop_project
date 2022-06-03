import 'dart:async';
import 'dart:io';

import 'package:eshop/ui/qr/product/Products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:eshop/ui/home/view/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

List<Products> urunler = [];
bool isLoading=false;

final Map<String, String> urunlerMap = {};

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness: Brightness.dark));
  runApp(const TaraApp());
}
class TaraApp extends StatefulWidget {
  const TaraApp({Key key}) : super(key: key);

  @override
  _TaraAppState createState() => _TaraAppState();
}

class _TaraAppState extends State<TaraApp> {
  // burası sıfırlanacak
  static String _scanBarcode = '-1';


  // burada mağazalar listeleniyor
  Widget Deger() {
    if (_scanBarcode.toString() == "" || _scanBarcode.toString() == "-1") {
      return Text('Sonuç : $_scanBarcode\n',
        style: TextStyle(
            fontSize: 20,
            color: Colors.grey.withOpacity(0)
        ),
      );
    }
    return Padding(padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 40,
          child: ElevatedButton.icon(
            icon: const Icon(
              Icons.local_grocery_store,
              color: Colors.white,
              size: 25,
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              shadowColor: Colors.deepOrange,
              elevation: 15,
              primary: const Color(0xFFF49838),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              ),
            ),
            onPressed: () {
              getProductDetail();//burası kaldırılacak
              /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductList(),
                    /*settings: RouteSettings(
                      arguments: urunler,
                    )*/
                ),
              );*/
            }, //burası değişecek
            label: Text(
              'Mağazaları listele',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)
              ),

            ),
          ),
        )
    );
  }

  // burada ürün bilgisi alanı yükleniyor
  Widget DegerIsimGetir() {
    if (_scanBarcode.toString() == "" || _scanBarcode.toString() == "-1") {
      return Text('Sonuç : $_scanBarcode',
        style: TextStyle(
            fontSize: 20,
            color: Colors.grey.withOpacity(0)
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 0, top: 10, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(

            //mainAxisAlignment : MainAxisAlignment.start,
              child:
              Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Barkod : $_scanBarcode',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Text('Ürün : $data',
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),

                ],
              )

          )
        ],
      ),
    );
  }

  final snackBar = SnackBar(
    content: const Text('Ürün bulunamadı!'),
    action: SnackBarAction(
      label: 'Kapat',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  var data;
  var urunDurum;


  Future getProductDetail() async {
    var res = await http.get(
        Uri.parse('https://www.barkodoku.com/$_scanBarcode'));
    final body = res.body;
    final document = parser.parse(body);
    var response = document
        .getElementsByClassName("col-xs-12 col-sm-6 col-md-12")[1]
        .getElementsByClassName("search-result row")[0]
        .getElementsByClassName("col-xs-24 col-sm-24 col-md-9 excerpet")[0];
    //.forEach((element) {
    setState(() {
      data = response.children[0].text.toString();
    });
    print(data);
    if (data == '' || data == "Barkod Detayları") {
      urunDurum = 'yok';
      print('ürün yok');
    }
    else {
      urunDurum = 'var';
      print('ürün var');

      getMarketDetail();
    }
    //});
  }

  // burada akakçeden veriler alınacak
  Future getMarketDetail() async {
    if(_scanBarcode!="-1"){
      setState(() {
        isLoading=true;
      });
      var urunAdi = data.toString().replaceAll(' ', '+');
      var res = await http.get(
          Uri.parse('https://www.akakce.com/arama/?q=$urunAdi'));
      urunler.clear();
      var resim_v="";
      var isim_v="";
      var fiyat_v="";
      var link_v="";
      final body = res.body;
      final document = parser.parse(body);
      var response = document
          .getElementById("APL")
          .getElementsByTagName("li")
          .forEach((element) {

        /*todo resim*/

        if(element.children[0].children[0].children[0].attributes['data-src'].toString().substring(0,2)=='//'){
          resim_v=element
              .children[0].children[0].children[0].attributes['data-src']
              .toString();

        }
        else{
          resim_v=element
              .children[0].children[0].children[0].attributes['src']
              .toString();
        }

        /*todo isim*/

        isim_v=element
            .children[0].children[0].firstChild.attributes['alt']
            .toString();

        /*todo fiyat*/

        try {
          fiyat_v=element
              .children[0].children[1].children[1].text
              .toString();
        } catch(e) {
          fiyat_v=element
              .children[0].children[2].children[1].text
              .toString();
        }

        /*todo link*/

        if(element
            .children[0].children[1].children[0].attributes['href']
            .toString()!='null'){
          link_v='https://www.akakce.com'+element
              .children[0].children[1].children[0].attributes['href']
              .toString();
        }
        else{
          link_v='null';
        }

        urunler.add(
          Products(
              resim:resim_v,
              isim:isim_v,
              fiyat:fiyat_v.replaceAll('TL', 'TL '),
              link:link_v
          ),
        );
      });
      for(int i =0;i<urunler.length;i++){
        print('---------------------------------------');
        print('resim : '+urunler[i].resim.toString());
        print('isim : '+urunler[i].isim.toString());
        print('fiyat : '+urunler[i].fiyat.toString());
        print('link : '+urunler[i].link.toString());
      }
      print('https://www.akakce.com/arama/?q=$urunAdi');
      if(_scanBarcode!="-1"){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductList(),
            /*settings: RouteSettings(
                      arguments: urunler,
                    )*/
          ),
        );
      }
      setState(() {
        isLoading=false;
      });
    }
  }


  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'İptal', true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'İptal', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Platform sürümü alınamadı.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      getProductDetail();
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'İptal', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Platform sürümü alınamadı.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      getProductDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

            primarySwatch: Colors.indigo,
            primaryTextTheme: const TextTheme(
                headline3: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,

                )
            )
        ),
        home: Scaffold(
            body: Builder(builder: (BuildContext context) {
              return Container(

                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/bg.png'),
                  ),
                ),
                child: Container(
                    alignment: Alignment.center,
                    child: Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          /// Logo alanı

                          const SizedBox(height: 30.0,),

                          /// Resim alanı
                          Container(
                            height: 200.0,
                            width: 200.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/scanner.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),

                          /// Nasıl kullanılır alanı
                          const SizedBox(height: 10,),
                          SizedBox(
                            height: 15.0,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black87
                              ),
                              child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  FadeAnimatedText('1. Adım'),
                                  FadeAnimatedText('2. Adım'),
                                  FadeAnimatedText('3. Adım'),
                                  FadeAnimatedText('4. Adım'),
                                ],
                                onTap: () {
                                  print("Tap Event");
                                },
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20.0,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                              child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  FadeAnimatedText('Barkod/QR Tara'),
                                  FadeAnimatedText('Marketleri listele'),
                                  FadeAnimatedText('Market seçimi yap'),
                                  FadeAnimatedText('Ürünleri listele'),
                                ],
                                onTap: () {
                                  print("Tap Event");
                                },
                              ),
                            ),
                          ),

                          /// Tarama butonları alanı
                          Padding(padding: const EdgeInsets.only(
                              bottom: 0, top: 20, right: 20, left: 20),
                              child: SizedBox(
                                height: 40,
                                child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.crop_free,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    shadowColor: Colors.indigo,
                                    elevation: 15,
                                    primary: const Color(0xFF7D60FB),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12)
                                    ),
                                  ),
                                  onPressed: () => scanBarcodeNormal(),
                                  label: Text(
                                    'Barkod Tara!',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400)
                                    ),

                                  ),
                                ),
                              )
                          ),
                          Padding(padding: const EdgeInsets.all(20.0),
                              child: SizedBox(
                                height: 40,
                                child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.qr_code,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    shadowColor: Colors.indigo,
                                    elevation: 15,
                                    primary: const Color(0xFF7D60FB),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12)
                                    ),
                                  ),
                                  onPressed: () => scanQR(),
                                  label: Text(
                                    'QR Kod Tara!',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400)
                                    ),

                                  ),
                                ),
                              )
                          ),

                          /// Ürün bilgileri alanı
                          DegerIsimGetir(),

                          /// Mağaza listeleme alanı
                          Deger(),

                        ])),
              );
            })));
  }
}
class ProductList extends StatelessWidget {

  //Products urunlers;
  @override
  Widget build(BuildContext context) {
    //print(urunlerMap["isim"].toString());
    /*for(int i =0;i<urunler.length;i++){
      print('----------------ÜRÜNLER-----------------------');
      print('resim : '+urunler[i].resim.toString());
      print('isim : '+urunler[i].isim.toString());
      print('fiyat : '+urunler[i].fiyat.toString());
      print('link : '+urunler[i].link.toString());

    }*/
    //print(urunlers.isim.toString());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          // add more IconButton
        ],
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),

        title: const Text('Ürünler listesi'),
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'Poppins',),
        centerTitle: true,
        backgroundColor: Colors.white,

      ),
      body: isLoading ? const Center(child: CircularProgressIndicator(),): SafeArea(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,

          ),
          itemCount: urunler.length,//burası değişecek
          itemBuilder: (context,index) => Card(
            elevation: 20,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(

              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https:'+urunler[index].resim.toString(),
                    height: MediaQuery.of(context).size.width/3,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,

                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ürün Adı',style: _style,),
                        //burada adı çağrılacak
                        Text(urunler[index].isim.toString(),style: _style_var,),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Text('Fiyat',style: _style,),
                        //burada fiyatı çağrılacak
                        Text(urunler[index].fiyat.toString(),style: _style_var,),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _url=Uri.parse(urunler[index].link.toString());
                                  _launchUrl();
                                },
                                child: const Text('Ürünü göster'),
                                style: TextButton.styleFrom(
                                    primary: Colors.deepOrange,

                                ),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Uri _url = Uri.parse('https://flutter.dev');

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  TextStyle _style = TextStyle(
    color: Colors.black54,
    fontSize: 15,
  );

  TextStyle _style_var = TextStyle(
    color: Colors.black87,
    fontSize: 15,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.bold,

  );
}