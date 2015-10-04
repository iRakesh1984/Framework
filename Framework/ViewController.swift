//
//  ViewController.swift
//  Closures
//
//  Created by Anil Kothari on 26/07/15.
//  Copyright (c) 2015 Rakesh Kothari. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!

    var imageArray = ["1","2","3","4","5","6","7","8","9","10","11"]

    @IBOutlet weak var radialProgressView: RadialProgressView!
    @IBOutlet weak var loaderView: LoaderView!
    @IBOutlet weak var starView: StarView!

    override func viewDidLoad(){
        super.viewDidLoad()
        
 
        
        
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        radialProgressView.rotate()
        loaderView.rotate()
        
        starView.rating = 3
    }

    func `repeat`(i : Int , task:() -> Bool) {
        for iCounter in 0..<i {
            print(iCounter)
         }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5;
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cellList")!
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
 
        
        let label = cell.viewWithTag(101) as! UILabel

        label.text = "this is row number \(indexPath.row+1)"
        
        
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

