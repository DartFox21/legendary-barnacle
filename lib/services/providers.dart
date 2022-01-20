import 'package:godartadmin/view_models/login_vm.dart';
import 'package:godartadmin/view_models/support_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final initProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => LoginVM()),
  ChangeNotifierProvider(create: (_) => SupportVM()),
];
