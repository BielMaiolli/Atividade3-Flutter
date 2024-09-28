import 'package:flutter/material.dart';

void main() {
  runApp(BankApp());
}

class BankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BankHomePage(),
    );
  }
}

class BankHomePage extends StatefulWidget {
  @override
  _BankHomePageState createState() => _BankHomePageState();
}

class _BankHomePageState extends State<BankHomePage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _transacoes = [];
  final TextEditingController _valorController = TextEditingController();

  void _adicionarTransacao() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _transacoes.add(_valorController.text);
      });
      _valorController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicação Bancária'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _valorController,
                      decoration: InputDecoration(labelText: 'Valor da Transação'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um valor';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _adicionarTransacao,
                    child: Text('Adicionar'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _transacoes.isEmpty
                  ? Center(child: Text('Nenhuma transação cadastrada.'))
                  : ListView.builder(
                      itemCount: _transacoes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text('Transação ${index + 1}'),
                            subtitle: Text('Valor: R\$ ${_transacoes[index]}'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
