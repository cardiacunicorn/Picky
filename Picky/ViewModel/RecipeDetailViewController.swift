//
//  RecipeDetailViewController.swift
//  Picky
//
//  Created by Alex Mills on 18/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var selectedRecipe:(title:String, readyTime:Int, image:UIImage?)?
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailReadyTime: UILabel!
    @IBOutlet weak var detailTags: UILabel!
    @IBOutlet weak var detailIngredients: UILabel!
    @IBOutlet weak var detailInstructions: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedRecipe = selectedRecipe{
            detailTitle.text = selectedRecipe.title
            detailReadyTime.text = " " + String(selectedRecipe.readyTime) + "m "
            detailImage.image = selectedRecipe.image
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
