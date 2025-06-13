import 'package:habitree/core/theme/export_ui_styleguide.dart';

class RoutesErrorPage extends StatelessWidget {
  const RoutesErrorPage({super.key, this.routeName});

  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error Page', style: context.headlineMedium),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Text('Error Page: $routeName', style: context.headlineMedium),
      ),
    );
  }
}
