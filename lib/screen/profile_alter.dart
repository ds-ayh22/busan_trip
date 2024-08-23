import 'package:flutter/material.dart';
import 'package:busan_trip/model/profile_alter_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAlterScreen extends StatefulWidget {
  @override
  _ProfileAlterScreenState createState() => _ProfileAlterScreenState();
}

class _ProfileAlterScreenState extends State<ProfileAlterScreen> {
  final ProfileAlterModel profile = ProfileAlterModel(
   /* profileImage: 'https://example.com/your_profile_image.jpg',*/
    profileImage: 'assets/images/default_profile.jpg',  // 여기에서 로컬 이미지 경로를 사용합니다.
    age: 25,
    name: 'John Doe',
    nickname: 'Johnny',
    phoneNumber: '010-1234-5678',
    address: '123 Main St, Seoul, Korea',
    email: 'john.doe@example.com',
    birthdate: '1995-05-15',
  );

  late TextEditingController nameController;
  late TextEditingController nicknameController;
  late TextEditingController ageController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  late TextEditingController emailController;
  late TextEditingController birthdateController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: profile.name);
    nicknameController = TextEditingController(text: profile.nickname);
    ageController = TextEditingController(text: profile.age.toString());
    phoneNumberController = TextEditingController(text: profile.phoneNumber);
    addressController = TextEditingController(text: profile.address);
    emailController = TextEditingController(text: profile.email);
    birthdateController = TextEditingController(text: profile.birthdate);
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profile.setProfileImage(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 변경', style: TextStyle(
          fontFamily: 'NotoSansKR',
          fontWeight: FontWeight.w500,
          fontSize: 23,
          color: Colors.black,
        )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(profile.profileImage),  // 수정된 부분
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.edit, color: Colors.black, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildProfileItem('이름', nameController),
            buildProfileItem('닉네임', nicknameController),
            buildProfileItem('나이', ageController, TextInputType.number),
            buildProfileItem('전화번호', phoneNumberController, TextInputType.phone),
            buildProfileItem('주소', addressController),
            buildProfileItem('이메일', emailController, TextInputType.emailAddress),
            buildProfileItem('생년월일', birthdateController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 프로필 저장 로직
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,  // 파란색 배경
              ),
              child: Text('수정 하기', style: TextStyle(
                fontFamily: 'NotoSansKR',
                color: Colors.white,  // 글씨 색을 흰색으로
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(String labelText, TextEditingController controller, [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 14,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.chevron_right, color: Colors.grey),
        ),
        style: TextStyle(
          fontFamily: 'NotoSansKR',
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
