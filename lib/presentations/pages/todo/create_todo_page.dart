import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakobase/core/models/task_status.dart';
import 'package:nakobase/core/service_locator.dart';
import 'package:nakobase/presentations/components/app_button.dart';
import 'package:nakobase/presentations/components/snackbar.dart';
import 'package:nakobase/presentations/components/text_input.dart';
import 'package:nakobase/services/providers/task_status_provider.dart';
import 'package:nakobase/utils/extra/CustomSnackBar.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';
import 'package:provider/provider.dart';

import '../../../translations/locale_keys.g.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../../components/app_bar.dart';
import '../../components/shimmer_layout.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({Key? key}) : super(key: key);

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  late List<TaskStatus> tasks;
  bool isLoading = true;
  late TaskStatus selectedStatus;
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    tasks = Provider.of<TaskStatusProvider>(context, listen: false).statusList;
    print('${tasks.map((e) => e.taskStatusName)}');
    selectedStatus = tasks.first;
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;
    setState(() {

    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthContext = MediaQuery.of(context).size.width;

    Widget shimmeringTextLayout(){
      return Column(
        children: [
          ShimmerTextComponent(width: widthContext, height: 250,),
          const SizedBox(
            height: 10,
          ),
          ShimmerTextComponent(width: widthContext, height: 20,),
          const SizedBox(
            height: 10,
          ),
          ShimmerTextComponent(width: widthContext, height: 50,)
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(LocaleKeys.add_todo.tr(), style: boldTextStyle(color: black, size: 18)),
        backgroundColor: Colors.white,
        actions: [
          languageSetting(context, (){setState(() { });})
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: (isLoading == false)  ? Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(LocaleKeys.todo_titles.tr(), style: primaryTextStyle()),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: titleController,
                    decoration: inputDecoration(context, hintText: LocaleKeys.enter_todo_titles.tr()),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: ev_primary_color,
                    cursorWidth: 1,
                    validator: (s) {
                      if (s!.trim().isEmpty) return LocaleKeys.this_required.tr();
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Status', style: boldTextStyle(color: kDarkTextColor)),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    isExpanded: true,
                    // dropdownColor: whiteLight,
                    value: selectedStatus,
                    style: boldTextStyle(size: 12),
                    icon: const Icon(Icons.keyboard_arrow_down, color: kDarkTextColor),
                    decoration: inputDecoration(context),
                    onChanged: (dynamic newValue) {
                      setState(() {
                        selectedStatus = newValue;
                      });
                    },
                    items: tasks.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(category.taskStatusName ?? "Loading", style: primaryTextStyle()),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          await todoRepository.createTodo(title: titleController.text, statusId: selectedStatus.id.toString());
                          if (!mounted) {
                            return;
                          }
                          Navigator.pop(context);
                          showCustomSnackBar(LocaleKeys.add_todo.tr(), context, isError: false);
                        }
                        setState(() {});
                      },
                      style: getElevatedButtonStyle(),
                      child: Text(LocaleKeys.add_todo.tr(), style: primaryTextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ] ,
        ) : shimmeringTextLayout(),
      ),
    );
  }
}
