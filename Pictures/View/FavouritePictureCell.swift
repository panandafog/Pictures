//
//  FavouritePictureCell.swift
//  Pictures
//
//  Created by Andrey on 21.05.2023.
//

import UIKit

class FavouritePictureCell: UITableViewCell {
    
    var pictureData: PictureData? {
        didSet {
            handleNewPictureData()
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, h:mm a"
        return formatter
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let queryLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let uiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        uiImageView.image = nil
    }
    
    private func addSubviews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(queryLabel)
        contentView.addSubview(uiImageView)
    }
    
    private func setupConstraints() {
        setupDateLabelConstraints()
        setupQueryLabelConstraints()
        setupImageConstraints()
    }
    
    private func setupImageConstraints() {
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: uiImageView,
            attribute: .width,
            relatedBy: .equal,
            toItem: uiImageView,
            attribute: .height,
            multiplier: 1,
            constant: 0
        ).isActive = true
        
        NSLayoutConstraint(
            item: uiImageView,
            attribute: .width,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .width,
            multiplier: 0.3,
            constant: 0
        ).isActive = true
        
        NSLayoutConstraint(
            item: uiImageView,
            attribute: .top,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .top,
            multiplier: 1,
            constant: 10
        ).isActive = true
        
        NSLayoutConstraint(
            item: uiImageView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .leading,
            multiplier: 1,
            constant: 20
        ).isActive = true
        
        NSLayoutConstraint(
            item: uiImageView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .bottom,
            multiplier: 1,
            constant: -10
        ).isActive = true
    }
    
    private func setupQueryLabelConstraints() {
        queryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: queryLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .top,
            multiplier: 1,
            constant: 15
        ).isActive = true
        
        NSLayoutConstraint(
            item: queryLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: uiImageView,
            attribute: .trailing,
            multiplier: 1,
            constant: 15
        ).isActive = true
        
        NSLayoutConstraint(
            item: queryLabel,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .trailing,
            multiplier: 1,
            constant: -10
        ).isActive = true
    }
    
    private func setupDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: dateLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: queryLabel,
            attribute: .bottom,
            multiplier: 1,
            constant: 10
        ).isActive = true
        
        NSLayoutConstraint(
            item: dateLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: uiImageView,
            attribute: .trailing,
            multiplier: 1,
            constant: 15
        ).isActive = true
        
        NSLayoutConstraint(
            item: dateLabel,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .trailing,
            multiplier: 1,
            constant: -10
        ).isActive = true
        
        NSLayoutConstraint(
            item: dateLabel,
            attribute: .bottom,
            relatedBy: .lessThanOrEqual,
            toItem: contentView,
            attribute: .bottom,
            multiplier: 1,
            constant: -10
        ).isActive = true
    }
    
    private func handleNewPictureData() {
        uiImageView.image = pictureData?.picture
        queryLabel.text = pictureData?.query
        
        if let date = pictureData?.createdAt {
            dateLabel.text = dateFormatter.string(from: date)
        }
    }
}
