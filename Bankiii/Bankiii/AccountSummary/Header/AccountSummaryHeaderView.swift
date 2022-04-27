//
//  AccountSummaryHeaderView.swift
//  Bankiii
//
//  Created by Johel Zarco on 24/04/22.
//

import UIKit

class AccountSummaryHeaderView : UIView{
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        override var intrinsicContentSize: CGSize {
            return CGSize(width: UIView.noIntrinsicMetric, height: 144)
        }
        
        private func commonInit() {
            // how to load programatically a .xib file
            let bundle = Bundle(for: AccountSummaryHeaderView.self)
            bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
            addSubview(contentView)
            contentView.backgroundColor = appColor
            
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
}