import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_delivery/common/component/custom_text_form_field.dart';
import 'package:flutter_delivery/common/const/colors.dart';
import 'package:flutter_delivery/common/const/data.dart';
import 'package:flutter_delivery/common/layout/default_layout.dart';
import 'package:flutter_delivery/common/view/root_tab.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:dio/dio.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    // localhost
    const emulatorIp = '10.0.2.2:3000';
    const simulatorIp = '127.0.0.1:3000';

    final ip = Platform.isIOS ? simulatorIp : emulatorIp;

    return DefaultLayout(
      child: SingleChildScrollView(
        // 키보드 내리기
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Title(),
                const Gap(16),
                const _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요',
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const Gap(16),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요',
                  obscureText: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                const Gap(16),
                ElevatedButton(
                  onPressed: () async {
                    // ID:비밀번호
                    final rawString = '$username:$password';

                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    String token = stringToBase64.encode(rawString);

                    final response = await dio.post(
                      'http://$ip/auth/login',
                      options: Options(
                        headers: {
                          'authorization': 'Basic $token',
                        },
                      ),
                    );
                    final refreshToken = response.data['refreshToken'];
                    final accessToken = response.data['accessToken'];
                    await storage.write(
                      key: REFRESH_TOKEN_KEY,
                      value: refreshToken,
                    );
                    await storage.write(
                      key: ACCESS_TOKEN_KEY,
                      value: accessToken,
                    );

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const RootTap(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '로그인',
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    const refreshToken =
                        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTY5OTA3ODQwMiwiZXhwIjoxNjk5MTY0ODAyfQ.OM-p-t2U6eKikd8bgmx1l1lqS8Jls7pPbZhjH_8eILw';
                    final response = await dio.post(
                      'http://$ip/auth/token',
                      options: Options(
                        headers: {
                          'authorization': 'Bearer $refreshToken',
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "회원가입",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요! \n오늘도 성공적인 주문이 되길:)',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
