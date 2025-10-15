import 'package:appprodutosestados/Models/product.dart';
import 'package:appprodutosestados/Models/productList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Productformpage extends StatefulWidget {
  const Productformpage({super.key});

  @override
  State<Productformpage> createState() => _ProductformpageState();
}

class _ProductformpageState extends State<Productformpage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id!;
        _formData['name'] = product.title!;
        _formData['price'] = product.price!;
        _formData['description'] = product.description!;
        _formData['url'] = product.imageUrl!;

        _imageUrlController.text = product.imageUrl!;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  //vai se basear no focus e atualizar o state já que é chamado no init e no dispose, por isso está vazio,
  //é como se fosse um f5
  void updateImage() {
    setState(() {});
  }

  bool isValidUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)!.hasAbsolutePath;
    bool endsWithFile =
        url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  //método de enviar formulário ---------------------------------
  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    //provider precisa ser listen=false pois está fora do método Build
    Provider.of<ProductList>(context, listen: false).saveProduct(_formData);
    Navigator.of(context).pop();
  }
  //---------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    Widget _formFieldDecoration({required Widget child}) {
      return Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: BoxBorder.all(color: Colors.grey, width: 2),
          ),
          child: child,
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
      );
    }

    //------------------------------------------------------//

    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário Produto"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(onPressed: _submitForm, icon: Icon(Icons.save_outlined)),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          //uma chave do formulário para conseguir pegar as informações
          key: _formKey,
          child: ListView(
            children: [
              //Nome
              _formFieldDecoration(
                child: TextFormField(
                  initialValue: _formData['name']?.toString(),
                  decoration: InputDecoration(
                    labelText: "Nome",
                    border: InputBorder.none,
                  ),

                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  onSaved: (name) => _formData['name'] = name!,
                  //se estiver validado, retorna null, se não, retorna uma String que será
                  //exibida em caso de erro
                  validator: (_name) {
                    final name = _name ?? '';
                    if (name.trim().isEmpty) {
                      return 'Nome é obrigatório';
                    }

                    if (name.trim().length < 3) {
                      return 'Nome precisa de no mínimo 3 letras.';
                    }
                    return null;
                  },
                ),
              ),

              //Preço
              _formFieldDecoration(
                child: TextFormField(
                  initialValue: _formData['price']?.toString(),
                  decoration: InputDecoration(
                    labelText: "Preço",
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocus,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  onSaved: (preco) =>
                      _formData['price'] = double.tryParse(preco ?? '') ?? 0,
                  validator: (_price) {
                    final priceString = _price ?? '-1';
                    final price = double.tryParse(priceString) ?? -1;

                    if (price <= 0) {
                      return "Informe um preço válido";
                    }
                    return null;
                  },
                ),
              ),

              //Descrição
              _formFieldDecoration(
                child: TextFormField(
                  initialValue: _formData['description']?.toString(),
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocus,
                  maxLines: 3,
                  onSaved: (descricao) => _formData['description'] = descricao!,
                  validator: (_description) {
                    final description = _description ?? '';
                    if (description.trim().isEmpty) {
                      return 'Descrição é obrigatória';
                    }

                    if (description.trim().length < 10) {
                      return 'Descrição precisa de no mínimo 10 letras.';
                    }
                    return null;
                  },
                ),
              ),

              //Url
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 10,
                children: [
                  Expanded(
                    child: _formFieldDecoration(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Url da imagem",
                          border: InputBorder.none,
                        ),
                        focusNode: _imageUrlFocus,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        onFieldSubmitted: (_) => _submitForm(),
                        onSaved: (url) => _formData['url'] = url!,
                        validator: (_url) {
                          final url = _url ?? '';

                          if (!isValidUrl(url)) {
                            return "Insira uma url válida";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  //Imagem
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? FittedBox(child: Text("Informe a Url"))
                        : ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(15),
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
