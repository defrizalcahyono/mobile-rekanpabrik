part of '../page.dart';

class login_page extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<login_page> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final LoginAPI loginapi = LoginAPI();
  final meAPI meapi = meAPI();
  String emailErrorMessage = '';
  String passErrorMessage = '';
  bool mailIsEror = false;
  bool passIsEror = false;
  bool isLoading = false;

  bool isEmailValid(String email) {
    return email.contains('@');
  }

  bool isPassValid(String pass) {
    return pass.isNotEmpty;
  }

  bool cekEmailnPass(String email, String pass) {
    return (email.isNotEmpty && pass.isNotEmpty);
  }

  void LoginUser(String email, String pass) async {
    setState(() {
      emailErrorMessage = '';
      passErrorMessage = '';
      mailIsEror = false;
      passIsEror = false;
      isLoading = true;
    });

    if (!isEmailValid(email)) {
      setState(() {
        emailErrorMessage = 'Email harus mengandung "@"';
        mailIsEror = true;
        isLoading = false;
      });
      return;
    }

    if (!isPassValid(pass)) {
      setState(() {
        passErrorMessage = 'Password tidak boleh kosong';
        passIsEror = true;
        isLoading = false;
      });
      return;
    }

    var response = await loginapi.login(email, pass);

    if (response['status'] == true) {
      var user = await meapi.getUserProfile();
      print("========== USER ==========");
      print("USER RESPONSE:");
      print(user);
      print("==========================");

      if (user['status'] == true && user['data'] != null) {
        print(user['data']);
        String role = user['data']['role'];
        print("ROLE = $role");
        if (role == 'pelamar') {
          Navigator.pushNamed(context, '/pagePelamar');
        } else if (role == 'perusahaan') {
          Navigator.pushNamed(context, '/pageHRD');
        } else {
          Navigator.pushNamed(context, '/');
        }
      } else {
        print('User profile retrieval failed: ${user['message']}');
        setState(() {
          emailErrorMessage = "Email atau password salah";
          passErrorMessage = "Email atau password salah";

          mailIsEror = true;
          passIsEror = true;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        emailErrorMessage =
            response['message'] ?? "Email atau password salah";
        passErrorMessage =
            response['message'] ?? "Email atau password salah";

        mailIsEror = true;
        passIsEror = true;
        isLoading = false;
      });
    }
  }

  void testing2() {
    Navigator.pushNamed(context, '/pagePelamar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          '',
          style: TextStyle(
            color: thirdColor,
            fontFamily: 'poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: true,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: [
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 250,
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: thirdColor,
                    fontFamily: 'poppins',
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: true,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 250,
                child: Text(
                  "Selamat Datang!",
                  style: TextStyle(
                    color: thirdColor,
                    fontFamily: 'poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  softWrap: true,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            EmailInput(
              emailController: EmailController,
              isEror: mailIsEror,
            ),
            if (emailErrorMessage.isNotEmpty)
              Text(
                emailErrorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(
              height: 20,
            ),
            PassInput(
              controller: passwordController,
              isEror: passIsEror,
            ),
            if (passErrorMessage.isNotEmpty)
              Text(
                passErrorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LupaPassword()),
                  );
                },
                child: Text(
                  'Lupa Password?',
                  style: TextStyle(
                    fontSize: 16,
                    color: greyColor,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: isLoading
                  ? CircularProgressIndicator(
                      color: thirdColor,
                    )
                  : ElevatedButton(
                      onPressed: () {
                        String email = EmailController.text.trim();
                        String pass = passwordController.text.trim();
                        LoginUser(email, pass);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: thirdColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 50),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: greyColor,
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                children: <TextSpan>[
                  TextSpan(text: "Belum punya akun? "),
                  TextSpan(
                    text: "Daftar Sekarang",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => register_pelamar()),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
