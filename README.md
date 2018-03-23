# CatApi
Download various cat images and descriptions into a tableview

1. ApiClient was created which returned the Json array
2. Created the Cat Model - the initializer takes a json dictionary to create each cat object.
3. Created data store - called ApiClient which returned an Array of dictionaries.
4. In order to create a Cat object, I had to enumerate through the json Array and used the initializer from the Cat model to create.
5. Created a tableview with custom tableviewcell.
6. Implemented NSCache, a dictionary, by storing the url as keys and it's value as the downloaded images.
Using the cache will poplulate the tableviewCell quickly and reduce the use of cellular data for the user.
7. Implemented a check to ensure that the correct image appears in the correct tableview cell.
8. Downloaded the catImage cell asynchonously to avoid freezing up the UI that can happen when while the images download on the main thread.

