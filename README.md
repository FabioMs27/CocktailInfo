# PrintfulAssessment
Assessment for the iOS developer position at Printful.<br/>
In this app you can search and view informations regarding various cocktails.<br/>
Information such as it's category, glass used and intructions on how to make it.<br/>

## Gif:
![](https://media.giphy.com/media/dQvP6eS8iLEW8OnVXX/giphy.gif)

### How it was made:

It uses the native URLSession framework for the api request. It implements the protocol-oriented approach, using generics and generic constraints so various different apis can be used as well as images can be downloaded. It contains error handling.<br/>
It decodes using the decodable protocol and coding keys.<br/>
It contains unit tests and it used the mock protocol approach. URLSession and URLSessionDataTask are subclassed so it can be tested without being asynchronous.<br/>
It uses storyboard for the UI and NSLayoutConstraints(also programmatically) and stack views for the Auto-layout.<br/>
The architectural pattern used is MVVM and it uses the reactive programming(Combine) approach for binding.<br/>

### UI
  - Storyboard
### Architectural pattern
  - MVVM
### Networking
  - URLSession
  
### Api website
  - https://www.thecocktaildb.com/api.php?ref=apilist.fun
