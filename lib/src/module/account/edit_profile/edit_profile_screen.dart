import '../../../../import.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfileProvider = context.read<EditProfileProvider>();
    // final editProfileProviderWatch = context.watch<EditProfileProvider>();
    // final selectedGender = editProfileProvider.selectedGender;
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const CommonTextWidget(
          title: 'Edit Profile',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 40.0),
            child: Icon(Icons.search, size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: const Border(
                  bottom: BorderSide(style: BorderStyle.none),
                ),
                color: cWhiteColor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      EditProfileTextForm(
                          controller: editProfileProvider.firstName,
                          hintText: 'Sandeep',
                          labelText: 'First Name'),
                      sizedBoxHeight20,
                      EditProfileTextForm(
                          controller: editProfileProvider.lastName,
                          hintText: 'Abraham',
                          labelText: 'Last Name'),
                      sizedBoxHeight20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextWidget(
                            title: "Your Gender*",
                            fontSize: 12,
                            color: cBorderGrey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RadioOptionWidget(
                                label: 'Male',
                                value: 'Male',
                                groupValue: editProfileProvider.selectedGender,
                                onChanged: (value) {
                                  editProfileProvider.selectGender(value!);
                                },
                              ),
                              RadioOptionWidget(
                                label: 'Female',
                                value: 'Female',
                                groupValue: editProfileProvider.selectedGender,
                                onChanged: (value) {
                                  editProfileProvider.selectGender(value!);
                                },
                              ),
                              RadioOptionWidget(
                                label: 'Others',
                                value: 'Others',
                                groupValue: editProfileProvider.selectedGender,
                                onChanged: (value) {
                                  editProfileProvider.selectGender(value!);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      sizedBoxHeight20,
                      EditProfileTextForm(
                        controller: editProfileProvider.emailAddress,
                        hintText: 'sandeepabraham@gmail.com',
                        labelText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      sizedBoxHeight20,
                      EditProfileTextForm(
                        controller: editProfileProvider.mobileNumber,
                        hintText: '8790223443',
                        labelText: 'Mobile Number',
                        keyboardType: TextInputType.phone,
                      ),
                      sizedBoxHeight20,
                      CommonButtonWidget(
                        title: 'SAVE',
                        event: () {},
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: MaterialButton(
                  color: cScaffoldBackground,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeleteAccountScreen(),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(5), // Set the border radius here
                    side: const BorderSide(
                      color: Colors.red, // Set the border color here
                      width: 2, // Set the border width
                    ),
                  ),
                  child: CommonTextWidget(
                    title: 'DELETE ACCOUNT',
                    fontWeight: FontWeight.w500,
                    color: cButtonRed,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
