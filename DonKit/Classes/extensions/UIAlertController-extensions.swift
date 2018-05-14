
extension UIAlertController {
    public class func show(inViewController viewController: UIViewController?, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        (viewController ?? UIApplication.shared.topViewController)?.present(alert, animated: true, completion: nil)
    }
}
