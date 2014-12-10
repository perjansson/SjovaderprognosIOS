//
//  AreasViewController.swift
//  Sjovaderprognos
//
//  Created by Per Jansson on 2014-12-10.
//  Copyright (c) 2014 Per Jansson. All rights reserved.
//

import UIKit

typealias JSONDictionary = Dictionary<String, AnyObject>
typealias JSONArray = Array<AnyObject>

class AreasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let responseData = NSMutableData()
    var areas : [Area] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getAreas();
    }
    
    func getAreas() {
        let request = NSURLRequest(URL: NSURL(string: "http://sjovaderprognos.herokuapp.com/Areas")!)
        let conn = NSURLConnection(request: request, delegate:self)
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.responseData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var json : AnyObject! = NSJSONSerialization.JSONObjectWithData(self.responseData, options: NSJSONReadingOptions.MutableLeaves, error: nil)
        self.areas = self.handleGetAreas(json)
        self.tableView.reloadData()
    }
    
    func handleGetAreas(json: AnyObject) -> [Area] {
        var areas = Array<Area>()
        if let areaObjects = json as? JSONArray {
            for areaObject: AnyObject in areaObjects {
                if let areaAsJson = areaObject as? JSONDictionary {
                    if let area = Area.createFromJson(areaAsJson) {
                        areas.append(area)
                    }
                }
            }
        }
        return areas
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = areas[indexPath.row].areaName
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
}

