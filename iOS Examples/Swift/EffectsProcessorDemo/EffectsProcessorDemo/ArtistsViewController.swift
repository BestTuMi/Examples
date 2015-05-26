//
//  ArtistsViewController.swift
//  EffectsProcessorDemo
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ArtistsViewController: UITableViewController {
    
    var artistList: [MPMediaItemCollection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistList = MPMediaQuery.artistsQuery().collections as! [MPMediaItemCollection]
        tableView.reloadData()
 
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistList.count
    }

      override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MusicCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell

        // Configure the cell...
        let repItem = artistList[indexPath.row].representativeItem!
        let artistName = repItem.valueForProperty(MPMediaItemPropertyArtist) as! String
        cell.textLabel?.text = artistName
        
        return cell
    }

    // MARK: - Navigation
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AlbumsSegue" {
            let senderCell = sender as! UITableViewCell
            let albumsVC = segue.destinationViewController as! AlbumsViewController
            albumsVC.artistName = senderCell.textLabel?.text
            albumsVC.title = senderCell.textLabel?.text
        }
    }


}
