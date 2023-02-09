import 'package:get/get.dart';

import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/bindings/add_doctor_detail_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/views/add_doctor_detail_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_timeslot/bindings/add_timeslot_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_timeslot/views/add_timeslot_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/appointment/bindings/appointment_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/appointment/views/appointment_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/balance/bindings/balance_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/balance/views/balance_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/chat/bindings/chat_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/chat/views/chat_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/dashboard/views/dashboard_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/edit_profile/bindings/edit_profile_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/edit_profile/views/edit_profile_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/home/bindings/home_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/home/views/home_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/list_chat/bindings/list_chat_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/list_chat/views/list_chat_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/login/bindings/login_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/login/views/login_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/order/bindings/order_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/order/views/order_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/order_detail/bindings/order_detail_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/order_detail/views/order_detail_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/profile/views/profile_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/register/bindings/register_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/register/views/register_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/video_call/bindings/video_call_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/video_call/views/video_call_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/withdraw_detail/bindings/withdraw_detail_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/withdraw_detail/views/withdraw_detail_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/withdraw_method/bindings/withdraw_method_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/withdraw_method/views/withdraw_method_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/withraw_finish/bindings/withraw_finish_binding.dart';
import 'package:hallo_doctor_doctor_app/app/modules/withraw_finish/views/withraw_finish_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const dashboard = Routes.DASHBOARD;
  static const login = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DOCTOR_DETAIL,
      page: () => AddDoctorDetailView(),
      binding: AddDoctorDetailBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT,
      page: () => AppointmentView(),
      binding: AppointmentBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TIMESLOT,
      page: () => AddTimeslotView(),
      binding: AddTimeslotBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAIL,
      page: () => OrderDetailView(),
      binding: OrderDetailBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_CALL,
      page: () => VideoCallView(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.BALANCE,
      page: () => BalanceView(),
      binding: BalanceBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW_METHOD,
      page: () => WithdrawMethodView(),
      binding: WithdrawMethodBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW_DETAIL,
      page: () => WithdrawDetailView(),
      binding: WithdrawDetailBinding(),
    ),
    GetPage(
      name: _Paths.WITHRAW_FINISH,
      page: () => WithrawFinishView(),
      binding: WithrawFinishBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.LIST_CHAT,
      page: () => ListChatView(),
      binding: ListChatBinding(),
    ),
  ];
}
