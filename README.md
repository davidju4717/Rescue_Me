# Rescue Me!

Rescue Me! is a mobile application developed with flutter SDK and written in Dart that allows an animal rescue organization to locate abandoned kittens and puppies in a city. Users of this application can help the organization with its mission by posting a photo and the count of the fluffy creatures when encountering them. The  user's device geolocation will be stored in the post upon submission.   

## Key Features

• Supports both iOS and Android.</br>
•	Enables access to hardware services such as geolocation and the image gallery of the device.</br>
•	Achieves remote data persistence by storing photos on Google's Firesbase Storage and relavant data of each post(location, count and photo URL) in Google's Firestore Database.</br>
•	Achieves on device data persistence (eg. whether the dark mode is enabled) through SharedPreferences API.</br>
•	Integrates Sentry for crash reporting and Firebase Analytics for in-ap analytics.</br>

<p align="center">
  <div>
    Example </br>
    <img src="Rescue_Me_example.gif" alt="animated" />
  </div> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="data_persistence.gif" alt="animated" />
</p>


