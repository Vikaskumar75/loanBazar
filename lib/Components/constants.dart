import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final kAppBarStyle = TextStyle(
  fontSize: 22.0,
);

final kTextFieldTitle = TextStyle(
  color: Color(0xFF0B295D),
  fontSize: 20.0,
);

final kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
);

final kDropDownHint = TextStyle(
  color: Colors.grey[500],
  fontFamily: 'Lora',
  fontSize: 12.0,
);

final kDropDownList = TextStyle(
  color: Colors.deepOrange[400],
  fontFamily: 'Lora',
  fontSize: 18.0,
);

class LegalItem {
  String headerValue;
  String bodyValue;

  LegalItem({this.headerValue, this.bodyValue});
}

List<LegalItem> legalInfo = [
  LegalItem(
      headerValue: 'Privacy Policy',
      bodyValue:
          'The Loan Guides app is an Ad Supported app. \nThis SERVICE is provided by at no cost and is intended for use as is.This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. \nThe Personal Information that I collect is used for providing and improving the Service. \nI will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Loan Bazaar unless otherwise defined in this Privacy Policy.'),
  LegalItem(
      headerValue: 'Information Collection and Use',
      bodyValue:
          'For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited. The information that I request will be retained on your device and is not collected by me in any way.The app does use third party services that may collect information used to identify you.Link to privacy policy of third party service providers used by the app \n\nGoogle Play Services\nGoogle Analytics for Firebase\nFirebase Crashlytics\n\nI want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.'),
  LegalItem(
    headerValue: 'Cookies',
    bodyValue:
        'Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device\'s internal memory.\n\nThis Service does not use these \“cookies\” explicitly. However, the app may use third party code and libraries that use \“cookies\” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.',
  ),
  LegalItem(
    headerValue: 'Service Providers',
    bodyValue:
        'I may employ third-party companies and individuals due to the following reasons:\n\nTo facilitate our Service;\nTo provide the Service on our behalf;\nTo perform Service-related services; or\nTo assist us in analyzing how our Service is used.\nI want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.',
  ),
  LegalItem(
    headerValue: 'Security',
    bodyValue:
        'I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.',
  ),
  LegalItem(
    headerValue: 'Links to other sites',
    bodyValue:
        'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.',
  ),
  LegalItem(
      headerValue: 'Children\'s Privacy Policy',
      bodyValue:
          'These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do necessary actions.'),
  LegalItem(
    headerValue: 'Changes to This Privacy Policy',
    bodyValue:
        'I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.\nThis policy is effective as of 2020-11-03',
  ),
  LegalItem(
    headerValue: 'Contact us',
    bodyValue:
        'If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at:\nloanguidesavi@gmail.com.',
  ),
];

List<String> item = [
  'Personal Loan',
  'Home Loan',
  'Business Loan',
  'Aadhaar Loan',
  'Student Loan',
  'Bank Loan',
];

List<FaIcon> leadingIcon = [
  FaIcon(
    FontAwesomeIcons.user,
    color: Color(0xFF0B295D),
  ),
  FaIcon(
    FontAwesomeIcons.home,
    color: Color(0xFF0B295D),
  ),
  FaIcon(
    FontAwesomeIcons.fax,
    color: Color(0xFF0B295D),
  ),
  FaIcon(
    FontAwesomeIcons.idCard,
    color: Color(0xFF0B295D),
  ),
  FaIcon(
    FontAwesomeIcons.userGraduate,
    color: Color(0xFF0B295D),
  ),
  FaIcon(
    FontAwesomeIcons.university,
    color: Color(0xFF0B295D),
  ),
];

BoxDecoration kCoverImageDecorator = BoxDecoration(
  color: Colors.grey[350],
  borderRadius: BorderRadius.all(
    Radius.circular(10.0),
  ),
);

final kCardAppName = TextStyle(color: Colors.grey[400], fontSize: 24.0);

final kCardDescription = TextStyle(
  fontSize: 16.0,
);

final kCardButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 12.0,
);

final kUserDisplayDescription = TextStyle(
  fontSize: 22.0,
  color: Colors.grey[850],
);

final kCategoryCardStyle = TextStyle(color: Color(0xFF0B295D), fontSize: 20);

final kAlertDeleteTextStyle =
    TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold);

final kCollapsibleHeaderStyle =
    TextStyle(color: Color(0xFF0B295D), fontSize: 16.0);

final kAboutBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  border: Border.all(
    color: Color(0xFF0B295D),
  ),
  color: Colors.white38,
  boxShadow: [
    BoxShadow(
      color: Colors.grey[300],
      blurRadius: 8.0, // soften the shadow
      spreadRadius: 5.0, //extend the shadow
      offset: Offset(
        5.0, // Move to right 10  horizontally
        5.0, // Move to bottom 10 Vertically
      ),
    ),
  ],
);

final String kInterstitialAdId = '227084222477185_2459450772577';
final String kBannerAdId = '227084222477185_227085865810354';
