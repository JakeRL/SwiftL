# SwiftL
My first Swfit project! SwiftL is a small and simple app that uses the Chicago Public Transit API to show the next arrival times for the train line and train station of your choosing. As of now, this project is mostly a learning experience, but in the future I would love to devote time to build more robust functionality as well as a beautiful and intuitive UI/UX.

Seeing as this is the first app that I've developed using Swift, I'm sure that there are areas that I could improve on and I would love to hear feedback as to where those areas are. I'm currently unhappy with the amount of forced unwrapping in the code and plan to better handle these situations moving forward. I am also in search of a more elegant solution to parsing the CTA API's XML; please let me know if there's anything out there I should be using!

### API Key
An API Key is required to use the CTA Train Tracker API. Information on how to acquire an API Key, as well as API Documenation, can be found at the [CTA Developer Website](http://www.transitchicago.com/developers/traintracker.aspx).

If you would like to build and run this project, you would need to add an `APIKeys.plist` file to the project and add your own API Key as the String value for the `CTA` key.

#### Cocoapods
This project uses [Cocoapods](https://cocoapods.org), however, (with your own API Key) you should be able to hit the ground running as the Pods are included in the source control. If you're having trouble due to Cocoapods, I recommend running a `pod install`.
