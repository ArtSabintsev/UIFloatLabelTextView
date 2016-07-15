# UIFloatLabelTextView

### A subclassed UITextView that implements the Float Label UI design pattern.

![Cocoapods](https://img.shields.io/cocoapods/v/UIFloatLabelTextView.svg) ![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)
___

## Note
If you are looking for the `UITextField` equivalent of this class, please visit my [UIFloatLabelTextField](http://www.github.com/ArtSabintsev/UIFloatLabelTextField) repository.

## About
In 2013, [**Matt D. Smith**](http://twitter.com/mds) unveiled the **[Float Label](http://www.floatlabel.com)** user interface design pattern. In short, it retains a text field's placeholder above said text field (or text view) as a *floating label*. This label is brightly colored when the field is active, and dimly colored when a user has finished editing that field.

![Sample Gif of Library in Action](http://d13yacurqjgara.cloudfront.net/users/6410/screenshots/1254439/form-animation-_gif_.gif)

Image credit: [Matt D. Smith](http://twitter.com/mds).

## Changelog (v1.0.8)
- Fixed [Issue #6](https://github.com/ArtSabintsev/UIFloatLabelTextView/issues/6).

## Features
- Works with all view `init` styles
	- Visual Formatting Language (for programmatic NSAutoLayout)
	- Manual Frame Initialization
	- Storyboards and Xibs
- Works with all `NSTextAlignments`
- Added Placeholder support
- Support for disabling all default UIMenuController options
	- E.g., Paste, Copy, Cut, Select, Select All

## Installation

### CocoaPods
``` ruby
pod 'UIFloatLabelTextView'
```

### Carthage
``` swift
github "ArtSabintsev/UIFloatLabelTextView"
```

## Usage
Check out `UIFloatLabelTextView.h` for a full list of editable properties. Also, check out the **UIFloatLabelSampleApp** for an example impementation of the application.

## Created and maintained by
[Arthur Ariel Sabintsev](http://www.sabintsev.com/)

## License
Please refer to the **LICENSE** file.
