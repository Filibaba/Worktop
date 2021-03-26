import Combine
import ComposableArchitecture
import UIKit

/// Convenience class for views that are powered by state stores.
open class OptionalStateStoreView<State: Equatable, Action>: UIView {

  public typealias Store = ComposableArchitecture.Store<State, Action>
  public typealias ViewStore = ComposableArchitecture.ViewStore<State, Action>

  // MARK: Properties

  /// The store powering the view.
  private(set) public var store: Store?

  /// The view store wrapping the store for the view.
  private(set) public var viewStore: ViewStore?

  /// Keeps track of subscriptions.
  open var cancellables: Set<AnyCancellable> = []

  // MARK: Initialization

  /// Creates a new store view with the given store.
  ///
  /// - Parameter frame: The initial frame of the view.
  /// - Parameter store: The store to use with the view.
  ///
  /// - Returns: A new view controller.
  required public init(frame: CGRect = .zero, store: Store? = nil) {
    self.store = store
    self.viewStore = store.map(ViewStore.init)
    super.init(frame: frame)
    configureView()
    if let viewStore = viewStore {
      configureStateObservation(on: viewStore)
    }
  }

  @available(*, unavailable) public required init?(coder: NSCoder) {
    fatalError("Not implemented")
  }

  // MARK: Setting a store

  /// Sets a store for the view and resets cancellables.
  ///
  /// Make sure to call super if overriden.
  ///
  /// - Parameter store: A new stor, or nil.
  open func setStore(_ store: Store?) {
    cancellables.removeAll()
    self.store = store
    if let store = store {
      let viewStore = ViewStore(store)
      self.viewStore = viewStore
      configureStateObservation(on: viewStore)
    } else {
      self.viewStore = nil
    }
  }

  // MARK: Subclass API

  /// Override this method to configure state observation.
  ///
  /// - Parameter viewStore: The view store to observe.
  open func configureStateObservation(on viewStore: ViewStore) { }

  /// Override this method to setup views when a cell is created.
  open func configureView() { }

}
