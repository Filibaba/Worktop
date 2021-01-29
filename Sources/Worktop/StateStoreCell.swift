import Combine
import ComposableArchitecture
import UIKit

/// The state store cell is a cell superclass designed to work with Composable Architecture state stores. It removes
/// much of the boiler plate involved with creating a custom cell subclass.
open class StateStoreCell<State: Equatable, Action>: UICollectionViewCell {

  public typealias Store = ComposableArchitecture.Store<State, Action>
  public typealias ViewStore = ComposableArchitecture.ViewStore<State, Action>

  // MARK: Properties

  /// Any current store for this cell.
  public var store: Store?

  /// Any current view store for this cell.
  public var viewStore: ViewStore?

  /// A place to store cancallables for state subscriptions.
  public var cancellables: Set<AnyCancellable> = []

  // MARK: Initialization

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  @available(*, unavailable) public required init?(coder: NSCoder) { fatalError() }

  // MARK: Configuration

  /// Configure the cell with the given store.
  ///
  /// - Parameter store: The store to use for the cell.
  public func configure(with store: Store) {
    let viewStore = ViewStore(store)
    self.store = store
    self.viewStore = viewStore
    configureStateObservation(on: viewStore)
  }

  // MARK: Cell Lifecycle

  open override func prepareForReuse() {
    super.prepareForReuse()
    cancellables.removeAll()
    store = nil
    viewStore = nil
  }

  // MARK: Subclass API

  /// Override this method to configure state observation whenever the cell is configured with a new store.
  ///
  /// - Parameter viewStore: The view store that was created as part of the configuration.
  open func configureStateObservation(on viewStore: ViewStore) { }

  /// Override this method to setup views when a cell is created.
  open func setupViews() { }

}
