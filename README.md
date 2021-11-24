creative points

1. What you added
1.1 Save the current drawing to the photos library
1.2 Set opacity for shapes
1.3 Switch background colors between white color and gray color

2. How you added it and what the process involved
2.1 First, create a button in navigation bar (the first item in the top left in the page). Write <key>NSPhotoLibraryAddUsageDescription</key> in Info.plist. Then create an extension to change current Drawing View into image. Also, set a futon to deal with error occurring during image save period. Finally use UIImageWriteToSavedPhotosAlbum() function to save received image to photos library.
2.2 First, create a button in navigation bar (the slider between colors button and shape segmented control). Set a variable "opacity" in Shape.swift and use withAlphaComponent(opacity) in 3 different Shape subclass files. Finally use a for loop to set opacity of all shapes along with the change of slider's value.
2.3 First, create a button in navigation bar (the second item in the top left in the page). Change DrawingView's backgroundColor through judging current DrawingView's backgroundColor. Then you can switch background colors between white color and gray color.

3. Why you added it
3.1 It's very useful to save current drawing to the photos library. In that case, you can easily find what you create last time without recalling. And you can share the image you draw to any friend.
3.2 It's very interesting to change the opacity of shapes. Thus you can create different kinds of drawings and save those diverse images to the the photos library.
3.3 Changing background color of your drawing can make your drawing diversified and beautiful. And changing to gray color without being able to change the background color would b monotonous. That's the reason why I make it can switch between 2 colors.
