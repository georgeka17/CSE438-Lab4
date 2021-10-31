//
//  CollectionViewCell.swift
//  KripaGeorge1-Lab4
//
//  Created by Kripa on 10/30/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
 
    
    // awakeFromNib() overrides from this link:    https://theswiftdev.com/ultimate-uicollectionview-guide-with-ios-examples-written-in-swift/
        
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override init(frame: CGRect) {
            super.init(frame: frame)

            let movieTitle = UILabel(frame: .zero)
            movieTitle.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(movieTitle)
            //change this to get different sizes
            NSLayoutConstraint.activate([
                movieTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                movieTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                movieTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                movieTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            ])
            self.movieTitle = movieTitle

            self.contentView.backgroundColor = .lightGray
            self.movieTitle.textAlignment = .center // text alignment inside contentView
       
            let moviePoster = UIImageView(frame: .zero)
            moviePoster.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(moviePoster)
        //change this to get different sizes
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            moviePoster.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            moviePoster.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            moviePoster.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
        self.moviePoster = moviePoster

        self.contentView.backgroundColor = .lightGray
        //self.movieTitle.textAlignment = .center // text alignment inside contentView
    }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)

            fatalError("Interface Builder is not supported!")
        }

        override func awakeFromNib() {
            super.awakeFromNib()

            fatalError("Interface Builder is not supported!")
        }

        override func prepareForReuse() {
            super.prepareForReuse()

            self.movieTitle.text = nil
        }
    
   
}
