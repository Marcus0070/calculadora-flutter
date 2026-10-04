import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp ({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController numero1Controller = TextEditingController();
  final TextEditingController numero2Controller = TextEditingController();

  String resultado = '0';

  void calcular(String operacao) {
    double? numero1 = double.tryParse(numero1Controller.text);
    double? numero2 = double.tryParse(numero2Controller.text);

    if (numero1 == null || numero2 == null) {
      setState(() {
        resultado = 'Digite dois números válidos';
      });
      return;
    }

    double valor;

    switch (operacao) {
      case '+':
        valor = numero1 + numero2;
        break;

      case '-':
        valor = numero1 - numero2;
        break;

      case '×':
        valor = numero1 * numero2;
        break;

      case '÷':
        if (numero2 == 0) {
          setState(() {
            resultado = 'Não é possível dividir por zero';
          });
          return;
        }
        valor = numero1 / numero2;
        break;

      default:
        return;
    }

    setState(() {
      resultado = valor.toString();
    });
  }

  void limpar() {
    numero1Controller.clear();
    numero2Controller.clear();

    setState(() {
      resultado = '0';
    });
  }

  @override
  void dispose() {
    numero1Controller.dispose();
    numero2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Calculadora Matemática',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: numero1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Primeiro número',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: numero2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Segundo número',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => calcular('+'),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () => calcular('-'),
                    child: const Text(
                      '-',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => calcular('×'),
                    child: const Text(
                      '×',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () => calcular('÷'),
                    child: const Text(
                      '÷',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Resultado:',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 5),

            Text(
              resultado,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            OutlinedButton(
              onPressed: limpar,
              child: const Text('Limpar'),
            ),
          ],
        ),
      ),
    );
  }
}
