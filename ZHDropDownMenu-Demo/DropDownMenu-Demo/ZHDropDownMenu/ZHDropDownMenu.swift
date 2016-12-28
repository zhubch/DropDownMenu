//
//  ZHDropDownMenu.swift
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

<<<<<<< HEAD
public protocol ZHDropDownMenuDelegate:class{
    func dropDownMenu(menu:ZHDropDownMenu!, didInput text:String!)
    func dropDownMenu(menu:ZHDropDownMenu!, didChoose index:Int)
=======
public protocol ZHDropDownMenuDelegate{
    func dropDownMenu(_ menu:ZHDropDownMenu!, didInput text:String!)
    func dropDownMenu(_ menu:ZHDropDownMenu!, didChoose index:Int)
>>>>>>> 1.0.0
}

@IBDesignable open class ZHDropDownMenu: UIView , UITableViewDataSource ,UITableViewDelegate,UITextFieldDelegate{
    
<<<<<<< HEAD
    public weak var delegate:ZHDropDownMenuDelegate?
    
    public var inputClosure: ((ZHDropDownMenu , text: String) ->Void )?
    
    public var chooseClosure: ((ZHDropDownMenu , index: Int) ->Void )?
=======
    open var delegate:ZHDropDownMenuDelegate?
>>>>>>> 1.0.0
    
    open var options:Array<String> = [] {//菜单项数据
        didSet {
            if isShown {
                optionsList.reloadData()
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.pullDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                    self.optionsList.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.size.height-0.5, width: self.frame.size.width, height: CGFloat(self.maxRowToShow == 0 ? self.options.count : self.maxRowToShow) * self.rowHeight)
                }, completion: { (finished) -> Void in
                    if finished{
                        self.isShown = true
                    }
                })
            }
        }
    }
    
    open var maxRowToShow = 0 {// 当他不等于0时，最多同时显示maxRowToShow行选项，多出的选项需要滚动才能看到，可以用这个属性来控制列表高度
        didSet {
            if isShown {
                optionsList.reloadData()
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.pullDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                    self.optionsList.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.size.height-0.5, width: self.frame.size.width, height: CGFloat(self.maxRowToShow == 0 ? self.options.count : self.maxRowToShow) * self.rowHeight)
                }, completion: { (finished) -> Void in
                    if finished{
                        self.isShown = true
                    }
                })
            }
        }
    }

    @IBInspectable open var defaultValue:String? { //默认值。这不是placeholder!!
        didSet {
            contentTextField.text = defaultValue
        }
    }
    
    @IBInspectable open var textColor:UIColor?{ //输入框和下拉列表项中文本颜色
        didSet {
            contentTextField.textColor = textColor
        }
    }
    
    open var font:UIFont?{ //输入框和下拉列表项中字体
        didSet {
            contentTextField.font = font
        }
    }
    
    open var showBorder:Bool = true { //是否显示边框，默认显示
        didSet {
            if showBorder {
                layer.borderColor = UIColor.lightGray.cgColor
                layer.borderWidth = 0.5
                layer.masksToBounds = true
                layer.cornerRadius = 2.5
            }else {
                layer.borderColor = UIColor.clear.cgColor
                layer.masksToBounds = false
                layer.cornerRadius = 0
                layer.borderWidth = 0
            }
        }
    }
    
    open lazy var rowHeight:CGFloat = { //菜单项的行高，默认和本控件一样高
        return self.frame.size.height
    }()
    
    open lazy var optionsList:UITableView = { //下拉列表
        let table = UITableView(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.size.height, width: self.frame.size.width, height: 0), style: .plain)
        table.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        table.dataSource = self
        table.delegate = self
        table.layer.borderColor = UIColor.lightGray.cgColor
        table.layer.borderWidth = 0.5
        self.superview?.addSubview(table)
        return table
    }()
        
    
    @IBInspectable open var editable:Bool = false { //允许用户编辑,默认不允许
        didSet {
            contentTextField.isEnabled = editable
        }
    }
    
    
    @IBInspectable open var buttonImage:UIImage?{ //下拉按钮的图片
        didSet {
            pullDownButton.setImage(buttonImage, for: UIControlState())
        }
    }
    
    @IBInspectable open var placeholder:String? {
        didSet {
            contentTextField.placeholder = placeholder
        }
    }
    
    fileprivate var isShown:Bool = false
    
    fileprivate var contentTextField:UITextField!
    
    fileprivate var pullDownButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        contentTextField = UITextField(frame: CGRect.zero)
        contentTextField.delegate = self
        contentTextField.isEnabled = false
        addSubview(contentTextField)
        
        pullDownButton = UIButton(type: .custom)
        pullDownButton.addTarget(self, action: #selector(ZHDropDownMenu.showOrHide), for: .touchUpInside)
        addSubview(pullDownButton)
        
        self.showBorder = true
        self.textColor = UIColor.darkGray
        self.font = UIFont.systemFont(ofSize: 16)
    }
    
    func showOrHide() {
        if isShown {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.pullDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI*2))
                self.optionsList.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.size.height-0.5, width: self.frame.size.width, height: 0)
                }, completion: { (finished) -> Void in
                    if finished{
                        self.pullDownButton.transform = CGAffineTransform(rotationAngle: 0.0)
                        self.isShown = false
                    }
            })
        } else {
            contentTextField.resignFirstResponder()
            optionsList.reloadData()
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.pullDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                self.optionsList.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.size.height-0.5, width: self.frame.size.width, height: CGFloat(self.maxRowToShow == 0 ? self.options.count : self.maxRowToShow) * self.rowHeight)
                }, completion: { (finished) -> Void in
                    if finished{
                        self.isShown = true
                    }
            }) 
        }
        
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        contentTextField.frame = CGRect(x: 15, y: 5, width: self.frame.size.width - 50, height: self.frame.size.height - 10)
        pullDownButton.frame = CGRect(x: self.frame.size.width - 35, y: 5, width: 30, height: 30)
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            self.delegate?.dropDownMenu(self, didInput: text)
            self.inputClosure?(self, text: text)
        }
        return true
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.font = font
        cell.textLabel?.textColor = textColor
        
        return cell
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contentTextField.text = options[indexPath.row]
        self.delegate?.dropDownMenu(self, didChoose:indexPath.row)
        self.chooseClosure?(self, index: indexPath.row)
        showOrHide()
    }
}
