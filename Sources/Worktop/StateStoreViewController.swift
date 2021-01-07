import Combine
import ComposableArchitecture
import UIKit

/// Convenience class for view controllers that are powered by state stores.
open class StateStoreViewController<State: Equatable, Action>: UIViewController {

  // MARK: Properties

  /// The store powering the view controller.
  open var store: Store<State, Action>

  /// The view store wrapping the store for the actual view.
  open var viewStore: ViewStore<State, Action>

  /// Keeps track of subscriptions.
  open var cancellables: Set<AnyCancellable> = []

  // MARK: Initialization

  /// Creates a new store view controller with the given store.
  ///
  /// - Parameter store: The store to use with the view controller.
  ///
  /// - Returns: A new view controller.
  public init(store: Store<State, Action>) {
    self.store = store
    self.viewStore = ViewStore(store)
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable) public required init?(coder: NSCoder) {
    fatalError("Not implemented")
  }

  // MARK: View Controller Lifecycle

  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureStateObservation(on: viewStore)
  }

  open override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    cancellables.removeAll()
  }

  // MARK: Subclass API

  /// Override this method to configure state observation.
  ///
  /// State configuration happens on `viewWillAppear` and all observations are cleared on `viewDidDisappear`.
  ///
  /// - Parameter viewStore: The view store to observe.
  open func configureStateObservation(on viewStore: ViewStore<State, Action>) { }

}
