import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'cubit/states.dart';

class RegisterScreen  extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
            if (state is ShopRegisterSuccessState) {
              if (state.loginModel!.status == true) {
                CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel!.data!.token,
                ).then((value) {
                  token=state.loginModel!.data!.token!;
                  print(token);
                  navigateAndFinish(
                    context,
                    ShopLayout(),
                  );
                  showToast(
                    text: state.loginModel!.message!,
                    state: ToastStates.SUCCESS,
                  );
                });
              } else {
                showToast(
                  text: state.loginModel!.message!,
                  state: ToastStates.ERROR,
                );
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Register now to browse our hot offers',
                            style:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your name address';
                              }
                              return null;
                            },
                            label: 'User Name',
                            prefix: Icons.person,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              //print(value);
                              if (value == null || value.isEmpty) {
                                return 'please enter your email address';
                              }
                              return null;
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            isPassword: ShopRegisterCubit.get(context).isPassword,
                            onSubmit: (value) {
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your Password address';
                              }
                              return null;
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your phone number';
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'REGISTER',
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}