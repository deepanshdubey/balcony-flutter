import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController placeController =
      TextEditingController(text: "new jersey");
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(text: "+1");
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today_outlined,
                      color: theme.primaryColor),
                  SizedBox(width: 8.w),
                  Text(
                    "Schedule a tour | inquiry",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.spMin,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                "(no login / sign-up required)",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.primaryColor,
                  fontSize: 12.spMin,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(18.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    width: 1,
                    color: const Color(0xffe5e7eb),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! Place
                    Text(
                      "place",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      readOnly: true,
                      controller: placeController,
                      decoration: const InputDecoration(
                        hintText: "new jersey",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    //! Name
                    Text(
                      "your name*",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: "name ..",
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),
                    SizedBox(height: 16.h),

                    //! Phone
                    Text(
                      "your phone #*",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: "+1",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),
                    SizedBox(height: 16.h),

                    //! Email
                    Text(
                      "your email*",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "email ..",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),
                    SizedBox(height: 16.h),

                    //! Date
                    Text(
                      "tour date request",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: dateController,
                      decoration: const InputDecoration(
                        hintText: "MM/DD",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null) {
                          dateController.text =
                              "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
                        }
                      },
                    ),
                    SizedBox(height: 16.h),

                    //! Message
                    Text(
                      "short summary or inquiry if applicable",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: "Type your message here.",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 18.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            //! Handle submit
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Submitted!")),
                            );
                          }
                        },
                        child: Text(
                          "submit",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.spMin,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
