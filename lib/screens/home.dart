import 'package:flutter/material.dart';
import 'package:mas_notas/util/theme.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: hint,
      appBar: AppBar(
          title: Text(
            "Más Notas",
          ),
          elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 40,
              ),
              child: Text(
                "Horario",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Center(
              child: Wrap(
                spacing: width * 0.05,
                runSpacing: width * 0.05,
                children: buildContainers(height, width),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Container> buildContainers(double height, double width) {
    List<String> im = [
      "https://images.unsplash.com/photo-1453733190371-0a9bedd82893?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2767&q=80",
      "https://images.unsplash.com/photo-1569396116180-7fe09fa16dd8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1565282604648-a13c5f19fd61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1562411052-a9fe410b5a9c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    ];
    List<String> nom = [
      "Matematicas",
      "Estructura de Datos",
      "Cambio Climatico",
      "Quimica"
    ];
    List<Container> lista = [];

    for (var i = 0; i < im.length; i++) {
      Container con = Container(
        height: height * 0.17,
        width: width * 0.45,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    30,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Image.network(
                    im[i],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 40),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade800,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Text(
                      nom[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
      lista.add(con);
    }
    return lista;
  }
}
