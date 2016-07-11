# Dizzy

![Dizzy Sample Application Demo](https://cloud.githubusercontent.com/assets/517428/16718482/4d6d981c-46d5-11e6-8bc5-78161ec476ab.gif)

A `UIActivityIndicatorView` -inspired `UIView` that allows you to set a custom image for the indicator. It takes advantage of `IBDesignable` and `IBInspectable` attributes (available since XCode 6,) which allows you to configure this indicator with your custom image and preview it in Interface Builder.

## Using DizzyActivityIndicatorView

Drop a `UIView` into your storyboard and then change its class to `DizzyActivityIndicatorView`. You can then configure its image and `UIActivityIndicatorView`style attributes, like `isAnimating` and `hidesWhenStopped`

While straightforward, the __DizzySample__ application target provides a concrete example of how to use this class.

![Dizzy Interface Builder Demo](https://cloud.githubusercontent.com/assets/517428/16718279/6fad2020-46d3-11e6-84be-8f5e5ca374ff.gif)

## Installation

It's one file, so it's easiest to just drop it into your XCode project via a clone+copy or even a submodule reference (but if you're really hunkering for some kind of dependency manager support, then file an issue and let's work together on it!)
