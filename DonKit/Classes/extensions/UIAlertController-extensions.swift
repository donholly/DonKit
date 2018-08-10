
extension UIAlertController {
    public class func show(inViewController viewController: UIViewController?, title: String, message: String, completion: EmptyClosure? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
            completion?()
        }))
        (viewController ?? UIApplication.shared.topViewController)?.present(alert, animated: true, completion: nil)
    }
}
