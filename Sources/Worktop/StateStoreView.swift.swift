import Combine
import ComposableArchitecture
import UIKit

/// Convenience class for views that are powered by state stores.
open class StateStoreView<State: Equatable, Action>: UIView {

  public typealias Store = ComposableArchitecture.Store<State, Action>
  public typealias ViewStore = ComposableArchitecture.ViewStore<State, Action>

  // MARK: Properties

  /// The store powering the view.
  open var store: Store

  /// The view store wrapping the store for the view.
  open var viewStore: ViewStore

  /// Keeps track of subscriptions.
  open var cancellables: Set<AnyCancellable> = []

  // MARK: Initialization

  /// Creates a new store view with the given store.
  ///
  /// - Parameter frame: The initial frame of the view.
  /// - Parameter store: The store to use with the view.
  ///
  /// - Returns: A new view controller.
  public init(frame: CGRect = .zero, store: Store) {
    self.store = store
    self.viewStore = ViewStore(store)
    super.init(frame: frame)
    configureView()
    configureStateObservation(on: viewStore)
  }

  @available(*, unavailable) public required init?(coder: NSCoder) {
    fatalError("Not implemented")
  }

  // MARK: Subclass API

  /// Override this method to configure state observation.
  ///
  /// - Parameter viewStore: The view store to observe.
  open func configureStateObservation(on viewStore: ViewStore) { }

  /// Override this method to setup views when a cell is created.
  open func configureView() { }

}
