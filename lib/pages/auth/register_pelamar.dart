part of '../page.dart';

class register_pelamar extends StatefulWidget {
  @override
  _registerPelamarState createState() => _registerPelamarState();
}

class _registerPelamarState extends State<register_pelamar> {
  // VARIABLE
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final TextEditingController EmailController = TextEditingController();
  String emailErrorMessage = '';
  bool mailIsEror = false;

  final TextEditingController passwordController = TextEditingController();
  String passErrorMessage = '';
  bool passIsEror = false;

  final TextEditingController confirmPasswordController =
      TextEditingController();
  String confirmPassErrorMessage = '';
  bool confirmPassIsEror = false;

  final TextEditingController FNameController = TextEditingController();
  String FNameErrorMessage = '';
  bool FNameIsEror = false;

  final TextEditingController LNameController = TextEditingController();
  String LNameErrorMessage = '';
  bool LNameIsEror = false;

  String generalMassageEror = '';
  bool generalEror = false;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  // FUNGSI
  bool isEmailValid(String email) {
    return email.contains('@');
  }

  bool isPassValid(String pass) {
    return pass.isNotEmpty;
  }

  bool checkConfirmPass(String pass, String confirmPass) {
    return (pass == confirmPass);
  }

  Future<void> createAccount(String Fname, String Lname, String email,
      String password, String confirmPass) async {
    setState(() {
      // Reset semua error messages
      FNameErrorMessage = '';
      LNameErrorMessage = '';
      emailErrorMessage = '';
      passErrorMessage = '';
      confirmPassErrorMessage = '';

      // Reset status error
      FNameIsEror = false;
      LNameIsEror = false;
      mailIsEror = false;
      passIsEror = false;
      confirmPassIsEror = false;

      // Cek jika ada field yang kosong dan set error message yang sesuai
      if (Fname.isEmpty) {
        FNameErrorMessage = "Nama depan tidak boleh kosong";
        FNameIsEror = true;
      }
      if (Lname.isEmpty) {
        LNameErrorMessage = "Nama belakang tidak boleh kosong";
        LNameIsEror = true;
      }
      if (email.isEmpty) {
        emailErrorMessage = "Email tidak boleh kosong";
        mailIsEror = true;
      }
      if (password.isEmpty) {
        passErrorMessage = "Password tidak boleh kosong";
        passIsEror = true;
      }
      if (confirmPass.isEmpty) {
        confirmPassErrorMessage = "Konfirmasi password tidak boleh kosong";
        confirmPassIsEror = true;
      } else if (confirmPass != password) {
        confirmPassErrorMessage = "konfirmasi password tidak sesuai.";
        confirmPassIsEror = true;
      }
    });
    if (!FNameIsEror &&
        !LNameIsEror &&
        !mailIsEror &&
        !passIsEror &&
        !confirmPassIsEror) {
      try {
        bool status =
            await Pelamarapi().createAccount(Fname, Lname, email, password);

        if (status) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => login_page()),
            (route) => false,
          );
          showProfileUpdatedNotification();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Ooppss, Email Sudah Terdaftar!"),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error ketika membuat akun!"),
          ),
        );
      }
    }
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showProfileUpdatedNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'account_creation_channel',
      'Notifikasi Pembuatan Akun',
      channelDescription: 'Notifications for successful account creation',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Akun Berhasil Dibuat',
      'Selamat datang di platform kami! Akun Anda telah dibuat. Mulailah menjelajahi peluang sekarang!',
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Pendaftaran Pelamar',
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
                  "Jika anda seorang pelamar, silahkan daftar disini",
                  style: TextStyle(
                    color: greyColor,
                    fontFamily: 'poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => register_hrd()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: thirdColor, // Warna tombol
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Buat Akun Perusahaan',
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            // Teks Welcome Applicants
            Text(
              "Selamat Datang",
              style: TextStyle(
                color: thirdColor,
                fontFamily: 'poppins',
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            Text(
              "Lanjutkan membuat akun anda untuk melamar pekerjaan",
              style: TextStyle(
                color: greyColor,
                fontFamily: 'poppins',
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(
              height: 30,
            ),
            name_input(
                nameInputController: FNameController,
                label: "Nama Depan",
                isEror: FNameIsEror),
            if (FNameErrorMessage.isNotEmpty)
              Text(
                FNameErrorMessage,
                style: TextStyle(color: Colors.red),
              ),

            SizedBox(height: 10),
            name_input(
                nameInputController: LNameController,
                label: "Nama Belakang",
                isEror: LNameIsEror),
            if (LNameErrorMessage.isNotEmpty)
              Text(
                LNameErrorMessage,
                style: TextStyle(color: Colors.red),
              ),

            SizedBox(height: 10),
            EmailInput(emailController: EmailController, isEror: mailIsEror),
            if (emailErrorMessage.isNotEmpty)
              Text(
                emailErrorMessage,
                style: TextStyle(color: Colors.red),
              ),

            SizedBox(height: 10),
            PassInput(controller: passwordController, isEror: passIsEror),
            if (passErrorMessage.isNotEmpty)
              Text(
                passErrorMessage,
                style: TextStyle(color: Colors.red),
              ),

            SizedBox(height: 10),
            ConfirmPassInput(
                controller: confirmPasswordController,
                isEror: confirmPassIsEror),
            if (confirmPassErrorMessage.isNotEmpty)
              Text(
                confirmPassErrorMessage,
                style: TextStyle(color: Colors.red),
              ),

            SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 300,
                child: Text(
                  "Dengan mendaftar, anda setuju dengan syarat dan ketentuan kami",
                  style: TextStyle(
                    color: greyColor,
                    fontFamily: 'poppins',
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  String Fname = FNameController.text;
                  String Lname = LNameController.text;
                  String email = EmailController.text;
                  String pass = passwordController.text;
                  String confirmPass = confirmPasswordController.text;

                  createAccount(Fname, Lname, email, pass, confirmPass);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: thirdColor, // Warna tombol
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Buat Akun',
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
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
                  TextSpan(text: "Sudah punya akun? "),
                  TextSpan(
                    text: "Masuk Sekarang",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => login_page()),
                          (route) => false,
                        );
                      },
                  ),
                ],
              ),
            ),

            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
