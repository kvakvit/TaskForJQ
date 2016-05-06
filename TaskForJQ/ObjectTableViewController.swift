//
//  ObjectTableViewController.swift
//  TestTaskForJQ
//
//  Created by Виталий on 05.05.16.
//  Copyright © 2016 kvakvit. All rights reserved.
//

import UIKit

class ObjectTableViewController: UITableViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var objects: [JQApi.Object] = []
    var offset: Int = 0

    var loadMoreStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableViewAutomaticDimension


        self.tableView.tableFooterView!.hidden = true
        
        loadMore(offset)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ObjectCell", forIndexPath: indexPath) as! HeaderTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.capture.image = nil
        cell.object = objects[indexPath.row]

        return cell
    }
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 {
            offset += 5
            loadMore(offset)
        }
    }
    
    func loadMore(offset: Int) {
        
        if ( !loadMoreStatus ) {
            self.loadMoreStatus = true
            self.activityIndicator.startAnimating()
            self.tableView.tableFooterView!.hidden = false
            loadMoreBegin(offset,
                          loadMoreEnd: {(x:Int) -> () in
                            self.tableView.reloadData()
                            self.loadMoreStatus = false
                            self.activityIndicator.stopAnimating()
                            self.tableView.tableFooterView!.hidden = true
            })
        }
        
    }
    
    func loadMoreBegin(offset: Int, loadMoreEnd:(Int) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            
            JQApi().fetchObjects(offset) { (objects: [JQApi.Object]) -> Void in
                self.objects += objects
            }
            sleep(2)
            
            dispatch_async(dispatch_get_main_queue()) {
                loadMoreEnd(0)
            }
            
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
