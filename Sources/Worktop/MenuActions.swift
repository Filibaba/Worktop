import ComposableArchitecture
import UIKit

public extension ViewStore {

  /// A convenience initializer for actions that send a view store action when invoked.
  func action(
    titled title: String,
    systemImage image: String?,
    identifier: UIAction.Identifier? = nil,
    discoverabilityTitle: String? = nil,
    attributes: UIMenuElement.Attributes = [],
    state: UIMenuElement.State = .off,
    action: Action
  ) -> UIAction {
    return UIAction(
      title: title,
      image: image.flatMap { UIImage(systemName: $0) },
      identifier: identifier,
      discoverabilityTitle: discoverabilityTitle,
      attributes: attributes,
      state: state,
      handler: { [weak self] _ in self?.send(action) }
    )
  }

  /// A convenience initializer for actions that send a view store action when invoked.
  func action(
    titled title: String,
    systemImage image: String?,
    identifier: UIAction.Identifier? = nil,
    discoverabilityTitle: String? = nil,
    attributes: UIMenuElement.Attributes = [],
    state: UIMenuElement.State = .off,
    action: @escaping () -> Action
  ) -> UIAction {
    return UIAction(
      title: title,
      image: image.flatMap { UIImage(systemName: $0) },
      identifier: identifier,
      discoverabilityTitle: discoverabilityTitle,
      attributes: attributes,
      state: state,
      handler: { [weak self] _ in self?.send(action()) }
    )
  }
}

@resultBuilder public struct MenuBuilder {
  public static func buildBlock(_ actions: UIAction...) -> [UIAction] {
    return actions
  }

  public static func buildEither(first component: UIAction) -> UIAction {
    component
  }

  public static func buildEither(second component: UIAction) -> UIAction {
    component
  }
}

extension UIMenu {

  /// Create an inline menu object.
  public static func inlineMenu(
    title: String = "",
    image: UIImage? = nil,
    identifier: Identifier? = nil,
    options: Options = [],
    @MenuBuilder _ actions: () -> [UIAction]
  ) -> UIMenu {
    return UIMenu(title: title, image: image, identifier: identifier, options: .displayInline, children: actions())
  }
}
