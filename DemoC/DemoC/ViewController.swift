//
//  ViewController.swift
//
//  Created  on 28/11/18.
//

import UIKit
import CoreData
import SwiftyJSON
import Foundation

class infoCell: UITableViewCell
{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
 
    var info : Lists?
    {
        didSet
        {
            if self.info != nil
            {
                lblTitle.text = info?.category
                lblCompany.text = info?.compName
            }
        }
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tblv: UITableView!
 
    var page : Int! = 1
    
    var infoList : NSMutableArray! = []
    var info : infoData!
    var currentPage : Int!
    var totalPage : Int!
 
    //MARK:- ViewControllers Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
 
//        let param = [:] as [String : Any]
//
//        self.getInfos(type:param)
        
        self.getListFromCoreData()
    }
    
    //MARK:- API
    func getInfos(type: [String:Any]?)
    {
        let parameter  = type

        webserviceAPI.getInfo(parameter) { (localInfo) in

            if localInfo != nil
            {
                self.infoList.addObjects(from: (localInfo?.info?.List)!)
                self.totalPage = localInfo?.info?.total
                self.currentPage = localInfo?.info?.currentPage
                self.tblv.reloadData()

                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

                let managedContext = appDelegate.persistentContainer.viewContext

                for i in 0...self.infoList!.count - 1
                {
                    let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext) as! User

                    let inf = self.infoList[i] as! Lists
                    user.companyname = inf.compName
                    user.category = inf.category
                }

                do
                {
                    try managedContext.save()
                }
                catch
                {
                    print(error)
                }
            }
        }
    }
    
    func getListFromCoreData()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.returnsObjectsAsFaults = false
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        do
        {
            let result = try context.fetch(request)
 
            for data in result //as! [NSManagedObject]
            {
                let param = ["category" : (data as! User).category!,
                             "companyname" : (data as! User).companyname! ] as [String : Any]
                let record = Lists(parameterDict: param)
                self.infoList.add(record)
                //  print("\((data as! User).companyname)")
                //  print(data.value(forKey: "companyname") as! String)
            }
            tblv.reloadData()
        }
        catch
        {
            print("Failed")
        }
    }
    
    //MARK:- UITableView Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tblv!.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! infoCell
        
        cell.info = (infoList[indexPath.row] as! Lists)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if (indexPath.row == self.infoList.count - 1 && currentPage != totalPage)
        {
            page = page + 1
            let param = [:] as [String : Any]

            self.getInfos(type:param)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return infoList?.count ?? 0
    }
}



