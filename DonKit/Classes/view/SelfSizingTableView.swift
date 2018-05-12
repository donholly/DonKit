import UIKit

@IBDesignable
class SelfSizingTableView: UITableView {
    
	@IBInspectable public var maxHeight: CGFloat = UIScreen.main.bounds.size.height

	override func reloadData() {
		super.reloadData()
        
		self.invalidateIntrinsicContentSize()
		self.layoutIfNeeded()
	}

	override var intrinsicContentSize: CGSize {
		let height = min(contentSize.height, maxHeight)
		return CGSize(width: contentSize.width, height: height)
	}
}
