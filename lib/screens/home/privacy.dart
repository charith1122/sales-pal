import 'package:flutter/material.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/screens/home/home.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key key}) : super(key: key);

  // final String title;

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR_NEW,
        actions: [
          IconButton(
              icon: Icon(
                Icons.home_filled,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false,
                );
              })
        ],
        centerTitle: true,
        title: Text('Privacy Policy',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.SECONDARY_COLOR_NEW,
      body: Container(
        margin: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: AppStyles.subHeader,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'Prosbot Company built the Prosbot app as a Free app. This SERVICE is provided by Prosbot Company at no cost and is intended for use as is.\n\nThis page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.\n\nIf you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.\n\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Prosbot unless otherwise defined in this Privacy Policy.',
                style: TextStyle(color: Colors.grey[850]),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Information Collection and Use',
                style: AppStyles.subHeader,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to Prosbot. The information that we request will be retained by us and used as described in this privacy policy.\n\n The app does use third-party services that may collect information used to identify you.',
                style: TextStyle(color: Colors.grey[850]),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Log Data',
                style: AppStyles.subHeader,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.',
                style: TextStyle(color: Colors.grey[850]),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Cookies',
                style: AppStyles.subHeader,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device\'s internal memory.\n\nThis Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.',
                style: TextStyle(color: Colors.grey[850]),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Service Providers',
                style: AppStyles.subHeader,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'We may employ third-party companies and individuals due to the following reasons:\n\nTo facilitate our Service;\nTo provide the Service on our behalf;\nTo perform Service-related services; or\nTo assist us in analyzing how our Service is used.\n\n We want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.',
                style: TextStyle(color: Colors.grey[850]),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Security',
                style: AppStyles.subHeader,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.',
                style: TextStyle(color: Colors.grey[850]),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Links to Other Sites',
                style: AppStyles.subHeader,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.',
                style: TextStyle(color: Colors.grey[850]),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Children\'s Privacy',
                style: AppStyles.subHeader,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13 years of age. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do the necessary actions.',
                style: TextStyle(color: Colors.grey[850]),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Changes to This Privacy Policy',
                style: AppStyles.subHeader,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.\nThis policy is effective as of 2022-10-20',
                style: TextStyle(color: Colors.grey[850]),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Contact Us',
                style: AppStyles.subHeader,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at prosbotapp@gmail.com.',
                style: TextStyle(color: Colors.grey[850]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
