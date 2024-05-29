import 'package:flutter/material.dart';
import 'package:terreneitor/vistas/principal.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late GlobalKey<FormState> globalFormKeyLogin;
  final TextEditingController emailController = TextEditingController();
  bool hidePassword = true;
  final TextEditingController passwordController = TextEditingController();
  String defaultContra = '1234';
  String defaultUsuario = 'admin';
  @override
  void initState() {
    super.initState();
    globalFormKeyLogin = GlobalKey<FormState>();
  }

  String? validarContrasena(String contrasena) {
    if (contrasena.isEmpty) {
      return 'Este campo es requerido';
    }
    {
      return null;
    }
  }

  String? validarUsuario(String value) {
    if (value.isEmpty) {
      return 'Este campo es requerido';
    } else {
      return null;
    }
  }

  void _submitForm(BuildContext context) async {
    if (!globalFormKeyLogin.currentState!.validate()) {
      return;
    }
    globalFormKeyLogin.currentState!.save();
    if (emailController.text == defaultUsuario &&
        passwordController.text == defaultContra) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const Principal(),
          transitionsBuilder: (context, animation1, animation2, child) {
            return child; // No se aplica ninguna animación
          },
          transitionDuration:
              Duration(seconds: 0), // Opcional: ajustar la duración a 0
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales incorrectas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: globalFormKeyLogin,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Logo
                Text(
                  'Terreneitor',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),

                const SizedBox(height: 25),
                //slogan
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      
                      labelText: 'Usuario',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                          color: Color(0xff93479b),
                        ),
                      ),
                    ),
                    validator: (value) => validarUsuario(value!),
                    onChanged: validarUsuario,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.name,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                          color: Color(0xff93479b),
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        color: Theme.of(context).colorScheme.primary,
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    validator: (value) => validarContrasena(value!),
                    onChanged: validarContrasena,
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () => _submitForm(context),
                    child: Text('Iniciar',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary)),
                  ),
                ),
                // registrarse
              ],
            ),
          ),
        ),
      ),
    );
  }
}
