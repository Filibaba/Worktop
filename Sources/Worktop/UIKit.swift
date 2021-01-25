import ComposableArchitecture
import UIKit

// MARK: - Bar Buttons

public extension ViewStore {

  /// Creates a bar button item with the given properties that triggers the given action when tapped.
  ///
  /// - Parameter title. The title of the item.
  /// - Parameter image: The icon image for the item.
  /// - Parameter action: The action to be triggered upon tapping the item.
  /// - Parameter menu: An optional `UIMenu` to associate with the button.
  ///
  /// - Returns: A new bar button item.
  func barButtonItem(title: String, image: UIImage?, action: Action, menu: UIMenu? = nil) -> UIBarButtonItem {
    UIBarButtonItem(title: title, image: image, primaryAction: UIAction { [weak self] _ in
      self?.send(action)
    }, menu: menu)
  }

  /// Creates a bar button item of the given system type.
  ///
  /// - Parameter systemItem: The system item to use for the button.
  /// - Parameter action: The action to be triggered upon tapping the item.
  /// - Parameter menu: An optional `UIMenu` to associate with the button.
  ///
  /// - Returns: A new bar button item.
  func barButtonItem(systemItem: UIBarButtonItem.SystemItem, action: Action, menu: UIMenu? = nil) -> UIBarButtonItem {
    UIBarButtonItem(systemItem: systemItem, primaryAction: UIAction { [weak self] _ in
      self?.send(action)
    }, menu: menu)
  }

}
