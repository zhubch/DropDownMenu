//
//  DropDownMenu.swift
//
//  Created by zhubch on 3/8/16.
//
//  Copyright (c) 2016 zhubch <cheng4741@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.


import UIKit

public protocol DropDownMenuDelegate{
    func dropDownMenu(menu:DropDownMenu!, didInput text:String!)
    func dropDownMenu(menu:DropDownMenu!, didChoose index:Int)
}

@IBDesignable public class DropDownMenu: UIView , UITableViewDataSource ,UITableViewDelegate,UITextFieldDelegate{
    
    public var delegate:DropDownMenuDelegate?
    
    public var options:Array<String> = [] //菜单项数据
    
    @IBInspectable public var defaultValue:String? { //默认值。这不是placeholder!!
        didSet {
            contentTextField.text = defaultValue
        }
    }
    
    @IBInspectable public var textColor:UIColor?{ //输入框和下拉列表项中文本颜色
        didSet {
            contentTextField.textColor = textColor
        }
    }
    
    public var font:UIFont?{ //输入框和下拉列表项中字体
        didSet {
            contentTextField.font = font
        }
    }
    
    public var showBorder:Bool = true { //是否显示边框，默认显示
        didSet {
            if showBorder {
                layer.borderColor = UIColor.lightGrayColor().CGColor
                layer.borderWidth = 0.5
                layer.masksToBounds = true
                layer.cornerRadius = 2.5
            }else {
                layer.borderColor = UIColor.clearColor().CGColor
                layer.masksToBounds = false
                layer.cornerRadius = 0
                layer.borderWidth = 0
            }
        }
    }
    
    public lazy var rowHeight:CGFloat = { //菜单项的行高，默认和本控件一样高
        return self.frame.size.height
    }()
    
    public lazy var optionsList:UITableView = { //下拉列表
        let table = UITableView(frame: CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0), style: .Plain)
        table.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        table.dataSource = self
        table.delegate = self
        table.layer.borderColor = UIColor.lightGrayColor().CGColor
        table.layer.borderWidth = 0.5
        self.superview?.addSubview(table)
        return table
    }()
    
    @IBInspectable public var editable:Bool = true { //允许用户编辑,默认允许
        didSet {
            contentTextField.enabled = editable
        }
    }
    
    @IBInspectable public var placeholder:String? {
        didSet {
            contentTextField.placeholder = placeholder
        }
    }
    
    @IBInspectable public var buttonImage:UIImage?{
        didSet {
            pullDownButton.setImage(buttonImage, forState: .Normal)
        }
    }
    
    private var isShown:Bool = false
    
    private var contentTextField:UITextField!
    
    private var pullDownButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        contentTextField = UITextField(frame: CGRectZero)
        contentTextField.delegate = self
        addSubview(contentTextField)
        
        pullDownButton = UIButton(type: .Custom)
        pullDownButton.addTarget(self, action: "showOrHide", forControlEvents: .TouchUpInside)
        addSubview(pullDownButton)
        
        self.showBorder = true
        self.textColor = UIColor.darkGrayColor()
        self.font = UIFont.systemFontOfSize(16)
    }
    
    private func showOrHide() {
        if isShown {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.pullDownButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI*2))
                self.optionsList.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height-0.5, self.frame.size.width, 0)
                }) { (finished) -> Void in
                    if finished{
                        self.pullDownButton.transform = CGAffineTransformMakeRotation(0.0)
                        self.isShown = false
                    }
            }
        } else {
            contentTextField.resignFirstResponder()
            optionsList.reloadData()
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.pullDownButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                self.optionsList.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height-0.5, self.frame.size.width, CGFloat(self.options.count) * self.rowHeight)
                }) { (finished) -> Void in
                    if finished{
                        self.isShown = true
                    }
            }
        }
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        contentTextField.frame = CGRect(x: 15, y: 5, width: self.frame.size.width - 50, height: self.frame.size.height - 10)
        pullDownButton.frame = CGRect(x: self.frame.size.width - 35, y: 5, width: 30, height: 30)
//        pullDownButton.snp_makeConstraints { (make) -> Void in
//            make.width.height.equalTo(30)
//            make.right.equalTo(self).inset(5)
//            make.centerY.equalTo(self)
//        }
//        contentTextField.snp_makeConstraints { (make) -> Void in
//            make.edges.equalTo(self).inset(UIEdgeInsetsMake(5, 15, 5, 35))
//        }
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            self.delegate?.dropDownMenu(self, didInput: text)
        }
        return true
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "")
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.font = font
        cell.textLabel?.textColor = textColor
        
        return cell
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        contentTextField.text = options[indexPath.row]
        self.delegate?.dropDownMenu(self, didChoose:indexPath.row)
        showOrHide()
    }

}
