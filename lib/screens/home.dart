import 'package:flutter/material.dart';
import 'package:mi_pago/screens/archivos.dart';
import 'package:mi_pago/widgets/logoNameHeader.dart';
import 'package:mi_pago/screens/balance.dart';
import 'package:mi_pago/screens/tapBar.dart';
import 'package:mi_pago/screens/estadistica.dart';
import 'package:mi_pago/widgets/valor_unitario.dart';
import 'package:provider/provider.dart';
import 'package:mi_pago/models/itemData.dart';
import 'package:mi_pago/widgets/dropDownCiclopago.dart';

class HomeScreem extends StatefulWidget {

  @override
  State<HomeScreem> createState() => _HomeScreemState();
}

class _HomeScreemState extends State<HomeScreem> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Pago',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          resizeToAvoidBottomInset:false,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Home',
              style: TextStyle(fontFamily: 'Dalgona'),
            ),
          ),
          // drawer: SideMenu(),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  LogoNameWidget(),
                  //Text('${Provider.of<ItemData>(context).getValorUnitarioSF()}'),
                  ValorUnitario(
                      initValue:
                          '${Provider.of<ItemData>(context).valorUnitario}'),
                          //'${Provider.of<ItemData>(context).getValorUnitarioSF()}'),
                  DroppDownCiclopago(),
                  Container(
                    height: 100.0,
                    width: 350.0,
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green[700], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TapBarPage()));
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.add,
                              size: 55.0,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            'Ingreso Datos',
                            style: TextStyle(fontSize: 30, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    height: 100.0,
                    width: 350.0,
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BalanceGeneral()));
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.account_balance,
                              color: Colors.white70,
                              size: 55.0,
                            ),
                          ),
                          Text(
                            'Balance Ciclo',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100.0,
                    width: 350.0,
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Estadistica()));
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.assessment,
                              size: 55.0,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            'Visualizar Datos',
                            style: TextStyle(fontSize: 30, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*Container(
                    height: 100.0,
                    width: 350.0,
                    margin: EdgeInsets.all(20.0),
                    child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Archivos()));
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.backup,
                              size: 55.0,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            'Archivos',
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.white70),
                          )
                        ],
                      ),
                    ),
                  )*/
                ],
              ),
            ),
          )),
    );
  }
}
