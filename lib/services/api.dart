import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pros_bot/models/annual_plan/getAnnualPlans.dart';
import 'package:pros_bot/models/annual_plan/plan.dart';
import 'package:pros_bot/models/appointments/get_appointment.dart';
import 'package:pros_bot/models/appointments/get_appointment_by_id.dart';
import 'package:pros_bot/models/auth/Otp.dart';
import 'package:pros_bot/models/auth/PostCustomerSignUp.dart';
import 'package:pros_bot/models/auth/checkAuthorize.dart';
import 'package:pros_bot/models/auth/getCustomerLoginUpdateDetails.dart';
import 'package:pros_bot/models/auth/get_company.dart';
import 'package:pros_bot/models/follow_up/coverage.dart';
import 'package:pros_bot/models/home/analyse_data.dart';
import 'package:pros_bot/models/home/profile.dart';
import 'package:pros_bot/models/leader/leaderboard.dart';
import 'package:pros_bot/models/nop/covers_by_id.dart';
import 'package:pros_bot/models/nop/get_plan_by_id.dart';
import 'package:pros_bot/models/nop/get_prospect_with_plan.dart';
import 'package:pros_bot/models/nop/multiple_plans.dart';
import 'package:pros_bot/models/nop/user_plans.dart';
import 'package:pros_bot/models/pros_child.dart';
import 'package:pros_bot/models/prospect/get_child_by_id.dart';
import 'package:pros_bot/models/prospect/get_prospects.dart';
import 'package:pros_bot/models/prospect/prospect_by_id.dart';
import 'package:pros_bot/models/report/anual_report.dart';
import 'package:pros_bot/models/report/month_report.dart';
import 'package:pros_bot/models/today/dob_list.dart';
import 'package:pros_bot/models/today/premium.dart';

import 'baseUrl.dart';

class APIs {
  Dio dio = new Dio();
  String defaultMessage = "Please try again, Can't find data.";
  String subDomain = "";
  PersistCookieJar persistentCookies;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<Directory> get localCookieDirectory async {
    final path = await _localPath;
    final Directory dir = new Directory('$path/cookies');
    await dir.create();
    return dir;
  }

