import 'package:a3_appclima/Climapage.dart';
import 'package:flutter/material.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  late String cidade;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 6, 43, 52),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                    'https://mir-s3-cdn-cf.behance.net/project_modules/disp/935db025346915.5634cbff92fe7.gif'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 600,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.blue),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              label: const Text('Cidade'),
                              labelStyle: const TextStyle(color: Colors.white),
                              hintText: 'Digite o nome da cidade',
                              hintStyle: const TextStyle(color: Colors.white),
                              icon: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              )),
                          onChanged: (value) {
                            cidade = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo obrigatório';
                            }
                          },
                        )),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                    width: 125,
                    child: ElevatedButton.icon(
                      onPressed: (() {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      PaginaPrincipal(cidade: cidade))));
                        }
                      }),
                      icon: const Icon(Icons.search),
                      label: const Text('Pesquisar'),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    )),
              ]),
        ),
      ),
    );
  }
}
