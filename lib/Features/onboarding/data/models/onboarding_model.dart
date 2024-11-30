class OnboardingModel {
  String imageUrl;
  String description;
  String buttomText;
  OnboardingModel(
      {required this.description,
      required this.buttomText,
      required this.imageUrl});
}

List<OnboardingModel> OnboardingList = [
  OnboardingModel(
    description: 'Welcome',
    buttomText: 'Get Started',
    imageUrl: "assets/images/Market Research.gif",
    // imageUrl: "assets/images/ToDo.png",
  ),
  OnboardingModel(
    description: 'Manage your tasks in our app',
    buttomText: 'Next',
    imageUrl: 'assets/images/Man Holding Note.gif',
    // imageUrl: "assets/images/ToDo.png",
  ),
  OnboardingModel(
    description: 'Enjoy',
    buttomText: 'Go',
    imageUrl: 'assets/images/person2.gif',
    // imageUrl: "assets/images/ToDo.png",
  ),
];
