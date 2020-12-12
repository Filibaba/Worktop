import Combine
import Foundation

extension Publisher where Self.Failure == Never {
  public func assignNoRetain<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root) -> AnyCancellable where Root: AnyObject {
    sink { [weak object] (value) in
      object?[keyPath: keyPath] = value
    }
  }
}

extension Cancellable {
  public func store<Key>(in dictionary: inout [Key: AnyCancellable], for key: Key) {
    dictionary[key] = AnyCancellable(self)
  }
}