  Future<void> setCookie() async {
    try {
      final Directory dir = await localCookieDirectory;
      final cookiePath = dir.path;
      // persistentCookies = new PersistCookieJar(dir: '$cookiePath');

      // persistentCookies.deleteAll(); //clearing any existing cookies for a fresh start
      dio.interceptors.add(CookieManager(
              persistentCookies) //this sets up _dio to persist cookies throughout subsequent requests
          );
      dio.options = new BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 500000,
        receiveTimeout: 500000,
        headers: {
          HttpHeaders.userAgentHeader: "cicra-user-dio-all-head",
          "Connection": "keep-alive",
        },
      );
    } catch (error) {
      print(defaultMessage);
    }
  }

  Future<CheckAuthorize> checkAuthorize({String mobileNo}) async {
    try {
      // await setCookie();
      Response response = await dio.post('$baseUrl/users/check-number', data: {
        "contact_no": mobileNo,
        "country_code": "",
      });
      return CheckAuthorize.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        CheckAuthorize result = new CheckAuthorize();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        CheckAuthorize result = new CheckAuthorize();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        CheckAuthorize result = new CheckAuthorize();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        CheckAuthorize result = new CheckAuthorize();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<PostCustomerSignUp> postCustomerSignUp({
    String contactNo,
    String name,
    String nic,
    String email,
    String address,
    /*    String companyId,
    String position, */
    String country,
/*     String regNo,
    String jobRole, */
  }) async {
    try {
      // await setCookie();
      Response response = await dio.post('$baseUrl/users/signup', data: {
        "name": name,
        "nic": nic,
        "contact_no": contactNo,
        "email": email,
        "address": address,
        /*   "company_id": companyId,
        "position": position,
        "reg_no": regNo,
        "job_role": jobRole, */
        "country": country,
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<OtpData> verifyOtp(
      String contactNo, String pin, String id, bool isReg) async {
    try {
      // await setCookie();
      Response response = new Response();
      if (isReg) {
        response = await dio.post('$baseUrl/users/verify', data: {
          'id': id,
          'pin': pin,
        });
      } else {
        response = await dio.post('$baseUrl/users/verify-unregistered', data: {
          'contact_no': contactNo,
          'pin': pin,
        });
      }
      return OtpData.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        OtpData result = new OtpData();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        OtpData result = new OtpData();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        OtpData result = new OtpData();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        OtpData result = new OtpData();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<CustomerLoginUpdateDetails> postCustomerLogin(
      {String mobileNo, String password}) async {
    try {
      // await setCookie();
      // persistentCookies.deleteAll();
      Response response = await dio.post('$baseUrl/users/login', data: {
        "contact_no": mobileNo,
        "country_code": "",
      });
      return CustomerLoginUpdateDetails.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        CustomerLoginUpdateDetails result = new CustomerLoginUpdateDetails();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        CustomerLoginUpdateDetails result = new CustomerLoginUpdateDetails();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        CustomerLoginUpdateDetails result = new CustomerLoginUpdateDetails();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        CustomerLoginUpdateDetails result = new CustomerLoginUpdateDetails();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<CustomerLoginUpdateDetails> getLoginDetails() async {
    try {
      await setCookie();
      Response response = await dio.get('$baseUrl/users/authorize');
      return CustomerLoginUpdateDetails.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        CustomerLoginUpdateDetails result = new CustomerLoginUpdateDetails();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        CustomerLoginUpdateDetails result = new CustomerLoginUpdateDetails();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        CustomerLoginUpdateDetails result = new CustomerLoginUpdateDetails();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        CustomerLoginUpdateDetails result = new CustomerLoginUpdateDetails();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<UserProfile> getUserById({String userId}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/users/$userId');
      return UserProfile.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        UserProfile result = UserProfile();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        UserProfile result = UserProfile();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        UserProfile result = UserProfile();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        UserProfile result = UserProfile();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future getMyCompany({String userId}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/users/$userId');
      return response.data;
    } catch (e) {
      debugPrint("report post failed $e");
    }
  }

  Future<PostCustomerSignUp> updateUserDetails({
    String user_id,
    String name,
    String nic,
    String email,
    String address,
    /*   String companyId,
    String position, */
    String country,
    /*   String regNo,
    String jobRole, */
  }) async {
    try {
      Response response = await dio.put('$baseUrl/users/users/$user_id', data: {
        "user_id": user_id,
        "name": name,
        "nic": nic,
        "email": email,
        "address": address,
        /*    "company_id": companyId,
        "position": position, */
        "country": country,
        /*  "reg_no": regNo, */
        /*  "job_role": jobRole, */
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  //////////////////////
  ///
  ///
  Future<GetCompany> getCompanies() async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/companies');
      return GetCompany.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetCompany result = new GetCompany();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetCompany result = new GetCompany();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetCompany result = new GetCompany();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetCompany result = new GetCompany();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<PostCustomerSignUp> createProspect(
      {String user_id,
      String name,
      String nic,
      String date_of_birth,
      String address,
      String contact,
      String country_code,
      String occupation,
      String income,
      String email,
      String whatsapp,
      String gender,
      bool isMarried,
      String spouseName,
      String spousePhone,
      String spouseDob,
      String annivesary,
      String spouseNic,
      String spouseAddress,
      String spouseOccupation,
      List<dynamic> children}) async {
    try {
      /*  List<Child> prosChildren = new List();
      children.forEach((element) {
        Child child = Child.fromJson({
          'name': element.name,
          'dob': element.dob,
        });
        prosChildren.add(child);
      }); */

      // var formData = FormData.fromMap({'data': json.encode(children)});
      // var formData = jsonEncode(children);

      // await setCookie();
      Response response = await dio.post('$baseUrl/users/customer', data: {
        "user_id": user_id,
        "name": name,
        "nic": nic,
        "address": address,
        "contact": contact,
        "country_code": country_code,
        "email": email,
        "whatsapp": whatsapp,
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<PostCustomerSignUp> updateProspect(
      {String user_id,
      String pros_id,
      String name,
      String nic,
      String date_of_birth,
      String address,
      String contact,
      String country_code,
      String occupation,
      String income,
      String email,
      String whatsapp,
      String gender,
      bool isMarried,
      String spouseName,
      String spousePhone,
      String spouseDob,
      String annivesary,
      String spouseNic,
      String spouseAddress,
      String spouseOccupation,
      List<dynamic> children}) async {
    try {
      List<Child> prosChildren = new List();
      children.forEach((element) {
        Child child = Child.fromJson({
          'name': element.name,
          'dob': element.dob,
        });
        prosChildren.add(child);
      });

      // var formData = FormData.fromMap({'data': json.encode(children)});
      // var formData = jsonEncode(children);

      // await setCookie();
      Response response =
          await dio.put('$baseUrl/users/customer/$user_id/$pros_id', data: {
        "user_id": user_id,
        "name": name,
        "nic": nic,
        "date_of_birth": date_of_birth,
        "address": address,
        "contact": contact,
        "country_code": country_code,
        "email": email,
        "whatsapp": whatsapp,
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetProspects> getProspects({String userId}) async {
    try {
      // await setCookie();
      //Response response = await dio.get('$baseUrl/users/prospects/$userId');
      Response response = await dio.get('$baseUrl/users/customer/$userId');
      return GetProspects.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetProspects result = GetProspects();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetProspects result = GetProspects();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetProspects result = GetProspects();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetProspects result = GetProspects();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetProspects> getProspectsBySearch(
      {String userId, String search}) async {
    try {
      // await setCookie();
      Response response =
          await dio.get('$baseUrl/users/search_customer/$userId/$search');
      return GetProspects.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetProspects result = GetProspects();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetProspects result = GetProspects();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetProspects result = GetProspects();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetProspects result = GetProspects();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetProspects> getProspectsWithNoAppoints({String userId}) async {
    try {
      // await setCookie();
      Response response =
          await dio.get('$baseUrl/users/customer/no_app/$userId');
      return GetProspects.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetProspects result = GetProspects();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetProspects result = GetProspects();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetProspects result = GetProspects();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetProspects result = GetProspects();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetProspectById> getProspectById(
      {String userId, String prosId}) async {
    try {
      // await setCookie();
      Response response =
          await dio.get('$baseUrl/users/customer/$userId/$prosId');
      return GetProspectById.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetProspectById result = GetProspectById();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetProspectById result = GetProspectById();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetProspectById result = GetProspectById();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetProspectById result = GetProspectById();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetChildrenById> getChildrenById(
      {String userId, String prosId}) async {
    try {
      // await setCookie();
      Response response =
          await dio.get('$baseUrl/users/prospect_child/$userId/$prosId');
      return GetChildrenById.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetChildrenById result = GetChildrenById();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetChildrenById result = GetChildrenById();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetChildrenById result = GetChildrenById();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetChildrenById result = GetChildrenById();
        result.message = defaultMessage;
        return result;
      }
    }
  }

/* Appointments */
  Future<PostCustomerSignUp> createAppointment({
    String user_id,
    String pros_id,
    String date,
    // String time,
    String detail = "",
  }) async {
    try {
      Response response = await dio.post('$baseUrl/users/orders', data: {
        "user_id": user_id,
        "customer_id": pros_id,
        "date": date,
        //"time": time,
        "detail": detail
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetAppointments> getAppointments({String userId}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/orders/$userId');
      return GetAppointments.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetAppointments result = GetAppointments();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetAppointments result = GetAppointments();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetAppointments result = GetAppointments();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetAppointments result = GetAppointments();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetAppointmentById> getAppointmentId(
      {String userId, String id}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/orders/$userId/$id');
      return GetAppointmentById.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetAppointmentById result = GetAppointmentById();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetAppointmentById result = GetAppointmentById();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetAppointmentById result = GetAppointmentById();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetAppointmentById result = GetAppointmentById();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<PostCustomerSignUp> updateAppointment(
      {String id,
      String status,
      String prosId,
      String userId,
      String detail}) async {
    try {
      Response response = await dio.put('$baseUrl/users/orders', data: {
        "id": id,
        "status": status,
        "user_id": userId,
        "customer_id": prosId,
        "detail": detail,
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<PostCustomerSignUp> updateAppointmentById(
      {String id,
      String pros_id,
      String date,
      String time,
      String status}) async {
    try {
      Response response = await dio.put('$baseUrl/users/orders/$id', data: {
        "pros_id": pros_id,
        "date": date,
        "time": time,
        "status": status
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  /* Sales Interview */
  Future<PostCustomerSignUp> createSalesInterview({
    String user_id,
    String pros_id,
    String date,
    //String time,
  }) async {
    try {
      Response response = await dio.post('$baseUrl/users/sales', data: {
        "user_id": user_id,
        "pros_id": pros_id,
        "date": date,
        // "time": time,
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetAppointments> getInterviews({String userId}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/sales/$userId');
      return GetAppointments.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetAppointments result = GetAppointments();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetAppointments result = GetAppointments();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetAppointments result = GetAppointments();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetAppointments result = GetAppointments();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<PostCustomerSignUp> updateInterviews(
      {String id, String status}) async {
    try {
      Response response = await dio.put('$baseUrl/users/sales', data: {
        "id": id,
        "status": status,
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetAppointmentById> getInterviewById(
      {String userId, String id}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/sales/$userId/$id');
      return GetAppointmentById.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetAppointmentById result = GetAppointmentById();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetAppointmentById result = GetAppointmentById();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetAppointmentById result = GetAppointmentById();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetAppointmentById result = GetAppointmentById();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<PostCustomerSignUp> updateIntervieById(
      {String id,
      String prosId,
      String date,
      String time,
      String status}) async {
    try {
      Response response = await dio.put('$baseUrl/users/sales/$id', data: {
        "pros_id": prosId,
        "date": date,
        "time": time,
        "status": status
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  /* Todos */
  Future<PostCustomerSignUp> createTodo(
      {String user_id,
      String pros_id,
      String date,
      String time,
      String note,
      String reason}) async {
    try {
      Response response = await dio.post('$baseUrl/users/todo', data: {
        "user_id": user_id,
        "pros_id": pros_id,
        "date": date,
        "time": time,
        "reason": reason,
        "note": note
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetAppointments> getTodos({String userId}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/todo/$userId');
      return GetAppointments.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetAppointments result = GetAppointments();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetAppointments result = GetAppointments();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetAppointments result = GetAppointments();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetAppointments result = GetAppointments();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetAppointments> getTodosByDate(
      {String userId, String start, String end}) async {
    try {
      // await setCookie();
      Response response =
          await dio.get('$baseUrl/users/todo/$userId/$start/$end');
      return GetAppointments.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetAppointments result = GetAppointments();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetAppointments result = GetAppointments();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetAppointments result = GetAppointments();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetAppointments result = GetAppointments();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetAppointmentById> getTodoById({String userId, String id}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/todo/$userId/$id');
      return GetAppointmentById.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetAppointmentById result = GetAppointmentById();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetAppointmentById result = GetAppointmentById();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetAppointmentById result = GetAppointmentById();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetAppointmentById result = GetAppointmentById();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<PostCustomerSignUp> updateTodo({String id, String status}) async {
    try {
      Response response = await dio.put('$baseUrl/users/todo', data: {
        "id": id,
        "status": status,
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<PostCustomerSignUp> updateTodoById({
    String id,
    String pros_id,
    String date,
    String time,
    String status,
    String reason,
    String note,
  }) async {
    try {
      Response response = await dio.put('$baseUrl/users/todo/$id', data: {
        "pros_id": pros_id,
        "date": date,
        "time": time,
        "status": status,
        "reason": reason,
        "note": note
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  /* NOP */

  Future<PostCustomerSignUp> createNOP(
      {String user_id,
      String pros_id,
      String policy_no,
      String commence_date,
      String premium,
      String payType,
      List<dynamic> covers}) async {
    try {
      List<Coverage> coverageList = new List();
      covers.forEach((element) {
        Coverage child = Coverage.fromJson({
          'tag': element.tag,
          'cover_for': element.cover_for,
        });
        coverageList.add(child);
      });

      Response response = await dio.post('$baseUrl/users/nop', data: {
        "user_id": user_id,
        "pros_id": pros_id,
        "policy_no": policy_no,
        "commence_date": commence_date,
        "premium": premium,
        "pay_type": payType,
        "coverage": coverageList
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<PostCustomerSignUp> updateNOP(
      {String user_id,
      String pros_id,
      String policy_no,
      String commence_date,
      String premium,
      String payType,
      String id,
      List<dynamic> covers}) async {
    try {
      List<Coverage> coverageList = new List();
      covers.forEach((element) {
        Coverage child = Coverage.fromJson({
          'tag': element.tag,
          'cover_for': element.cover_for,
        });
        coverageList.add(child);
      });

      Response response = await dio.put('$baseUrl/users/nop/$id', data: {
        "user_id": user_id,
        "pros_id": pros_id,
        "policy_no": policy_no,
        "commence_date": commence_date,
        "premium": premium,
        "pay_type": payType,
        "coverage": coverageList
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  //Have plan
  Future<UserPlans> getProspectsWithPlan({String userId, String search}) async {
    try {
      // await setCookie();
      Response response =
          await dio.get('$baseUrl/users/nop_prospects/$userId?search=$search');
      return UserPlans.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        UserPlans result = UserPlans();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        UserPlans result = UserPlans();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        UserPlans result = UserPlans();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        UserPlans result = UserPlans();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  // get plans by pros

  Future<MultiplePlans> getPlansByPros({String prosId}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/plan/$prosId');
      return MultiplePlans.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        MultiplePlans result = MultiplePlans();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        MultiplePlans result = MultiplePlans();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        MultiplePlans result = MultiplePlans();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        MultiplePlans result = MultiplePlans();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  //No plan
  Future<GetProspects> getProspectsWithNoPlan(
      {String userId, String search}) async {
    try {
      // await setCookie();
      Response response = await dio
          .get('$baseUrl/users/nop_no_prospects/$userId?search=$search');
      return GetProspects.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetProspects result = GetProspects();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetProspects result = GetProspects();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetProspects result = GetProspects();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetProspects result = GetProspects();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  // anual plans

  Future<PostCustomerSignUp> createAnnualPlan(
      {String user_id, String year, List<dynamic> children}) async {
    try {
      List<Plan> prosChildren = new List();
      children.forEach((element) {
        Plan _plan = Plan.fromJson({
          'month': element.month,
          'pros': element.pros,
          'app': element.app,
          'sale': element.sale,
          'follow': element.follow,
          'nop': element.nop,
          'anbp': element.anbp
        });
        prosChildren.add(_plan);
      });

      Response response = await dio.post('$baseUrl/users/annual_plan', data: {
        "user_id": user_id,
        "year": year,
        "annual_plans_list": prosChildren
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetAnnualPlans> getAnnualPlans({String userId, String year}) async {
    try {
      // await setCookie();
      Response response =
          await dio.get('$baseUrl/users/annual_plan/$userId/$year');
      return GetAnnualPlans.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetAnnualPlans result = GetAnnualPlans();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetAnnualPlans result = GetAnnualPlans();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetAnnualPlans result = GetAnnualPlans();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetAnnualPlans result = GetAnnualPlans();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<AnalyseData> getAnalyse({String userId}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/analyze/$userId');
      return AnalyseData.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        AnalyseData result = AnalyseData();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        AnalyseData result = AnalyseData();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        AnalyseData result = AnalyseData();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        AnalyseData result = AnalyseData();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetPlanById> getPlanById({String userId, String id}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/plan/$userId/$id');
      return GetPlanById.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetPlanById result = GetPlanById();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetPlanById result = GetPlanById();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetPlanById result = GetPlanById();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetPlanById result = GetPlanById();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetPlanCoversById> getPlanCoverById({String id}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/nop_coverage/$id');
      return GetPlanCoversById.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetPlanCoversById result = GetPlanCoversById();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetPlanCoversById result = GetPlanCoversById();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetPlanCoversById result = GetPlanCoversById();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetPlanCoversById result = GetPlanCoversById();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  // report

  Future<MonthReport> getMonthReport(
      {String userId, String year, String month}) async {
    try {
      // await setCookie();
      Response response =
          await dio.get('$baseUrl/users/report/$userId/$year/$month');
      return MonthReport.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        MonthReport result = MonthReport();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        MonthReport result = MonthReport();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        MonthReport result = MonthReport();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        MonthReport result = MonthReport();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<AnualReport> getAnnualReport(
      {String userId, String year, String month}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/report/$userId/$year');
      return AnualReport.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        AnualReport result = AnualReport();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        AnualReport result = AnualReport();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        AnualReport result = AnualReport();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        AnualReport result = AnualReport();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  //Leaderboard

  Future<MemberByContact> getMemberByContact(
      {String userId, String contact}) async {
    try {
      // await setCookie();
      Response response =
          await dio.get('$baseUrl/users/leaderboard/$userId/$contact');
      return MemberByContact.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        MemberByContact result = MemberByContact();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        MemberByContact result = MemberByContact();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        MemberByContact result = MemberByContact();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        MemberByContact result = MemberByContact();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<PostCustomerSignUp> sendMemberReq({
    String user_id,
    String member_id,
  }) async {
    try {
      Response response = await dio.post('$baseUrl/users/leaderboard', data: {
        "user_id": user_id,
        "member_id": member_id,
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<LeaderMembers> getMyMembers({String userId}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/leaderboard/$userId');
      return LeaderMembers.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        LeaderMembers result = LeaderMembers();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        LeaderMembers result = LeaderMembers();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        LeaderMembers result = LeaderMembers();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        LeaderMembers result = LeaderMembers();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<LeadersRequests> getLeaderReq({String userId}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/request/$userId');
      return LeadersRequests.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        LeadersRequests result = LeadersRequests();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        LeadersRequests result = LeadersRequests();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        LeadersRequests result = LeadersRequests();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        LeadersRequests result = LeadersRequests();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<PostCustomerSignUp> acceptRequest({String id, String status}) async {
    try {
      Response response = await dio.put('$baseUrl/users/leaderboard', data: {
        "id": id,
        "status": status,
      });
      return PostCustomerSignUp.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PostCustomerSignUp result = new PostCustomerSignUp();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetAppointments> getAppointmentByDate(
      {String userId, String start, String end}) async {
    try {
      // await setCookie();
      Response response =
          await dio.get('$baseUrl/users/orders/$userId/$start/$end');
      return GetAppointments.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetAppointments result = GetAppointments();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetAppointments result = GetAppointments();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetAppointments result = GetAppointments();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetAppointments result = GetAppointments();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  Future<GetAppointments> getInterviewsByDate(
      {String userId, String start, String end}) async {
    try {
      // await setCookie();
      Response response =
          await dio.get('$baseUrl/users/sales/$userId/$start/$end');
      return GetAppointments.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        GetAppointments result = GetAppointments();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        GetAppointments result = GetAppointments();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        GetAppointments result = GetAppointments();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        GetAppointments result = GetAppointments();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  // dob list
  Future<DobList> getDobList({String userId, String date}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/dob/$userId/$date');
      return DobList.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        DobList result = DobList();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        DobList result = DobList();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        DobList result = DobList();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        DobList result = DobList();
        result.message = defaultMessage;
        return result;
      }
    }
  }

  // premium list
  Future<PremiumList> getPremiumList({String userId, String date}) async {
    try {
      // await setCookie();
      Response response = await dio.get('$baseUrl/users/premium/$userId/$date');
      return PremiumList.fromJson(response.data);
    } catch (e) {
      if (e.response.statusCode == 400) {
        PremiumList result = PremiumList();
        result.message = 'Bad Request.';
        return result;
      } else if (e.response.statusCode == 401) {
        PremiumList result = PremiumList();
        result.message = 'Unauthorize.';
        return result;
      } else if (e.response.statusCode == 503) {
        PremiumList result = PremiumList();
        result.message = 'Service Unavailable.';
        return result;
      } else {
        PremiumList result = PremiumList();
        result.message = defaultMessage;
        return result;
      }
    }
  }
}
