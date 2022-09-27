import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sdui_form_builder/model/action_model.dart';
import 'package:sdui_form_builder/response_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SDUI Form Builder',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _formKey = GlobalKey<FormState>();

  late ResponseModel model;

  bool isLoading = true;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  Future<void> _getData() async {
    await Future.delayed(const Duration(seconds: 2));
    final response =
        await rootBundle.loadString('assets/mock_json/example.json');

    model = responseModelFromJson(response);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter SDUI Form Builder')),
      body: isLoading ? _loading() : _view(context),
    );
  }

  Center _loading() => const Center(child: CircularProgressIndicator());

  Map<String, dynamic> result = {};

  Form _view(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        itemCount: model.data?.sections?.length ?? 0,
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          Sections section = model.data!.sections![index];
          return WidgetMapping.i.getWidget(
            section,
            index,
            formKey: _formKey,
            onSaved: (key, value) => result[key!] = value,
            onTap: (ActionModel? action) {
              if (!_formKey.currentState!.validate()) return;
              _formKey.currentState?.save();
              MappingAction.i.onTap(action, value: json.encode(result));
            },
          );
        },
      ),
    );
  }
}

class WidgetMapping {
  WidgetMapping._();

  static WidgetMapping get i => WidgetMapping._();

  Widget getWidget(
    Sections section,
    int index, {
    dynamic formKey,
    Function(String? key, String? value)? onSaved,
    Function(ActionModel? action)? onTap,
  }) {
    switch (section.uiType) {
      case "text_form_field":
        final content = section.content;
        return TextFormField(
          key: ValueKey(content?.attribute),
          initialValue: content?.value,
          decoration: InputDecoration(
            labelText: content?.label,
            hintText: content?.hint,
          ),
          validator: (val) {
            if (content?.validateMessage != null) {
              if (val == null || val.isEmpty) {
                return content?.validateMessage ?? 'Field is required';
              }
              return null;
            }
            return null;
          },
          onSaved: (val) {
            content?.value = val;
            if (onSaved != null) {
              onSaved.call(content?.attribute, val);
            }
          },
        );
      case "elevated_button":
        final content = section.action;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            maximumSize: const Size(double.infinity, 50),
          ),
          onPressed: onTap == null ? null : () => onTap.call(content),
          child: Text(content?.title ?? ''),
        );
    }
    return const SizedBox();
  }
}

class MappingAction {
  MappingAction._();

  static MappingAction get i => MappingAction._();

  void onTap(ActionModel? actionModel, {dynamic value}) {
    print('onTap :: $value');
  }
}
