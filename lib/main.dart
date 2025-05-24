import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _showTermsCheckbox = false;
  bool _acceptedTerms = false;

  void _onCreateAccountPressed() {
    print('Finalizando criação de conta');
    setState(() {
      _showTermsCheckbox = true;
    });
    if (_showTermsCheckbox) {
      print('Finalizando criação de conta');
      setState(() {
        _showTermsCheckbox = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/Ilustração Login.png',
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira e-mail.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira uma senha.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        print('Esqueci a senha clicado');
                      },
                      child: Text(
                        'Esqueci a senha!',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                if (_showTermsCheckbox) ...[
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _acceptedTerms,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            _acceptedTerms = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'Li e estou ciente quanto às condições de tratamento dos meus dados conforme descrito na Política de Privacidade do banco.',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed:
                      (_showTermsCheckbox && !_acceptedTerms)
                          ? null
                          : () {
                            if (!_showTermsCheckbox) {
                              setState(() {
                                _showTermsCheckbox = true;
                              });
                              return;
                            }
                            if (_showTermsCheckbox &&
                                _acceptedTerms &&
                                _formKey.currentState!.validate()) {
                              // TODO: Implement account creation logic
                              print('Username: ${_usernameController.text}');
                              print('Password: ${_passwordController.text}');
                              _onCreateAccountPressed();
                            }
                          },
                  child: Text(
                    _showTermsCheckbox ? 'Finalizar criação' : 'Criar conta',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),

                if (!_showTermsCheckbox) ...[
                  const SizedBox(height: 16),
                  Text('Já tem uma conta?'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 45,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: const BorderSide(color: Colors.red, width: 2),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //TODO: Implement login logic
                        print('Username: ${_usernameController.text}');
                        print('Password: ${_passwordController.text}');
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
