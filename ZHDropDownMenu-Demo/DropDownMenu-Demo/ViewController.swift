//
//  ViewController.swift
//  ZHDropDownMenu-Demo
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

class ViewController: UIViewController ,ZHDropDownMenuDelegate{
    
    @IBOutlet weak var menu1: ZHDropDownMenu!
    @IBOutlet weak var menu2: ZHDropDownMenu!
    @IBOutlet weak var menu3: ZHDropDownMenu!
    @IBOutlet weak var menu4: ZHDropDownMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ZHDropDownMenu"
        
        menu1.options = ["北京","南昌","深圳","西安","上海","厦门","广州","北京","南昌","深圳","西安","上海","厦门","广州"] //设置下拉列表项数据
        menu1.maxRowToShow = 3;

        menu2.options = ["男","女"]
        menu2.showBorder = false //不显示边框
        
        menu3.options = ["1992","1993","1994","1995","1996","1997","1998"]
        menu3.defaultValue = "1992" //设置默认值
        menu3.showBorder = false
        
        menu4.options = ["天气太冷了","没睡好觉，困死了","就是不想上班"];
        menu2.editable = true

        menu1.delegate = self //设置代理
        menu2.delegate = self
        menu3.delegate = self
        menu4.delegate = self

//        let three = DispatchTime.now() + 3.0
//        DispatchQueue.main.asyncAfter(deadline: three) {
//            self.menu1.options = ["fsdgf","dfsdgf"]
//        }
    }
    
    //选择完后回调
    func dropDownMenu(_ menu: ZHDropDownMenu!, didChoose index: Int) {
        print("\(menu) choosed at index \(index)")
    }
    
    //编辑完成后回调
    func dropDownMenu(_ menu: ZHDropDownMenu!, didInput text: String!) {
        print("\(menu) input text \(text)")
    }
    
}

