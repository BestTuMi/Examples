//
//  AlbumsViewController.swift
//  EffectsProcessorDemo
//
//  Created by Matthew Fecher on 5/23/15.
//  Copyright (c) 2015 audiokit.io. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class AlbumsViewController: UITableViewController {
    
    var artistName: String!
    var albumsList = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let artistPredicate = MPMediaPropertyPredicate(value: artistName, forProperty: MPMediaItemPropertyArtist, comparisonType: MPMediaPredicateComparison.Contains)
        
        let albumsQuery = MPMediaQuery.albumsQuery()
        albumsQuery.addFilterPredicate(artistPredicate)
        
        albumsList = albumsQuery.collections
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsList.count
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cellIdentifier = "AlbumCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell

        // Configure the cell...
        let repItem = albumsList[indexPath.row].representativeItem!
        let albumTitle = repItem.valueForProperty(MPMediaItemPropertyAlbumTitle) as! String
        cell.textLabel?.text = albumTitle

        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "SongsSegue" {
            let senderCell = sender as! UITableViewCell
            let songsVC = segue.destinationViewController as! SongsViewController
            songsVC.artistName = artistName
            songsVC.albumName = senderCell.textLabel?.text
            songsVC.title = senderCell.textLabel?.text
        }
        
    }

}
