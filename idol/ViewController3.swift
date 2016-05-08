//
//  ViewController3.swift
//  idol
//
//  Created by 吴汪洋 on 15/12/15.
//  Copyright © 2015年 吴汪洋. All rights reserved.
//

import UIKit
import CoreData



class ViewController3:UIViewController {
    @IBOutlet weak var host_txt: UITextField!
    @IBOutlet weak var port_txt: UITextField!
    //@IBOutlet weak var ziding1_txt: UITextField!
    @IBOutlet weak var ziding2_txt: UITextField!
    @IBOutlet weak var ziding3_txt: UITextField!
    @IBOutlet weak var shezhiye_ai: UIActivityIndicatorView!
    @IBOutlet weak var connectbtn_ol: UIButton!
    @IBOutlet weak var disconnectbtn_ol: UIButton!
    @IBOutlet weak var stopheartbtn_ol: UIButton!
    @IBOutlet weak var startheartbtn_ol: UIButton!
    @IBOutlet weak var jieshou_txt: UITextView!
    @IBOutlet weak var fasong_txt: UITextField!
    
    
    
    
    func doInBackground(block:()->()){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            block()
        })
    }
    
    var oldWait:Bool = false
    var isRunning:Bool = false
    var oldConnect:Bool = false
    var timer: NSTimer?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if !isconnected {
            let(a,_) = client.connect(timeout:1)
            if a {
                isconnected = true
            }
        }
        
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
        }
        if isNeedRefresh3 {
            isNeedRefresh3 = false
            
        }
        oldIsRunningAI = !isRunningAi
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.isRunning = false
        timer?.invalidate()
        timer = nil
    }
    

    var oldIsRunningAI = !isRunningAi
    func updateTimer(timer: NSTimer) {
        //print("upadtatimer3")
        if isNeedRefresh3 {
            isNeedRefresh3 = false
            jieshou_txt.text = "\(recieve[0]) \(recieve[1]) \(recieve[2]) \(recieve[3]) \(recieve[4]) \(recieve[5]) \(recieve[6]) \(recieve[7]) \(recieve[8]) \(recieve[9]) \(recieve[10]) \(recieve[11]) \(recieve[12]) \(recieve[13]) \(recieve[14]) \(recieve[15]) \(recieve[16]) \(recieve[17]) "
        }
        
        if oldIsRunningAI != isRunningAi {
            if isRunningAi {
                shezhiye_ai.startAnimating()
            } else {
                shezhiye_ai.stopAnimating()
            }
            oldIsRunningAI = isRunningAi
        }
    }

    var resend = UIAlertAction(title: "重发", style: UIAlertActionStyle.Default){
        (action: UIAlertAction!) -> Void in
        if !isconnected {
           // isSended = false
            //            client.addr = host_var!
            //            client.port =  portnum_var!.integerValue
            print("==========")
            print(client.addr)
            print(client.port)
            let(a,b) = client.connect(timeout:1)
            print(b)
            if a == true {
                isconnected = true
                let ii:[UInt8] = [0xaa,0,255]
                let (_,_)=client.send(data:ii)
            }
        }
    }
    var reconnect = UIAlertAction(title: "重连", style: UIAlertActionStyle.Default){
        (action: UIAlertAction!) -> Void in
        if !isconnected {
          //  isSended = false
            //            client.addr = host_var!
            //            client.port =  portnum_var!.integerValue
            print("==========")
            print(client.addr)
            print(client.port)
            let(a,b) = client.connect(timeout:1)
            print(b)
            if a == true {
                isconnected = true
                let ii:[UInt8] = [0xaa,0,255]
                let (_,_)=client.send(data:ii)
            }
        }
        
    }
    var cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default){
        (action: UIAlertAction!) -> Void in
        print("you choose cancel")
      //  isSended = false
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if isconnected {
            connectbtn_ol.enabled = false
            disconnectbtn_ol.enabled = true
        }else {
            connectbtn_ol.enabled = true
            disconnectbtn_ol.enabled = false
        }
        
        if isTimering {
            startheartbtn_ol.enabled = false
            stopheartbtn_ol.enabled = true
        }else {
            startheartbtn_ol.enabled = true
            stopheartbtn_ol.enabled = false
        }
        
        alertreconnect = UIAlertController(title: "", message: "网络连接失败！", preferredStyle: UIAlertControllerStyle.Alert)
        alertreconnect?.addAction(reconnect)
        alertreconnect?.addAction(cancel)
        
        alertresend = UIAlertController(title: "", message: "数据发送失败！", preferredStyle: UIAlertControllerStyle.Alert)
        alertresend?.addAction(resend)
        alertresend?.addAction(cancel)
        
        sendheart()
        
        //获取管理的数据上下文 对象
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        var fetchedObjects:AnyObject?
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        //声明数据的请求
        
        fetchRequest.fetchLimit = 20 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("IdolEntity",
            inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        let predicate = NSPredicate(format: "id= '1' ", "")
        fetchRequest.predicate = predicate
        
        //查询操作
        
        
        print("start")
        
        
        do {
            try  fetchedObjects = context.executeFetchRequest(fetchRequest)
            //print("fetch pass!")
            print(fetchedObjects?.count)
            if fetchedObjects?.count==0
            {
                //add()
                print("view3 add")
            }
            else
            {
                for cd1 in fetchedObjects as! [IdolEntity]
                //let temp = cd1.port
                {
                    let formatter = NSNumberFormatter()
                    formatter.numberStyle = NSNumberFormatterStyle.NoStyle;
                    host_txt.text=cd1.host
                    let str:String = formatter.stringFromNumber(cd1.portnum!)!
                    port_txt.text=str
                    //ziding1_txt.text = cd1.button1
                    ziding2_txt.text = cd1.button2
                    ziding3_txt.text = cd1.button3
                    print("view3 fetch pass")
                }
            }
            
        } catch{
            print("fetch failed!")
            
        }
        // Do any additional setup after loading the view.
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData)
    {
        print("ReceiveData3");
        let datastring = NSString(data:data, encoding: NSUTF8StringEncoding)
        print(datastring)
        let strr = datastring!.UTF8String
        //jieshou_txt.text = strr
        let dict:NSDictionary?
        do {
            dict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            
            
            let data1 = dict!["devices"] as? NSArray
            for  obj in data1!{
                let id = obj.objectForKey("id") as! NSNumber
                let type = obj.objectForKey("type") as! NSNumber
                let status = obj.objectForKey("status") as! NSArray
                let name = obj.objectForKey("name") as! NSString
                print(id)
                print(name)
                print(type)
                print(UInt8(status[0].intValue))
                switch(name){
                case "KETING_ID":
                    recieve[12] = UInt8(status[0].intValue)
                    break;
                case "CANTING_ID":
                    recieve[13] = UInt8(status[0].intValue)
                    break;
                case "CHUFANG_ID":
                    recieve[15] = UInt8(status[0].intValue)
                    break;
                case "GUODAO_ID":
                    recieve[10] = UInt8(status[0].intValue)
                    recieve[16] = UInt8(status[1].intValue)
                    break;
                case "MENTING_ID"	:
                    recieve[14] = UInt8(status[0].intValue)
                    break;
                case "ZHUWO_ID":
                    recieve[6] = UInt8(status[0].intValue)
                    break;
                case "CIWO_ID":
                    recieve[8] = UInt8(status[0].intValue)
                    break;
                case "MODE":
                    recieve[1] = UInt8(status[0].intValue)
                    break;
                case "ZHUWOQIYE":
                    recieve[17] = UInt8(status[0].intValue)
                    break;
                case "CIWOQIYE":
                    recieve[18] = UInt8(status[0].intValue)
                    break;
                case "KETINGCHUANGLIAN":
                    recieve[3] = UInt8(status[0].intValue)
                    break;
                case "ZHUWOCHUANGLIAN":
                    recieve[4] = UInt8(status[0].intValue)
                    break;
                case "CIWOCHUANGLIAN":
                    recieve[5] = UInt8(status[0].intValue)
                    break;
                case "ZHUWODENGLIANGDU":
                    recieve[7] = UInt8(status[0].intValue)
                    break;
                case "CIWODENGLIANGDU":
                    recieve[9] = UInt8(status[0].intValue)
                    break;
                case "CESUODENGLIANGDU":
                    recieve[11] = UInt8(status[0].intValue)
                    break;
                default:break;
                }
                
                
            }
            
            isRecieved = true
            isNeedRefresh1 = true
            isNeedRefresh2 = true
            isNeedRefresh3 = true
            isRunningAi = false
        }catch _ {
            dict = nil
        }
    }
    func sendheart()
    {
        print("send heart！");
        isRunningAi = true
        let urlString:String = host_var!
        var url:NSURL!
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(URL:url)
        let body = "{\"type\":\"heart\"}"
        print(body)
        //编码POST数据
        let postData = body.dataUsingEncoding(NSASCIIStringEncoding)
        //保用 POST 提交
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        var conn:NSURLConnection!
        conn = NSURLConnection(request: request,delegate: self)
        conn.start()
        print(conn)
        
    }
    func sendpost(id:NSString ,action1:NSNumber = 3,action2:NSNumber = 3)
    {
        print("send post！");
        print(host_var);
        isRunningAi = true
        let urlString:String = host_var!
        var url:NSURL!
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(URL:url)
        let body = "{\"name\":\"\(id)\",\"type\":\"control_down\",\"state1\":\(action1),\"state2\":\(action2),\"state3\":\(action1)}"
        print(body)
        //编码POST数据
        let postData = body.dataUsingEncoding(NSASCIIStringEncoding)
        //保用 POST 提交
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        var conn:NSURLConnection!
        conn = NSURLConnection(request: request,delegate: self)
        conn.start()
        print(conn)
        
    }
    
    @IBAction func lijia_setmode(sender: AnyObject) {
        isSended = true
        isRunningAi = true
        sendpost("SETMODE",action1:0)
    }
    @IBAction func huijia_setmode(sender: AnyObject) {
        isSended = true
        isRunningAi = true
        sendpost("SETMODE",action1:1)
    }
   
    @IBAction func ziding2_setmode(sender: AnyObject) {
        isSended = true
        isRunningAi = true
        sendpost("SETMODE",action1:2)
    }
    @IBAction func ziding3_setmode(sender: AnyObject) {
        isSended = true
        isRunningAi = true
        sendpost("SETMODE",action1:3)
    }
    @IBAction func save(sender: AnyObject) {
        //获取管理的数据上下文 对象
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        var fetchedObjects:AnyObject?
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        //声明数据的请求
       
        fetchRequest.fetchLimit = 20 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("IdolEntity",
            inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        let predicate = NSPredicate(format: "id= '1' ", "")
        fetchRequest.predicate = predicate
        
        //查询操作
        
        
        print("save start")
        
        
        do {
            try  fetchedObjects = context.executeFetchRequest(fetchRequest)
            print("save fetch pass!")
            print(fetchedObjects?.count)
            if fetchedObjects?.count==0
            {
                //add()
            }
            else
            {
                for cd1 in fetchedObjects as![IdolEntity]
                {
                    let formatter = NSNumberFormatter()
                    formatter.numberStyle = NSNumberFormatterStyle.NoStyle;
                    let number = formatter.numberFromString(port_txt.text!)
                        
                    cd1.host=host_txt.text
                    cd1.portnum=number
                    //cd1.button1 = ziding1_txt.text
                    cd1.button2 = ziding2_txt.text
                    cd1.button3 = ziding3_txt.text
                    //refresh(str1: cd1.button1!, str2: cd1.button2!)
                    host_var = cd1.host
                    portnum_var = cd1.portnum
                    print(number)
                }
                
            }
            
        } catch{
            print("save fetch failed!")
            
        }

        do {
            try context.save()
            
            let(a,b)=client.close()
            print(b)
            if a == true {
                isconnected = false
            }
            if !isconnected {
                client.addr = host_var!
                client.port =  portnum_var!.integerValue
                print("==========")
                print(client.addr)
                print(client.port)
                let(a,b) = client.connect(timeout:3)
                print(b)
                if a == true {
                    isconnected = true
                    if isconnected {
                        connectbtn_ol.enabled = false
                        disconnectbtn_ol.enabled = true
                    }else {
                        connectbtn_ol.enabled = true
                        disconnectbtn_ol.enabled = false
                    }
                    let ii:[UInt8] = [0xaa,0,255]
                    let (_,_)=client.send(data:ii)
                }
            }
            
            print("add pass!")
            // print(cd1.host)
            
        }
        catch{
            print("add failed!")
        }
        
    }
    
    @IBAction func sendbtn(sender: AnyObject) {
        isSended = true
        isRunningAi = true
        
        let str = fasong_txt.text
      
        print("send BTN！");
        isRunningAi = true
        let urlString:String = "http://wangyangzhuji.imwork.net:8888"
        var url:NSURL!
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(URL:url)
        let body = str
        print(body)
        //编码POST数据
        let postData = body!.dataUsingEncoding(NSASCIIStringEncoding)
        //保用 POST 提交
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        var conn:NSURLConnection!
        conn = NSURLConnection(request: request,delegate: self)
        conn.start()
        print(conn)
    }
    
    @IBAction func connect_btn(sender: AnyObject) {
    
    }
    
    @IBAction func disconnect_btn(sender: AnyObject) {
    
    }
    
    @IBAction func stopheart_btn(sender: AnyObject) {
        isTimering = false
        if isTimering {
            startheartbtn_ol.enabled = false
            stopheartbtn_ol.enabled = true
        }else {
            startheartbtn_ol.enabled = true
            stopheartbtn_ol.enabled = false
        }
    }
    
    @IBAction func startheart_btn(sender: AnyObject) {
        isTimering = true
        if isTimering {
            startheartbtn_ol.enabled = false
            stopheartbtn_ol.enabled = true
        }else {
            startheartbtn_ol.enabled = true
            stopheartbtn_ol.enabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
