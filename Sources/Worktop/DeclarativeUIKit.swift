// For more info read http://blog.eppz.eu/declarative-uikit-with-10-lines-of-code/
import UIKit

protocol Withable {
  associatedtype T

  @discardableResult func with(_ closure: (_ instance: T) -> Void) -> T
}
extension Withable {

  @discardableResult func with(_ closure: (_ instance: Self) -> Void) -> Self {
    closure(self)
    return self
  }

}

extension NSObject: Withable { }


extension UILabel {

  func with(text: String?) -> Self {
    with {
      $0.text = text
    }
  }

}

extension UIViewController {
  func wrappedInNavigationController() -> UINavigationController {
    UINavigationController(rootViewController: self)
  }
}

extension UIStackView {

  func horizontal(spacing: CGFloat = 0) -> Self {
    with {
      $0.axis = .horizontal
      $0.spacing = spacing
    }
  }

  func vertical(spacing: CGFloat = 0) -> Self {
    with {
      $0.axis = .vertical
      $0.spacing = spacing
    }
  }

  func views(_ views: UIView ...) -> Self {
    views.forEach { self.addArrangedSubview($0) }
    return self
  }

}

extension UIFont {
  class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
    let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
    let font: UIFont

    if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
      font = UIFont(descriptor: descriptor, size: size)
    } else {
      font = systemFont
    }
    return font
  }
}
