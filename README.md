# [![XLayout](https://github.com/HsiangHo/XLayout/blob/master/images/logo.png?raw=true)](#)
🐳 XLayout is a Swift Auto Layout DSL with more lightweight syntax for macOS.  
  
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20OS%20X%2010.10%2B-orange.svg)](https://github.com/HsiangHo/XLayout)
[![Language](https://img.shields.io/badge/language-swift%205-red.svg)](https://github.com/HsiangHo/XLayout)

## Requirements

- macOS / OS X 10.10 +
- Xcode 10.0+
- Swift 5.0+

## Installation
### Git submodule
hahaha, like me. :)   

### Manually

Integrate XLayout into your project manually.

## Issues & Contribution

- If you **need help**, contact <object.xiang@gmail.com>.
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## 🎮 Try it Now!

Let's make some constraints like this:   
[![DEMO](https://github.com/HsiangHo/XLayout/blob/master/images/demo.png?raw=true)](#)  

### Using NSLayoutConstraint
 щ(｀ω´щ)  
 (╯-_-)╯~╩╩  
 m9(`Д´)   
 ヽ(｀⌒´)ﾉ  
 
### Using XLayout
- 🖇Chaining API  

- 🖇Chaining API  
```swift
        view1.xLayout.leading(20).bottom(-15).width(150).height(100)
        view2.xLayout.leading(view1.trailing + 80).height(30).trailing(-15).top(40)
```
- ⚖️ Equation Based API  
```swift
        view1.width == 150
        view1.height == 100
        view1.leading == 20
        view1.bottom == -15
        view2.leading == view1.trailing + 80
        view2.height == 30
        view2.trailing == -15
        view2.top == 40
```

- 🎨Visual Layout API  
```swift
        view1.width == 150
        view1.height == 100
        view1.visualLayout(.H(|-20-view1), .V(view1-15-|))

        view2.height == 30
        view2.visualLayout(.H(view1-80-view2-15-|), .V(|-40-view2))
```
