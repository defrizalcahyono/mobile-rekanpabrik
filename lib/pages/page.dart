import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rekanpabrik/api/loginAPI.dart';
import 'package:rekanpabrik/api/meAPI.dart';
import 'package:rekanpabrik/api/melamar_pekerjaanAPI.dart';
import 'package:rekanpabrik/api/pelamarAPI.dart';
import 'package:rekanpabrik/api/perusahaanAPI.dart';
import 'package:rekanpabrik/api/posting_pekerjaan_API.dart';
import 'package:rekanpabrik/api/saved_jobs_API.dart';
import 'package:rekanpabrik/components/companyName_input.dart';
import 'package:rekanpabrik/components/search_bar_pelamar_pekerjaan.dart';
import 'package:rekanpabrik/pages/HRD/change_profile_page_perusahaan.dart';
import 'package:rekanpabrik/pages/HRD/resetPassPerusahaan.dart';
import 'package:rekanpabrik/pages/auth/lupa_password.dart';
import 'package:rekanpabrik/pages/pagePelamar/change_profile_page_pelamar.dart';
import 'package:rekanpabrik/pages/pagePelamar/resetPassPelamar.dart';
import 'package:rekanpabrik/pages/pagePelamar/upload_cv.dart';
import 'package:rekanpabrik/pages/pengaduan/pengaduan.dart';
import 'package:url_launcher/url_launcher.dart';

// COMPONENTS
import 'package:rekanpabrik/components/carousel.dart';
import 'package:rekanpabrik/components/confirm_pass_input.dart';
import 'package:rekanpabrik/components/containerHomePelamar.dart';
import 'package:rekanpabrik/components/email_input.dart';
import 'package:rekanpabrik/components/name_input.dart';
import 'package:rekanpabrik/components/pass_input.dart';
import 'package:rekanpabrik/components/searchBarCariPabrik.dart';
import 'package:rekanpabrik/components/search_bar_cari_pekerjaan.dart';
import 'package:rekanpabrik/components/searchBarRiwayatLamaran.dart';
import 'package:rekanpabrik/components/searchBarSavedJobs.dart';

// THEMES
import 'package:rekanpabrik/shared/shared.dart';

// UTILS
import 'package:rekanpabrik/utils/dummyMelamarPekerjaan.dart';
import 'package:rekanpabrik/utils/dummyPerusahaan.dart';
import 'package:rekanpabrik/utils/formattedDate.dart';

import '../components/HRDnavbarComponent.dart';

// PAGES
part 'wellcomePage.dart';

// UTILS
part 'auth/register_pelamar.dart';
part 'auth/login_page.dart';
part 'auth/register_hrd.dart';

// PELAMAR
part 'pagePelamar/home_pelamar.dart';
part 'pagePelamar/cariPabrik.dart';
part 'pagePelamar/savedJobs.dart';
part 'pagePelamar/cariPekerjaan.dart';
part 'pagePelamar/lamarPekerjaan.dart';
part 'pagePelamar/riwayatLamaran.dart';
part 'pagePelamar/detailSavedJobs.dart';
part 'pagePelamar/detailHistoryLamaran.dart';
part 'pagePelamar/profilePage.dart';
part 'pagePelamar/detail_perusahaan.dart';
part 'pagePelamar/detailPekerjaan.dart';

//HRD
part 'HRD/homepageHRD.dart';
part 'HRD/postHistory.dart';
part 'HRD/profile_HRD.dart';
part 'HRD/cekpelamar.dart';
part 'HRD/postJob.dart';
part 'HRD/detailPekerjaanHRD.dart';
