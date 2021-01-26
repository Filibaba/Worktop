/// The "confirm state" wraps information to show an alert modal.
public struct ConfirmState<Action: Equatable>: Equatable {
  public var title: String
  public var message: String?
  public var confirmTitle: String
  public var confirmAction: Action
  public var cancelAction: Action
}
