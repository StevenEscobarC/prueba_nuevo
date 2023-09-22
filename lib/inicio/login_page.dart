import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _cargando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            // Fondo degradado
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.green,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // Column(
            //   children: [
            //     // Color de fondo 1
            //     Expanded(
            //       flex: 1,
            //       child: Container(
            //         color: Colors.blue,
            //         alignment: Alignment.bottomRight,
            //       ),
            //     ),

            //     // Color de fondo 2
            //     Expanded(
            //       flex: 2,
            //       child: Container(
            //         alignment: Alignment.bottomRight,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(20),
            //           color: Colors.green,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    // Imagen de fondo
                    const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 95,
                      backgroundImage: NetworkImage(
                          'https://cdn.autobild.es/sites/navi.axelspringer.es/public/media/image/2016/09/569465-whatsapp-que-tus-contactos-ponen-rana-perfil.jpg?tf=1200x'),
                    ),
                    const SizedBox(height: 20),
                    // Campo de texto para el correo electrónico
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        //labelText: 'Correo electrónico',
                        hintText: 'Correo electrónico',
                        hintStyle: TextStyle(color: Colors.blue),
                        // Redondear los bordes del campo de texto
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // Rellenar el interior del campo de texto con un color sólido
                        filled: true,
                        fillColor: Colors.blue[100],
                        suffixIcon: Icon(Icons.email, color: Colors.blue),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese su correo electrónico';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Campo de texto para la contraseña
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        //labelText: 'Contraseña',
                        hintText: 'Contraseña',
                        hintStyle: TextStyle(color: Colors.blue),
                        // Redondear los bordes del campo de texto
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // Rellenar el interior del campo de texto con un color sólido
                        filled: true,
                        fillColor: Colors.blue[100],
                        suffixIcon: Icon(Icons.password, color: Colors.blue),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese su contraseña';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Botón de inicio de sesión
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          // Validar el formulario
                          if (_formKey.currentState!.validate()) {
                            // Iniciar sesión
                            await _login();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Iniciar sesión'),
                              Visibility(
                                  visible: _cargando,
                                  child: const SizedBox(width: 10)),
                              _cargando
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Botón de registro
                    TextButton(
                      onPressed: () {
                        // Navegar a la página de registro
                        Navigator.pushNamed(context, '/registro');
                      },
                      child: Text('Registrarse'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      setState(() {
        _cargando = true;
      });
      // Simular el inicio de sesión
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        _cargando = false;
      });
      // Navegar a la página principal
      Navigator.pushReplacementNamed(context, '/home');
    } on PlatformException catch (e) {
      // Mostrar un error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
    }
  }
}
