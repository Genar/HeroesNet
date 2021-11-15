//
//  HerotItemTableViewCell.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import UIKit
import EamCoreUtils
import EamDomain

final class HerotItemTableViewCell: UITableViewCell {
  
  @IBOutlet weak var heroImageView: UIImageView!

  @IBOutlet weak var heroNameLabel: UILabel!

  @IBOutlet weak var heroDescriptionLabel: UILabel!

  @IBOutlet weak var heroNumSeriesLabel: UILabel!

  @IBOutlet weak var heroNumComicsLabel: UILabel!
  
  public func fill(with item: HeroDomain) {
    
    self.heroNameLabel.text = item.name
    self.heroDescriptionLabel.text = item.description
    self.heroNumSeriesLabel.text = item.numSeries
    self.heroNumComicsLabel.text = item.numComics
    self.heroImageView.image = UIImage(named: HeroItemStrings.heroEmptyImageKey)
  }
  
}
