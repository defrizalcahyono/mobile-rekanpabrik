part of 'page.dart';

class WellcomePage extends StatefulWidget {
  const WellcomePage({super.key});

  @override
  State<WellcomePage> createState() => _WellcomePageState();
}

class _WellcomePageState extends State<WellcomePage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    _requestNotificationPermission();
  }

  void _requestNotificationPermission() async {
    final bool? granted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    if (granted != null && !granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Izin Notifikasi ditolak!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: [
            Image.asset(
              'assets/img/logoRekanPabrik.png',
              height: 300,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Selamat Datang",
              style: TextStyle(
                  color: thirdColor,
                  fontFamily:
                      'poppins', // Ganti dengan warna yang Anda inginkan
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Silahkan Login atau Buat Akun untuk melanjutkan",
              style: TextStyle(
                  fontFamily: 'poppins', color: blackColor, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 2 * 23,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registerPelamar');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: thirdColor,
                ),
                child: Text(
                  'Buat Akun',
                  style: TextStyle(
                    fontSize: 20,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 2 * 23,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.transparent, // Latar belakang transparan
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: thirdColor, // Warna border coklat
                      width: 2, // Ketebalan border
                    ),
                  ),
                  elevation:
                      0, // Hilangkan bayangan agar benar-benar transparan
                ),
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 20,
                    color: thirdColor, // Warna teks tetap
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
