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
        // the | means superView and the - means space
        view1.width == 150
        view1.height == 100
        view1.visualLayout(.H(|-20-view1), .V(view1-15-|))

        view2.height == 30
        view2.visualLayout(.H(view1-80-view2-15-|), .V(|-40-view2))
```

- In Addition  
 | : superView  
 \- : space  
 ~ : priority  
 Use them like those ways:  
 
 ```swift
    view.xLayout.leading(==(contentView.leading*0.7 + 20) ~ 210)
            .trailing(<=(*0.6-50))
            .bottom(>=(contentView.bottom - 20))
            .top(contentView.top*0.8)
            .width(200)
            
    view.leading == (contentView.leading*0.7 + 20) ~ 210
    view.trailing <= *0.6-50
    view.bottom >= contentView.bottom - 20
    view.top == contentView.top*0.8
    view.width == 200
 
    view.visualLayout(.H(|-10-viewT-(*0.9 + 20)-|), .V(|-viewT-view))
 ```

## License

XLayout is released under the MIT license. See LICENSE for details.
