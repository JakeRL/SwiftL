# SwiftL
My first Swfit project! SwiftL is a small and simple app that uses the Chicago Public Transit API to show the next arrival times for the train line and train station of your choosing. As of now, this project is mostly a learning experience, but in the future I would love to devote time to build more robust functionality as well as a beautiful and intuitive UI/UX.

This is the first app that I've developed using Swift. With that being said, I'm sure that there are areas that I could improve on and I would love to hear feedback as to where those areas are. I am unhappy with the amount of forced unwrapping that I am currently doing and plan to better handle these situations moving forward. I am also in search of a more elegant solution to parsing the CTA API's XML; please let me know if there's anything out there I should be using!

# API Key
An API Key is required to use the CTA Train Tracker API. Information on how to acquire an API Key, as well as API Documenation, can be found at the [CTA Developer Website](http://www.transitchicago.com/developers/traintracker.aspx).

If you would like to build and run this project, you would need to add an `APIKeys.plist` file to the project and add your own API Key as the String value for the `CTA` key.
