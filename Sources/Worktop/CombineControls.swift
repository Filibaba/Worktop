import Combine
import UIKit

// A custom subscription to capture UIControl target events.
public final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
  private var subscriber: SubscriberType?
  private let control: Control

  public init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
    self.subscriber = subscriber
    self.control = control
    control.addTarget(self, action: #selector(eventHandler), for: event)
  }

  public func request(_ demand: Subscribers.Demand) {
    // We do nothing here as we only want to send events when they occur.
    // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
  }

  public func cancel() {
    subscriber = nil
  }

  @objc private func eventHandler() {
    _ = subscriber?.receive(control)
  }
}

/// A custom `Publisher` to work with our custom `UIControlSubscription`.
public struct UIControlPublisher<Control: UIControl>: Publisher {

  public typealias Output = Control
  public typealias Failure = Never

  public let control: Control
  public let controlEvents: UIControl.Event

  public init(control: Control, events: UIControl.Event) {
    self.control = control
    self.controlEvents = events
  }

  public func receive<S>(subscriber: S) where S : Subscriber, S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output {
    let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvents)
    subscriber.receive(subscription: subscription)
  }
}

/// Extending the `UIControl` types to be able to produce a `UIControl.Event` publisher.
public protocol CombineCompatible { }
extension UIControl: CombineCompatible { }
public extension CombineCompatible where Self: UIControl {
  func publisher(for events: UIControl.Event) -> UIControlPublisher<Self> {
    return UIControlPublisher(control: self, events: events)
  }
}
