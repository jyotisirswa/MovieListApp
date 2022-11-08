//
//  Extensions.swift
//  MovieListApp
//
//  Created by Jyoti on 05/11/2022.
//

import Foundation
import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

//MARK: - UITableView
public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func register<T: UITableViewHeaderFooterView>(viewType: T.Type, bundle: Bundle? = nil) {
        let className = viewType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
    
//    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
//        return loadNibNamed(type.className, owner: nil, options: nil)
//    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.init(named: "shadowColor")?.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
        containerView.layer.shadowRadius = 10.0
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = false
        containerView.layer.cornerRadius = cornerRadious
    }
}

extension UIButton {
    func applyBorderNColor(borderColor : UIColor? = .black, cornerRadius : CGFloat? = 15.0){
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = cornerRadius ?? 0.0
    }
}

//MARK: - Arrays
public extension Collection where Indices.Iterator.Element == Index {
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript (safe index: Index) -> Iterator.Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

enum StoryBoard: String {
    case Main
}


extension UIViewController {
    /// Display message in prompt view
    ///
    /// — Parameters:
    /// — title: Title to display Alert
    /// — message: Pass string of content message
    /// — options: Pass multiple UIAlertAction title like “OK”,”Cancel” etc
    /// — completion: The block to execute after the presentation finishes.
    func presentAlertWithTitleAndMessage(title: String? = nil, message: String? = nil, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.view.tintColor = .gray
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: option == "Cancel" ? .cancel : .default , handler: { (action) in
                completion(index)
            }))

        }
        UIApplication.shared.keyWindowPresentedController?.present(alertController, animated: true, completion: nil)
        //topMostViewController().present(alertController, animated: true, completion: nil)
    }
    
    /// Get the top most view in the app
    /// — Returns: It returns current foreground UIViewcontroller
    func topMostViewController() -> UIViewController {
        var topViewController: UIViewController? = AppDelegate.appDelegate().window?.rootViewController
        while ((topViewController?.presentedViewController) != nil) {
            topViewController = topViewController?.presentedViewController
        }
        return topViewController ?? UIViewController()
    }
    
    func setBackButton(){
        let yourBackImage = UIImage(named: "back")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        navigationController?.navigationBar.backIndicatorImage = yourBackImage
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.navigationBar.topItem?.title = " "
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
    }
}

extension UIApplication {
    
    var keyWindowPresentedController: UIViewController? {
        //var viewController = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }

        guard let firstWindow = firstScene.windows.first else {
            return nil
        }
        var viewController = firstWindow.rootViewController
        // If root `UIViewController` is a `UITabBarController`
        if let presentedController = viewController as? UITabBarController {
            // Move to selected `UIViewController`
            viewController = presentedController.selectedViewController
        }
        
        // Go deeper to find the last presented `UIViewController`
        while let presentedController = viewController?.presentedViewController {
            // If root `UIViewController` is a `UITabBarController`
            if let presentedController = presentedController as? UITabBarController {
                // Move to selected `UIViewController`
                viewController = presentedController.selectedViewController
            } else {
                // Otherwise, go deeper
                viewController = presentedController
            }
        }
        
        return viewController
    }
}

//MARK: - To sort array of movies
enum ActionSheetTitles: String {
    case title = "Title"
    case releaseDate = "Release Date"
    case cancel = "Cancel"
}

//MARK: - Predicate to sort Any type of model array
extension Sequence {
    func sorted<T: Comparable>(_ predicate: (Element) throws -> T) rethrows -> [Element] {
        try sorted(predicate, by: <)
    }
    func sorted<T: Comparable>(_ predicate: (Element) throws -> T, by areInIncreasingOrder: ((T,T) throws -> Bool)) rethrows -> [Element] {
        try sorted { try areInIncreasingOrder(predicate($0), predicate($1)) }
    }
}

//MARK: - Sort an array
extension Array {
    mutating func propertySort<T: Comparable>(_ property: (Element) -> T) {
        sort(by: { property($0) < property($1) })
    }
}

//MARK: Extension to convert to date from string
extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        guard let dt = dateFormatter.date(from: self) else  {
            return nil
        }
        print(dt)
        return dt
    }
}

//MARK: - UILABEL + CUSTOMIZATION
extension UILabel {
    public var getHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    func changeColor() {        
        guard let text = self.text else {
            return
        }
        let attributeString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSRange(location:text.count - 3,length:text.count - (text.count - 3)))
        attributeString.addAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)], range: NSRange(location:text.count - 3,length:text.count - (text.count - 3)))
        self.attributedText = attributeString
    }
}
