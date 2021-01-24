////
////  ItemCell.swift
////  JSONPlaceholderDemo
////
////  Created by ko on 2021/1/23.
////

import UIKit
import SDWebImage
import SnapKit

class ItemCell: UITableViewCell {
    
    static let reuseId = "ExampleCodeCell"
    var titleLabel: UILabel!
    var cellStackView: UIStackView!
    var thumbnailUrl : String!
    var thumbnailImageView: UIImageView!
    var stackV: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        let ctv = self.contentView
        let layoutMarginGuide = ctv.layoutMarginsGuide
        //title
        let titleLab = setupLabel(style: .headline)
        self.titleLabel = titleLab
        titleLabel.textColor = .black
        
        //imageView
        let mainImage = UIImageView.init(frame: .zero)
        mainImage.contentMode = .scaleAspectFit
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainImage.clipsToBounds = true
        mainImage.layer.masksToBounds = true
        mainImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        mainImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.thumbnailImageView = mainImage
    
        self.stackV  = setupStackView(input: [mainImage,titleLab])
        stackV.alignment = .center
        ctv.addSubview(self.stackV)
        
        NSLayoutConstraint.activate([
            stackV.topAnchor.constraint(equalTo: layoutMarginGuide.topAnchor, constant: 0),
            stackV.leadingAnchor.constraint(equalTo: layoutMarginGuide.leadingAnchor, constant: 10),
            stackV.trailingAnchor.constraint(equalTo: layoutMarginGuide.trailingAnchor, constant: -10),
            stackV.bottomAnchor.constraint(equalTo: layoutMarginGuide.bottomAnchor)
        ])
        
    }
    
    func setCell(data:PhotoModel) {
        
        self.titleLabel.text = data.title
        self.thumbnailImageView.sd_setImage(with: URL(string: data.thumbnailUrl!), placeholderImage: UIImage(named: "defaultImage"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLabel(style: UIFont.TextStyle) -> UILabel {
        let lbl = UILabel(frame: .zero)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byCharWrapping
        lbl.textAlignment = .center
        lbl.font  = UIFont.systemFont(ofSize: 15)
        lbl.sizeToFit()
        return lbl
    }
    
    private func setupStackView(input: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: input)
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleLabel.text = nil
        self.thumbnailImageView.image = UIImage()
        self.stackV = nil
    }
    
    
}


