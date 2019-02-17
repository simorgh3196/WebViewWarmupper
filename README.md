# WebViewWarmupper

Warmup WKWebView Helper.

## Why

WKWebView inititalize is very slowly.
Pre initialize when UI Thread not busy make it better.

## Installation

### Cocoapods

`pod 'WebViewWarmupper'`

### Carthage

`github "simorgh3196/WebViewWarmupper"`

## Usage

```swift
let warmupper = WebViewWarmupper(maxSize: 3)

// warmup a WKWebView instance.
warmupper.warmup()

// warmup some WKWebView instances.
warmupper.warmup(2)

// warmup WKWebView instance up to max size.
warmupper.warmupUpToSize()

let webView = warmupper.getView()
```

### [Advanced] Custom WKWebView initialization

```swift
class MyWebViewWarmupper: ViewWarmupper<WKWebView> {

    init() {
        super.init(maxSize: 3) {
            let script = WKUserScript(
              source: "#custom_javascript",
              injectionTime: .atDocumentStart,
              forMainFrameOnly: false)
            let contentController = WKUserContentController()
            contentController.addUserScript(script)
            let configuration = WKWebViewConfiguration()
            configuration.userContentController = contentController

            return WKWebView(frame: .zero, configuration: configuration)
        }
    }
}
```

## Performance

Check performance for Example project

|     |     | Warmuped WKWebView   | Shared WKWebView     | Simple WKWebView    | Simple UIWebView     |
| --- | --- | -------------------- | -------------------- | ------------------- | -------------------- |
| 1   |     | 0.05490398406982422  | 0.07083094120025635  | 0.7591549158096313  | 0.8732810020446777   |
| 2   |     | 0.029172897338867188 | 0.05423104763031006  | 0.45792603492736816 | 0.02630794048309326  |
| 3   |     | 0.03314995765686035  | 0.023260951042175293 | 0.3551570177078247  | 0.021090030670166016 |
| 4   |     | 0.030402064323425293 | 0.02096700668334961  | 0.36775505542755127 | 0.021376967430114746 |
| 5   |     | 0.030902981758117676 | 0.02869093418121338  | 0.3720470666885376  | 0.020707011222839355 |
| 6   |     | 0.02951192855834961  | 0.02883601188659668  | 0.48676598072052    | 0.021302103996276855 |
| 7   |     | 0.0360109806060791   | 0.0317530632019043   | 0.4646350145339966  | 0.02109396457672119  |
| 8   |     | 0.030125975608825684 | 0.022431015968322754 | 0.39225101470947266 | 0.018939971923828125 |
| 9   |     | 0.041404008865356445 | 0.022022008895874023 | 0.44484400749206543 | 0.027421951293945312 |
| 10  |     | 0.03253495693206787  | 0.026466012001037598 | 0.4506809711456299  | 0.020102977752685547 |
|     |     |                      |                      |                     |                      |
| Ave |     | 0.034811973571777344 | 0.03294889926910401  | 0.4551217079162598  | 0.10716239213943482  |

