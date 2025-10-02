// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(backgroundColor: AppColors.grey),
      body: Stack(
        children: [
          SizedBox(height: height, width: width),
          Scrollbar(
            interactive: true,
            trackVisibility: true,
            radius: Radius.circular(5),
            thickness: 35,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 100,
                        child: Image.asset('assets/Images/slr_logo.png'),
                      ),
                    ),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(text, style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String text =
      '''Slr Shoppee Private Limited (“SLRSPL” or “we”) takes the privacy of your information seriously. This Privacy Notice describes the types of personal information we collect from you through our stores, website (including sub-domains and microsites) and mobile applications. It also describes the purposes for which we collect that personal information, the other parties with whom we may share it and the measures we take to protect the security of your data. It also tells you about your rights and choices with respect to your personal information, and how you can contact us about our privacy practices.[1]
You are advised to carefully read this Privacy Notice before using or availing any of our products and/or services.
DEFINITIONS
In this Privacy Notice, the following definitions are used:
Cookies
a small file placed on your device by our website or mobile application when you either visit or use certain features of our website or mobile application. A cookie generally allows a website to remember your actions or preference for a certain period of time.
Data
includes non-personal information, personal information and sensitive personal information about you, which either directly or indirectly in combination with other information, could allow you to be identified when you visit our stores, website and/or mobile application.
Data Protection Laws
any applicable law for the time being in force relating to the processing of Data.
Partners
select third parties (including SlrShoppee Entities) with whom we have contracts for the businesses described in this Privacy Notice.
Service Providers
includes entities to whom we or other SlrShoppee Group Entities will disclose your Data in order to process information for a specific purpose pursuant to written contract.
SlrShoppee Private Limited
SLRSPL, a company incorporated in India whose registered office is at Thrissur, No. 385,3RD  Floor, Moonupeedika ,Perinjanam P O, kerala, Thrissur-680686, India
SlrShoppee Group Entity
SlrShoppee Private Limited, and its subsidiaries, affiliates, associate companies and joint venture companies with whom we have a contractual arrangement to, inter alia, share data for the purposes described in this Privacy Notice.
User or you
who accesses our stores, website or mobile application.

[1] Refer to Rule 4 of the IT Rules

WHAT DATA DO WE COLLECT ABOUT YOU
SLRSPL collects Data for various purposes set out in this Privacy Notice.
This Data includes, without limitation, the following categories[2]:
•	Contact information: first and last name, email address, postal address, country, employer, phone number and other similar contact data.
•	Financial information: payment instrument information, transactions, transaction history, preferences, method, mode and manner of payment, spending pattern or trends, and other similar data.
•	Technical information: website, device and mobile app usage, Internet Protocol (IP) address and similar information collected via automated means, such as cookies, pixels and similar technologies.
•	Transaction information: the date of the transaction, total amount, transaction history and preferences and related details.
•	Product and service information: Your account membership number, registration and payment information, and program-specific information, when you request products and/or services directly from us, or participate in marketing programs.
•	Personal information: Age, sex, date of birth, marital status, nationality, details of government identification documents provided, occupation, ethnicity, religion, travel history or any other personal information provided in responses to surveys or questionnaires.
•	Your reviews, feedback and opinions about our products, programmes and services.
 Loyalty programme information: your loyalty membership information, account details, profile or password details and any frequent flyer or travel partner programme affiliation.
HOW WE COLLECT DATA
 We collect Data in the following ways:
•	Information You Give Us:We receive and store any information you enter on our website or mobile application or give us in any other way (e.g., at outlets, stores, hotels, kiosks). Please see the section titled “Data Shared by You” for more information.
•	Automatic Information We Collect:We use “cookies”, pixels and similar technologies to receive and store certain types of information whenever you interact with us. Please see the section below, titled “Data that is Collected Automatically” for more information.
•	E-mail Communications:To help us make e-mails more relevant and interesting, we often receive a confirmation (if your device supports such capabilities) when you open e-mail from us or click on a link in the e-mail. You can choose not to receive marketing emails from us by clicking on the unsubscribe link in any marketing email.
[2] Refer to Rule 2(i), Rule 3 and Rule 4(ii) of the IT Rules

•	Automatic Information We Collect from Other Websites: We receive and store certain types of information when you interact with third-party websites that use our technology or with whom we have a specific agreement. Because we process this information on behalf of the applicable website operators, collection, processing, and use of such information is subject to the applicable website operators’ privacy policies and is not covered by our Privacy Notice.
•	Information from Other Sources: We may obtain information from other sources. An example of this is when you authorize a third-party website (such as the website of another SLRSPL Group Entity), to interact directly with our website or mobile application to provide or receive Data about you. In that case, we might receive such Data used by that third-party website to identify your account with that website.
•	Information Previously Provided to SLRSPL Group Entities: Where you have shared any information previously with any of the SLRSPL Group Entities and have consented to the further sharing of such information, such information will be shared with us by the SLRSPL Group Entities.
You can make choices about our collection and use of your Data. For example, you may want to access, edit or remove your Data on our website or mobile application. When you are asked to provide Data, you may decline.[3]
DATA SHARED BY YOU[4]
SlrShoppee may collect your Data in several ways from your use of our stores, website or mobile application. For instance:
•	when you register with us to receive our products and/or services;
•	when you conduct a transaction with us or attempt a transaction at our stores, on our website or mobile application;
•	when you complete surveys conducted by or for us;
•	when you elect to receive any communications (including promotional offers) from us;
•	from the information gathered by your visit to our stores, website or mobile application;
DATA THAT IS COLLECTED AUTOMATICALLY[5]
•	We automatically collect some information when you visit our website or use our mobile application. This information helps us to make improvements to our content and navigation. The information collected automatically includes your IP address.
•	Our web servers or affiliates who provide analytics and performance enhancement services collect IP addresses, operating system details, browsing details, device details and language settings. This information is aggregated to measure the number of visits, average time spent on the site, pages viewed and similar information. SLRSPL uses this information to measure the site usage, improve content and to ensure safety and security, as well enhance performance of our website or mobile application.
•	We may collect your Data automatically via Cookies, pixels and similar technologies in line with settings on your browser. For more information about Cookies, please see the section below, titled “Cookies”.

[3] Refer to Rule 5(6) and 5(7) of the IT Rules
[4] Refer to Rule 5(3) of the IT Rules
[5] Refer to Rule 5(3) of the IT Rules
OUR USE OF DATA
Any or all the above Data may be required by us from time to time to provide information relating to SLRSPL and to work on the experience when using our website or mobile application. Specifically, Data may be used by us for the following reasons:
•	carry out our obligations arising from any contract entered into between you and us;
•	provide products and/or services and communicate with you about products and/or services offered by us;
•	enable SLRSPL Group Entities and Partners to offer their products and/or services and communicate with you about such products and/or services;
•	processing, disclosing, transmitting, and/or sharing the data/information with Slrshoppee Group Entities, and other third parties which have business or contractual dealings with us;
•	provide you with offers (including for financial products and/or services), personalized services and recommendations and improve your experience on our website and mobile application;
•	operate, evaluate and improve our business, website and mobile application;
•	generate aggregated data to prepare insights to enable us to understand customer behavior, patterns and trends with a view to learning more about your preferences or other characteristics;
•	provide privileges and benefits to you, marketing and promotional campaigns based on your profile;
•	in connection with loyalty programs owned and operated by us or by other SlrShoppee Entities;
•	communicate with you (including to respond to your requests, questions, feedback, claims or
disputes) and to customize and improve our services;	
•	enforce the terms of use of our website and mobile application;
•	protect against and prevent fraud, illegal activity, harm, financial loss and other legal or information security risks; and
•	serve other purposes for which we provide specific notice at the time of collection, and as otherwise authorized or required by applicable law.
We treat these inferences as personal information (or sensitive personal information, as the case may be), where required under applicable law. Some of the above grounds for processing will overlap and there may be several grounds which justify our use of your personal information.
Where required under applicable law, we will only use your personal information with your consent; as necessary to provide you with products and/or services; to comply with a legal obligation; or when there is a legitimate interest that necessitates the use.[6]
MINORS
Our website and mobile application do not offer products or services for use by minors. If you are under 18, you may use our website or mobile application only with the involvement of a parent or guardian.
SHARING OF DATA
We may share your Data with for
•	Partners:We may make available to you services, products, or applications provided by Partners for use on or through our website or mobile application. If you choose to use such service, customer information related to those transactions may be shared with such Partner. 
[6] Refer to Rule 5(1), Rule 5(2) and Rule 5(5) of the IT Rules
Such Partners will be required to respect the security of your Data and to treat it in accordance with this privacy policy and applicable law[7].
•	SLRSPL Group Entities: We may make available to you products, services and /or applications of SLRSPL Group Entities, to assist them to reach out to you in relation to their programs or campaigns and to process your queries and requests. Accordingly, we may share your Data with SLRSPL Group Entities. We may also share your Data with the SLRSPL Group Entities as is relevant for the purposes set out in Clause 7 above, and to facilitate the operation of our business.
•	Slrshoppee Consumer Platform: Your Data may be shared with SLRSPL Group Entities and other participating entities on the SlrShoppee Consumer Platform operated by SLRSPL (“SLRCP”) for purposes of enrolment, offering you products, services and benefits on the SLRCP. Accordingly, we may share your Data with other SLRSPL Group Entities, Partners and Service Providers.
•	Service Providers: We or other SLRSPL Group Entities may share your Data with Service Providers. Examples include storing and analyzing Data, protecting and securing our systems, providing search results and links, providing customer service, credit analysis, processing your information for profiling, user analysis and payment processing.
These Service Providers will be required to only process Data in accordance with express instructions and as necessary to perform services for purposes set forth in this Privacy Notice. The Service Providers will also be required to safeguard the security and confidentiality of the Data they process by implementing appropriate technical and organizational security measures and confidentiality obligations binding employees accessing Data.[8]
•	When SLRSPL acts as a Service Provider: We may process and share your Data with SlrShoppee Group Entities and Partners when we act as a service provider to such SLRSPL Group Entities and Partners.
•	Protecting SLRSPL:We may release Data when we believe release is appropriate to comply with applicable law or legal process, enforce or apply the SLRSPL of our website or mobile application and other agreements, protect SLRSPL against harm or financial loss, when we believe disclosure is necessary to protect individuals’ vital interests, or in connection with an investigation of suspected or actual fraudulent or illegal activity. This may include exchanging information with other companies and organizations for fraud protection, risk management and dispute resolution. This does not include selling or otherwise disclosing personally identifiable information from users for commercial purposes in violation of this Privacy Notice.[9]
Business Transfers: As we continue to develop our business, we might sell or buy subsidiaries or business units. Your Data (including in relation to loyalty programs) may be transferred as part of such transaction.
•	Third Parties: We may also share your Data with other third parties where:
1.	You request or authorize us to do so;
2.	We need to comply with applicable law or respond to valid legal process; or
3.	We need to operate and maintain the security of our website or mobile application, including to prevent or stop an attack on our computer systems or networks.
We require these third parties by contract to only process sensitive personal data in accordance with our instructions and as necessary to perform services on our behalf or in compliance with applicable law. We also require them to safeguard the security and confidentiality of the sensitive personal data they process on our behalf by implementing appropriate confidentiality, technical and organizational security measures.[10]

[7] Refer to Rule 7 of the IT Rules
[8] Refer to Rule 7 of the IT Rules
[9] Refer to Rule 6 of the IT Rules

Please note that SLRShoppee Group Entities and Partners may have privacy practices that differ from those of SLRSPL. The use of your Data will be governed by their privacy statements when you provide Data on their websites.
KEEPING DATA SECURE
We will use technical and organizational measures to safeguard your Data and we store your Data on secure servers. Technical and organizational measures include measures to deal with any suspected data breach. If you suspect any misuse or loss or unauthorized access to your Data, please let us know immediately by contacting us by e-mail.[11]
RETENTION OF DATA
SLRSPL retains Data for as long as necessary for the use of our products and/or services or to provide access to and use of our website or mobile application, or for other essential purposes such as complying with our legal obligations, resolving disputes, enforcing our agreements and as long as processing and retaining your Data is necessary for our legitimate interests. Because these needs can vary for different data types and purposes, actual retention periods can vary significantly.[12]
Even if we delete your Data, including on account of exercise of your right under Clause 12 below, it may persist on backup or archival media for audit, legal, tax or regulatory purposes.
YOUR RIGHTS AND CHOICES
When we process Data about you, we do so with your consent and/or as necessary to operate our business, meet our contractual and legal obligations, protect the security of our systems and our customers, or fulfil other legitimate interests of SLRSPL as described in this Privacy Notice.
We may transfer Data we collect about you to recipients in India, where we are headquartered. India may not have the same Data Protection Laws as the country in which you initially provided the information. When we transfer your Data to India, we will protect that information as described in this Privacy Notice, as disclosed to you at the time of data collection or as described in our program-specific privacy notice.
Depending on which Data Protection Laws are applicable to you, you may have the right or choice to[13]:
•	opt-out of some collection or uses of your Data, including the use of cookies, pixels and similar technologies and the use of your Data for marketing purposes.
•	access your Data, rectify it, restrict or object to its processing, or request its deletion or anonymization.
•	change or edit information submitted to us.
•	receive the Data you provided to us to transmit it to another company.
•	withdraw any consent provided or alter your preferences.
•	where applicable, lodge a complaint with your supervisory authority.

[10] Refer to Rule 7 of the IT Rules.
[11] Refer to Rule 8 of the IT Rules.
[12] Refer to Rule 5(4) of the IT Rules.
[13] Refer to Rule 5(6) and Rule 5(7) of the IT Rules.

You may submit a request as described in the “How to Contact Us” section below. We will not charge you for any request. Where we are legally permitted to do so, we may refuse your request. If we refuse your request, we will tell you the reasons why.
Below, you will find additional privacy information that you may find important. Data Protection Laws, depending on your country, may include the following rights in relation to your Data[14]:
1.	Right to Confirmation and Access - the right to confirm our methods of processing and request
(i) copies of the information we hold about you at any time, or
(ii) that we modify, update or delete such information.
1.	Right to Correction - the right to have your Data rectified if it is inaccurate or incomplete.
2.	Right to be Forgotten - the right to request that we delete or remove your Data from our systems.
3.	Right to Restrict / Object to Our Use of your Data - the right to limit the way in which we can use it.
4.	Right to Data Portability - the right to request that we move, copy or transfer your Data.
5.	Right to Withdraw Consent – the right to withdraw your consent provided earlier.
6.	Right to File Complaints – the right to raise complaints to a regulatory authority.
For information about managing your Data and promotional communications, please e-mail us at grievanceofficer@slrshoppee.com
It is important that the Data we hold about you is accurate and current. Please keep 
us informed if your personal information changes during the period for which we hold it.[15]
WHERE WE STORE DATA
Data collected under this Privacy Notice is hosted on servers located in India.
PROCESSING YOUR DATA
We take steps to ensure that the Data we collect under this Privacy Notice is processed according to the provisions of this Privacy Notice and the requirements of applicable law.
To ensure that your Data receives an adequate level of protection, we have put in place appropriate written contracts with SlrShoppee Entities, Partners and Service Providers that we share your Data with. This ensures your Data is treated by such parties in a way that is consistent with applicable law.[16]
SEVERABILITY
If any court or competent authority finds that any provision of this Privacy Notice (or part of any provision) is invalid, illegal or unenforceable, that provision or part-provision will, to the extent required, be deemed to be deleted, and the validity and enforceability of the other provisions of this Privacy Notice will not be affected.
[14] Refer to Rule 5(6) and Rule 5(7) of the IT Rules.
[15] Refer to Rule 5(6) of the IT Rules.
[16] Refer to Rule 7 of the IT Rules.
CHANGES TO THIS PRIVACY NOTICE
Our business changes constantly and our Privacy Notice will change also. We may e-mail periodic reminders of our notices and conditions, unless you have instructed us not to, but you should check our website and mobile application frequently to see recent changes. The updated version will be effective as soon as it is accessible. Any changes will be immediately posted on our website and mobile application and you are deemed to have accepted the terms of the updated Privacy Notice on your first use of our website or mobile application or first purchase of the products and/or services following the alterations. We encourage you to review this Privacy Notice frequently to be informed of how we are protecting your information.
HOW TO CONTACT US
To request to review, update, or delete your personal information or to otherwise reach us, please submit a request by e-mailing us at grievanceofficer@slrshoppee.com. You may contact us for information on Service Providers, Partners and SlrShoppee Group Entities with whom we may share your Data in compliance with this Privacy Notice and applicable law. We will respond to your request within 30 days.
GRIEVANCE OFFICER
Please see below the details of our grievance officer[18]:
Name: Balkees Raouf
Email: grievanceofficer@slrshoppee.com; balkees_raouf@slrshoppee.com
SLRSPL, a company incorporated in India whose registered office is at Trissur, No. 385,3RD  Floor, Moonupeedika ,Perinjanam P O, Kerala, Thrissur-680684, India

[17] Refer to Rule 5(6), Rule 5(7) and Rule 5(9) of the IT Rules.
[18] Refer to Rule 5(9) of the IT Rules.

''';
}

class T2 extends StatelessWidget {
  const T2({super.key, required this.t1});

  final String t1;

  @override
  Widget build(BuildContext context) {
    return Text(
      t1,
      style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.9)),
    );
  }
}

class T1 extends StatelessWidget {
  final String t;
  const T1({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    return Text(t, style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold));
  }
}
