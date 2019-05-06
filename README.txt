1. App Name: Cornell Grant App
2. App Tagline: A platform that connects donors sourced by the Compton Foundation with talented individuals striving to make social change.
3. https://github.com/treyburrell/HackChallenge2019.git
4. Some screenshots of your app (highlight important features)


  
  
  

1. The app has three tabs. The home tab which introduces the app and shows the user grants based on collected information. The search tab allows the user to search through our list of grants by name. The settings tab saves the users info then feeds that information to the home tab for recommendations.
2. A list of how your app addresses each of the requirements (iOS / Backend)
   1. IOS
      1. AutoLayout used for setting up the home tab collection view and the search tab tableview
      2. Home tab has a collection view and the search tab has a tableview
      3. The tab bar at the bottom of the app allows the user to transition between the tabs
      4. The app was integrated with the backend’s api 
   1. Backend
      1. Implemented a database that had an api for the frontend
1. Anything else you want your grader to know
   1. IOS: We were not able to create a way for the information provided on the settings tab to feed into the home tab for recommendations.
   2. Backend: We had an issue with the Docker Daemon not running while trying to set up the image even though Docker was running