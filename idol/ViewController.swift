//--
//  ViewController.swift
//  idol
//
//  Created by 吴汪洋 on 15/12/9.
//  Copyright © 2015年 吴汪洋. All rights reserved.
//

import UIKit
import CoreData
import Accelerate
var host_var:String?
var portnum_var:NSNumber?
import Foundation
var isconnected:Bool = false
var isSending:Bool = false
var isSended:Bool = false
var isWaiting:Bool = false
var isRecieved:Bool = false
var isTimering:Bool = true
var isNeedRefresh1 = false
var isNeedRefresh2 = false
var isNeedRefresh3 = false
var isRunningAi = true
//var isStopAi = false
//var isNeedrefreshzhuyeai = true

var needReconnect:Bool = false
var name1_var:String? = nil
var name2_var:String? = nil
var name3_var:String? = nil

var recieve:[UInt8] = [0xaa,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00]
var alertresend:UIAlertController?
var alertreconnect:UIAlertController?
var client:TCPClient = TCPClient(addr: "192.168.1.121", port: 12345)

var resend = UIAlertAction(title: "重发", style: UIAlertActionStyle.Default){
    (action: UIAlertAction!) -> Void in
    if !isconnected {
        //isSended = false
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
        //isSended = false
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
    //isSended = false
}

class ViewController: UIViewController {
    @IBOutlet weak var port: UITextField!
    @IBOutlet weak var host: UITextField!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var mode_plain: UISegmentedControl!
    @IBOutlet weak var zhuwoqiyebtn_ol: UIButton!
    @IBOutlet weak var ciwoqiyebtn_ol: UIButton!
    @IBOutlet weak var zhuye_ai: UIActivityIndicatorView!
    @IBOutlet weak var cesuodengbtn_ol: UIButton!
    @IBOutlet weak var guodaodengbtn_ol: UIButton!
    @IBOutlet weak var ciwodengbtn_ol: UIButton!
    @IBOutlet weak var zhuwodengbtn_ol: UIButton!
    @IBOutlet weak var ketingdengbtn_ol: UIButton!
    @IBOutlet weak var cantingdengbtn_ol: UIButton!
    @IBOutlet weak var mentingdengbtn_ol: UIButton!
    @IBOutlet weak var chufangdengbtn_ol: UIButton!
    @IBOutlet weak var ketingchaunglianbtn_ol: UIButton!
    @IBOutlet weak var zhuwochuanglianbtn_ol: UIButton!
    @IBOutlet weak var ciwochuanglianbtn_ol: UIButton!
    @IBOutlet weak var shoudongkongzhibtn_ol: UIButton!
    
    var timer: NSTimer?
    var timer2: NSTimer?
    //func doInBackground(block:()->()){
     //   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
     //       block()
     //   })
    //}
    

   
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if(segue.identifier == "toBviewController"){
//            var bVc:ViewController2 = segue.destinationViewController as! ViewController2
//            bVc.tempString = textField.text
//            bVc.delegate = self
//        }
//    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
      

        
        if timer2 == nil {
            timer2 = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTimer2:", userInfo: nil, repeats: true)
        }
        oldIsRunningAI = !isRunningAi
        refresh()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        timer2?.invalidate()
        timer2 = nil
    }
    
    func refreshbtn() {
        if recieve[3] == 0 {
            ketingchaunglianbtn_ol.setImage(UIImage(named:"客厅窗帘100"), forState:.Normal )
        } else if ((recieve[3] > 0) && (recieve[3] < 10)){
            ketingchaunglianbtn_ol.setImage(UIImage(named:"客厅窗帘90"), forState:.Normal )
        } else if ((recieve[3] >= 10) && (recieve[3] < 20)){
            ketingchaunglianbtn_ol.setImage(UIImage(named:"客厅窗帘80"), forState:.Normal )
        } else if ((recieve[3] >= 20) && (recieve[3] < 30)){
            ketingchaunglianbtn_ol.setImage(UIImage(named:"客厅窗帘70"), forState:.Normal )
        } else if ((recieve[3] >= 30) && (recieve[3] < 40)){
            ketingchaunglianbtn_ol.setImage(UIImage(named:"客厅窗帘50"), forState:.Normal )
        } else if ((recieve[3] >= 40) && (recieve[3] < 50)){
            ketingchaunglianbtn_ol.setImage(UIImage(named:"客厅窗帘50"), forState:.Normal )
        } else if ((recieve[3] >= 50) && (recieve[3] < 60)){
            ketingchaunglianbtn_ol.setImage(UIImage(named:"客厅窗帘40"), forState:.Normal )
        } else if ((recieve[3] >= 60) && (recieve[3] < 70)){
            ketingchaunglianbtn_ol.setImage(UIImage(named:"客厅窗帘30"), forState:.Normal )
        } else if ((recieve[3] >= 70) && (recieve[3] < 80)){
            ketingchaunglianbtn_ol.setImage(UIImage(named:"客厅窗帘20"), forState:.Normal )
        } else if ((recieve[3] >= 80) && (recieve[3] < 90)){
            ketingchaunglianbtn_ol.setImage(UIImage(named:"客厅窗帘10"), forState:.Normal )
        } else if ((recieve[3] >= 90) && (recieve[3] <= 100)){
            ketingchaunglianbtn_ol.setImage(UIImage(named:"客厅窗帘0"), forState:.Normal )
        } else if recieve[3] == 255 {
            ketingchaunglianbtn_ol.setImage(UIImage(named:"客厅窗帘-cha"), forState:.Normal )
        }
        
        if recieve[4] == 0 {
            zhuwochuanglianbtn_ol.setImage(UIImage(named:"主卧窗帘100"), forState:.Normal )
        } else if ((recieve[4] > 0) && (recieve[4] < 10)){
            zhuwochuanglianbtn_ol.setImage(UIImage(named:"主卧窗帘90"), forState:.Normal )
        } else if ((recieve[4] >= 10) && (recieve[4] < 20)){
            zhuwochuanglianbtn_ol.setImage(UIImage(named:"主卧窗帘80"), forState:.Normal )
        } else if ((recieve[4] >= 20) && (recieve[4] < 30)){
            zhuwochuanglianbtn_ol.setImage(UIImage(named:"主卧窗帘70"), forState:.Normal )
        } else if ((recieve[4] >= 30) && (recieve[4] < 40)){
            zhuwochuanglianbtn_ol.setImage(UIImage(named:"主卧窗帘60"), forState:.Normal )
        } else if ((recieve[4] >= 40) && (recieve[4] < 50)){
            zhuwochuanglianbtn_ol.setImage(UIImage(named:"主卧窗帘50"), forState:.Normal )
        } else if ((recieve[4] >= 50) && (recieve[4] < 60)){
            zhuwochuanglianbtn_ol.setImage(UIImage(named:"主卧窗帘40"), forState:.Normal )
        } else if ((recieve[4] >= 60) && (recieve[4] < 70)){
            zhuwochuanglianbtn_ol.setImage(UIImage(named:"主卧窗帘30"), forState:.Normal )
        } else if ((recieve[4] >= 70) && (recieve[4] < 80)){
            zhuwochuanglianbtn_ol.setImage(UIImage(named:"主卧窗帘20"), forState:.Normal )
        } else if ((recieve[4] >= 80) && (recieve[4] < 90)){
            zhuwochuanglianbtn_ol.setImage(UIImage(named:"主卧窗帘10"), forState:.Normal )
        } else if ((recieve[4] >= 90) && (recieve[4] <= 100)){
            zhuwochuanglianbtn_ol.setImage(UIImage(named:"主卧窗帘0"), forState:.Normal )
        } else if recieve[4] == 255 {
            zhuwochuanglianbtn_ol.setImage(UIImage(named:"主卧窗帘-cha"), forState:.Normal )
        }
        
        
        if recieve[5] == 0 {
            ciwochuanglianbtn_ol.setImage(UIImage(named:"次卧窗帘100"), forState:.Normal )
        } else if ((recieve[5] > 0) && (recieve[5] < 10)){
            ciwochuanglianbtn_ol.setImage(UIImage(named:"次卧窗帘90"), forState:.Normal )
        } else if ((recieve[5] >= 10) && (recieve[5] < 20)){
            ciwochuanglianbtn_ol.setImage(UIImage(named:"次卧窗帘80"), forState:.Normal )
        } else if ((recieve[5] >= 20) && (recieve[5] < 30)){
            ciwochuanglianbtn_ol.setImage(UIImage(named:"次卧窗帘70"), forState:.Normal )
        } else if ((recieve[5] >= 30) && (recieve[5] < 40)){
            ciwochuanglianbtn_ol.setImage(UIImage(named:"次卧窗帘60"), forState:.Normal )
        } else if ((recieve[5] >= 40) && (recieve[5] < 50)){
            ciwochuanglianbtn_ol.setImage(UIImage(named:"次卧窗帘50"), forState:.Normal )
        } else if ((recieve[5] >= 50) && (recieve[5] < 60)){
            ciwochuanglianbtn_ol.setImage(UIImage(named:"次卧窗帘40"), forState:.Normal )
        } else if ((recieve[5] >= 60) && (recieve[5] < 70)){
            ciwochuanglianbtn_ol.setImage(UIImage(named:"次卧窗帘30"), forState:.Normal )
        } else if ((recieve[5] >= 70) && (recieve[5] < 80)){
            ciwochuanglianbtn_ol.setImage(UIImage(named:"次卧窗帘20"), forState:.Normal )
        } else if ((recieve[5] >= 80) && (recieve[5] < 90)){
            ciwochuanglianbtn_ol.setImage(UIImage(named:"次卧窗帘10"), forState:.Normal )
        } else if ((recieve[5] >= 90) && (recieve[5] <= 100)){
            ciwochuanglianbtn_ol.setImage(UIImage(named:"次卧窗帘0"), forState:.Normal )
        } else if recieve[5] == 255 {
            ciwochuanglianbtn_ol.setImage(UIImage(named:"次卧窗帘-cha"), forState:.Normal )
        }
        
        if recieve[6] == 1 {
            
            zhuwodengbtn_ol.setImage(UIImage(named:"open2"), forState:.Normal )
        } else if recieve[6] == 0 {
            zhuwodengbtn_ol.setImage(UIImage(named:"close2"), forState:.Normal )
        } else if recieve[6] == 255 {
            zhuwodengbtn_ol.setImage(UIImage(named:"close2-cha"), forState:.Normal )
        }
        
        if recieve[8] == 1 {
            
            ciwodengbtn_ol.setImage(UIImage(named:"open2"), forState:.Normal )
        } else if recieve[8] == 0 {
            ciwodengbtn_ol.setImage(UIImage(named:"close2"), forState:.Normal )
        } else if recieve[8] == 255 {
            ciwodengbtn_ol.setImage(UIImage(named:"close2-cha"), forState:.Normal )
        }
        
        if recieve[10] == 1 {
            
            cesuodengbtn_ol.setImage(UIImage(named:"open2"), forState:.Normal )
        } else if recieve[10] == 0 {
            cesuodengbtn_ol.setImage(UIImage(named:"close2"), forState:.Normal )
        } else if recieve[10] == 255 {
            cesuodengbtn_ol.setImage(UIImage(named:"close2-cha"), forState:.Normal )
        }
        
        if recieve[12] == 1 {
            
            ketingdengbtn_ol.setImage(UIImage(named:"open2"), forState:.Normal )
        } else if recieve[12] == 0 {
            ketingdengbtn_ol.setImage(UIImage(named:"close2"), forState:.Normal )
        } else if recieve[12] == 255 {
            ketingdengbtn_ol.setImage(UIImage(named:"close2-cha"), forState:.Normal )
        }
        
        if recieve[13] == 1 {
            
            cantingdengbtn_ol.setImage(UIImage(named:"open2"), forState:.Normal )
        } else if recieve[13] == 0 {
            cantingdengbtn_ol.setImage(UIImage(named:"close2"), forState:.Normal )
        } else if recieve[13] == 255 {
            cantingdengbtn_ol.setImage(UIImage(named:"close2-cha"), forState:.Normal )
        }
        
        if recieve[14] == 1 {
            
            mentingdengbtn_ol.setImage(UIImage(named:"open2"), forState:.Normal )
        } else if recieve[14] == 0 {
            mentingdengbtn_ol.setImage(UIImage(named:"close2"), forState:.Normal )
        } else if recieve[14] == 255 {
            mentingdengbtn_ol.setImage(UIImage(named:"close2-cha"), forState:.Normal )
        }
        
        if recieve[15] == 1 {
            
            chufangdengbtn_ol.setImage(UIImage(named:"open2"), forState:.Normal )
        } else if recieve[15] == 0 {
            chufangdengbtn_ol.setImage(UIImage(named:"close2"), forState:.Normal )
        } else if recieve[15] == 255 {
            chufangdengbtn_ol.setImage(UIImage(named:"close2-cha"), forState:.Normal )
        }
        
        if recieve[16] == 1 {
            
            guodaodengbtn_ol.setImage(UIImage(named:"open2"), forState:.Normal )
        } else if recieve[16] == 0 {
            guodaodengbtn_ol.setImage(UIImage(named:"close2"), forState:.Normal )
        } else if recieve[16] == 255 {
            guodaodengbtn_ol.setImage(UIImage(named:"close2-cha"), forState:.Normal )
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
        sendheart()
        //alertreconnect = UIAlertController(title: "", message: "网络连接失败！", preferredStyle: UIAlertControllerStyle.Alert)
        //alertreconnect?.addAction(reconnect)
        //alertreconnect?.addAction(cancel)
        
        //alertresend = UIAlertController(title: "", message: "数据发送失败！", preferredStyle: UIAlertControllerStyle.Alert)
       // alertresend?.addAction(resend)
        //alertresend?.addAction(cancel)
        
       
        
        
//        self.doInBackground({
//            
//            while true {
//                //print("recieve while")
//                if isconnected {
//                    if let data=client.read(19){
//                        print(data)
//                        
//                        if (data.count == 19) && (data[0] == 0xaa) {
//                            recieve = data
//                            isRecieved = true
//                            //isSended = false
//                            isNeedRefresh1 = true
//                            isNeedRefresh2 = true
//                            isNeedRefresh3 = true
//                            isRunningAi = false
//                            dispatch_async(dispatch_get_main_queue(), {
//                                self.zhuye_ai.stopAnimating()
//                                self.refreshbtn()
//                                switch recieve[1] {
//                                case 0:self.mode_plain.selectedSegmentIndex = 0
//                                    break
//                                case 1:self.mode_plain.selectedSegmentIndex = 1
//                                    break
//                                case 2:self.mode_plain.selectedSegmentIndex = 3
//                                    break
//                                case 3:self.mode_plain.selectedSegmentIndex = 4
//                                    break
//                                case 4:self.mode_plain.selectedSegmentIndex = 2
//                                    break
//                                default:break
//                                }
//                                
//                                if recieve[17] == 1 {
//                                    self.zhuwoqiyebtn_ol.backgroundColor = UIColor.darkGrayColor()
//                                } else {
//                                    self.zhuwoqiyebtn_ol.backgroundColor = self.shoudongkongzhibtn_ol.backgroundColor
//                                }
//                                if recieve[18] == 1 {
//                                    self.ciwoqiyebtn_ol.backgroundColor = UIColor.darkGrayColor()
//                                } else {
//                                    self.ciwoqiyebtn_ol.backgroundColor = self.shoudongkongzhibtn_ol.backgroundColor
//                                }
//                                
//                            })
//                        }
//                    }
//                    
//                }
//                
//                NSThread.sleepForTimeInterval(0.1)
//            }
//            
//        })
        
        refresh()
        
        //zhuye_ai.startAnimating()
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
        //print(client.port)
    }
    
    func updateTimer(timer: NSTimer) {
         print("sendheart")
        //isTimering = !isTimering
        
        if isTimering {
            if(!isSended){
                sendheart()
            }
            isSended = false
        }
        
    }
    
    var oldIsRunningAI = !isRunningAi
    func updateTimer2(timer: NSTimer) {
        
        if oldIsRunningAI != isRunningAi {
            if isRunningAi {
                zhuye_ai.startAnimating()
            } else {
                zhuye_ai.stopAnimating()
            }
            oldIsRunningAI = isRunningAi
        }
    }
    @IBAction func mode_set(sender: AnyObject) {
        let seg:UISegmentedControl = sender as! UISegmentedControl
        switch seg.selectedSegmentIndex{
            case 0:
                isSended = true
                isRunningAi = true
                sendpost("MODE",action1:0)
            break
            
            case 1:
                isSended = true
                isRunningAi = true
                sendpost("MODE",action1:1)
                
            break
            
            case 3:
                isSended = true
                isRunningAi = true
                sendpost("MODE",action1:2)
            break
            
            case 4:
                isSended = true
                isRunningAi = true
                sendpost("MODE",action1:3)
            break
            default:break
        }
        
    }
    
    @IBAction func zhuwoqiye_btn(sender: AnyObject) {
        
        
        
        if recieve[17] == 0 {
            sendpost("ZHUWOQIYE",action1:1,action2:1)
        } else {
            sendpost("ZHUWOQIYE",action1:0,action2:0)
        }
        /*
        0xFAF8 =XIAOMIKAIGUAN1-zhuwo
        0x1AD6 =XIAOMIKAIGUAN2-ciwo
        0xFC44 =XIAOMIMENCI
        
        0x4E8A =KETING
        0xB358 =CANTING
        0xBE8A =CHUFANG
        0xE6B0 =MENTING
        0x5680 =GUODAO
        0x7710 =ZHUWO
        0x9590 =CIWO
        */
        
        /*
         

         
         if isconnected {
           
            var ii:[UInt8] = [0xaa,18,1]
            if recieve[17] == 0 {
              ii = [0xaa,18,1]
            } else {
                ii = [0xaa,18,0]
            }
            
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
            }
            isSending = false
        
        } else {
            isconnected = false
            self.presentViewController(alertreconnect!, animated: true, completion: nil)
        }
        */
        
        
    }
 
    func sendpost(id:NSString ,action1:NSNumber = 3,action2:NSNumber = 3)
    {
        print("send post！");
        isRunningAi = true
        let urlString:String = host_var!
        var url:NSURL!
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(URL:url)
        let body = "score={\"name\":\"\(id)\",\"type\":\"control_down\",\"state1\":\(action1),\"state2\":\(action2),\"state3\":\(action1)}"
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
    func sendheart()
    {
        print("send heart！");
        isRunningAi = true
        let urlString:String = host_var!
        var url:NSURL!
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(URL:url)
        let body = "score={\"type\":\"heart\"}"
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
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse)
    {
        print("ReceiveResponse");
       // print(response)
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData)
    {
        print("ReceiveData1");
        let datastring = NSString(data:data, encoding: NSUTF8StringEncoding)
        print(datastring)
        
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
            self.zhuye_ai.stopAnimating()
            self.refreshbtn()
            switch recieve[1] {
            case 0:self.mode_plain.selectedSegmentIndex = 0
                break
            case 1:self.mode_plain.selectedSegmentIndex = 1
                break
            case 2:self.mode_plain.selectedSegmentIndex = 3
                break
            case 3:self.mode_plain.selectedSegmentIndex = 4
                break
            case 4:self.mode_plain.selectedSegmentIndex = 2
                break
            default:break
            }

            if recieve[17] == 1 {
                self.zhuwoqiyebtn_ol.backgroundColor = UIColor.darkGrayColor()
            } else {
                self.zhuwoqiyebtn_ol.backgroundColor = self.shoudongkongzhibtn_ol.backgroundColor
            }
            if recieve[18] == 1 {
                self.ciwoqiyebtn_ol.backgroundColor = UIColor.darkGrayColor()
            } else {
                self.ciwoqiyebtn_ol.backgroundColor = self.shoudongkongzhibtn_ol.backgroundColor
            }
            
            
            
            /*
             0xFAF8 =XIAOMIKAIGUAN1-zhuwo
             0x1AD6 =XIAOMIKAIGUAN2-ciwo
             0xFC44 =XIAOMIMENCI
             
             0x4E8A =KETING -12
             0xB358 =CANTING-13
             0xBE8A =CHUFANG-15
             0xE6B0 =MENTING-14
             0x5680 =GUODAO -16
                    =cesuo  -10
             0x7710 =ZHUWO  -6
             0x9590 =CIWO   -8
             */
//                                          recieve = data
//                                        isRecieved = true
//                                        //isSended = false
//                                        isNeedRefresh1 = true
//                                        isNeedRefresh2 = true
//                                        isNeedRefresh3 = true
//                                        isRunningAi = false
//                                        dispatch_async(dispatch_get_main_queue(), {
//                                            self.zhuye_ai.stopAnimating()
//                                            self.refreshbtn()
//                                            switch recieve[1] {
//                                            case 0:self.mode_plain.selectedSegmentIndex = 0
//                                                break
//                                            case 1:self.mode_plain.selectedSegmentIndex = 1
//                                                break
//                                            case 2:self.mode_plain.selectedSegmentIndex = 3
//                                                break
//                                            case 3:self.mode_plain.selectedSegmentIndex = 4
//                                                break
//                                            case 4:self.mode_plain.selectedSegmentIndex = 2
//                                                break
//                                            default:break
//                                            }
//            
//                                            if recieve[17] == 1 {
//                                                self.zhuwoqiyebtn_ol.backgroundColor = UIColor.darkGrayColor()
//                                            } else {
//                                                self.zhuwoqiyebtn_ol.backgroundColor = self.shoudongkongzhibtn_ol.backgroundColor
//                                            }
//                                            if recieve[18] == 1 {
//                                                self.ciwoqiyebtn_ol.backgroundColor = UIColor.darkGrayColor()
//                                            } else {
//                                                self.ciwoqiyebtn_ol.backgroundColor = self.shoudongkongzhibtn_ol.backgroundColor
//                                            }
//                                            
//                                        })
//                                    }

            
            //print("dict json！");
            //print(dict);
        }catch _ {
            dict = nil
        }
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection)
    {
        print("FinishLoading");
    }
    
    
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError)
    {
        print("request failed");
        print(error)
    }
    
    /*
     序号
     取值
     说明
     0
     0xaa
     帧头
     
     1
     0~3
     模式
     
     2
     0~100
     客厅纱帘
     
     3
     0~100
     客厅布帘
     
     4
     0~100
     主卧布帘
     
     5
     0~100
     次卧布帘
     
     6
     0,1
     主卧灯开关
     
     7
     0~100
     主卧灯亮度
     
     8
     0,1
     次卧灯开关
     
     9
     0~100
     次卧灯亮度
     
     10
     0,1
     厕所灯开关
     
     11
     0~100
     厕所灯亮度
     
     12
     0,1
     客厅灯开关
     
     13
     0,1
     餐厅灯开关
     
     14
     0,1
     门厅灯开关
     
     15
     0,1
     厨房灯开关
     
     16
     0,1
     过道灯开关
     
     17
     0,1
     主卧夜灯
     
     18
     0,1
     次卧夜灯
 
 */
    @IBAction func ciwoqiye_btn(sender: AnyObject) {
        if recieve[18] == 0 {
            sendpost("CIWOQIYE",action1:1,action2:1)
        } else {
            sendpost("CIWOQIYE",action1:0,action2:0)
        }

        /*
         0xFAF8 =XIAOMIKAIGUAN1-zhuwo
         0x1AD6 =XIAOMIKAIGUAN2-ciwo
         0xFC44 =XIAOMIMENCI
         
         0x4E8A =KETING
         0xB358 =CANTING
         0xBE8A =CHUFANG
         0xE6B0 =MENTING
         0x5680 =GUODAO
         0x7710 =ZHUWO
         0x9590 =CIWO
         */
    }
    
    
func refresh(){
    print("viewdidload1")
    // Do any additional setup after loading the view, typically from a nib.
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
        print("fetch pass!")
        print(fetchedObjects?.count)
        if fetchedObjects?.count==0
        {
            add()
            print("add")
        }
        else
        {
            for cd1 in fetchedObjects as! [IdolEntity]
                //let temp = cd1.port
            {
                
                print(cd1.host)
                print(cd1.portnum)
                name1_var = cd1.button1
                name2_var = cd1.button2
                name3_var = cd1.button3
                mode_plain.setTitle(cd1.button1, forSegmentAtIndex: 2)
                mode_plain.setTitle(cd1.button2, forSegmentAtIndex: 3)
                mode_plain.setTitle(cd1.button3, forSegmentAtIndex: 4)
                host_var = cd1.host
                portnum_var = cd1.portnum
            }
        }
    } catch{
        print("fetch failed!")
    }
}
    func add(host:String = "wangyangzhuji.imwork.net",port:NSNumber = 8888,name1:String = "手动",name2:String = "自定2",name3:String = "自定3")
    {
        //获取管理的数据上下文 对象
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        
        //var error:NSError?
        
        //创建User对象
        let cd1 = NSEntityDescription.insertNewObjectForEntityForName("IdolEntity",
            inManagedObjectContext: context) as! IdolEntity
        
        //对象赋值
        cd1.id = 1
        cd1.host = host
        cd1.portnum = port
        cd1.button1 = name1
        cd1.button2 = name2
        cd1.button3 = name3
        host_var = host
        portnum_var = port
        print(host)
        print(port)
        //保存
        
        //context.save()
        do {
            try context.save()
            client.addr = host_var!
            client.port =  portnum_var!.integerValue
            print("add pass!")
            // print(cd1.host)
            
        }
        catch{
            print("add failed!")
        }
    }
       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func cesuodengbtn(sender: AnyObject) {
        isSended = true
        isRunningAi = true
        sendpost("GUODAO_ID",action1:3,action2:2)
        /*
         0xFAF8 =XIAOMIKAIGUAN1-zhuwo
         0x1AD6 =XIAOMIKAIGUAN2-ciwo
         0xFC44 =XIAOMIMENCI
         
         0x4E8A =KETING
         0xB358 =CANTING
         0xBE8A =CHUFANG
         0xE6B0 =MENTING
         0x5680 =GUODAO
         0x7710 =ZHUWO
         0x9590 =CIWO
         */
    }
    
    @IBAction func guodaodeng_btn(sender: AnyObject) {
        isSended = true
        isRunningAi = true
        sendpost("GUODAO_ID",action1:2,action2:3)
        /*
         0xFAF8 =XIAOMIKAIGUAN1-zhuwo
         0x1AD6 =XIAOMIKAIGUAN2-ciwo
         0xFC44 =XIAOMIMENCI
         
         0x4E8A =KETING
         0xB358 =CANTING
         0xBE8A =CHUFANG
         0xE6B0 =MENTING
         0x5680 =GUODAO
         0x7710 =ZHUWO
         0x9590 =CIWO
         */
    }
    
    @IBAction func ciwodeng_btn(sender: AnyObject) {
        isSended = true
        isRunningAi = true
        sendpost("CIWO_ID",action1:3,action2:3)
        /*
         0xFAF8 =XIAOMIKAIGUAN1-zhuwo
         0x1AD6 =XIAOMIKAIGUAN2-ciwo
         0xFC44 =XIAOMIMENCI
         
         0x4E8A =KETING
         0xB358 =CANTING
         0xBE8A =CHUFANG
         0xE6B0 =MENTING
         0x5680 =GUODAO
         0x7710 =ZHUWO
         0x9590 =CIWO
         */
    }

    @IBAction func zhuwodeng_btn(sender: AnyObject) {
        isSended = true
        isRunningAi = true
        sendpost("ZHUWO_ID",action1:3,action2:3)
        /*
         0xFAF8 =XIAOMIKAIGUAN1-zhuwo
         0x1AD6 =XIAOMIKAIGUAN2-ciwo
         0xFC44 =XIAOMIMENCI
         
         0x4E8A =KETING
         0xB358 =CANTING
         0xBE8A =CHUFANG
         0xE6B0 =MENTING
         0x5680 =GUODAO
         0x7710 =ZHUWO
         0x9590 =CIWO
         */
    }
    
    @IBAction func ketingdeng_btn(sender: AnyObject) {
        isSended = true
        isRunningAi = true
        sendpost("KETING_ID",action1:3,action2:3)
        /*
         0xFAF8 =XIAOMIKAIGUAN1-zhuwo
         0x1AD6 =XIAOMIKAIGUAN2-ciwo
         0xFC44 =XIAOMIMENCI
         
         0x4E8A =KETING
         0xB358 =CANTING
         0xBE8A =CHUFANG
         0xE6B0 =MENTING
         0x5680 =GUODAO
         0x7710 =ZHUWO
         0x9590 =CIWO
         */

    }
    
    @IBAction func cantingdeng_btn(sender: AnyObject) {
        isSended = true
        isRunningAi = true
        sendpost("CANTING_ID",action1:3,action2:3)
        /*
         0xFAF8 =XIAOMIKAIGUAN1-zhuwo
         0x1AD6 =XIAOMIKAIGUAN2-ciwo
         0xFC44 =XIAOMIMENCI
         
         0x4E8A =KETING
         0xB358 =CANTING
         0xBE8A =CHUFANG
         0xE6B0 =MENTING
         0x5680 =GUODAO
         0x7710 =ZHUWO
         0x9590 =CIWO
         */

    }
    
    @IBAction func mentingdeng_btn(sender: AnyObject) {
        isSended = true
        isRunningAi = true
        sendpost("MENTING_ID",action1:3,action2:3)
        /*
         0xFAF8 =XIAOMIKAIGUAN1-zhuwo
         0x1AD6 =XIAOMIKAIGUAN2-ciwo
         0xFC44 =XIAOMIMENCI
         
         0x4E8A =KETING
         0xB358 =CANTING
         0xBE8A =CHUFANG
         0xE6B0 =MENTING
         0x5680 =GUODAO
         0x7710 =ZHUWO
         0x9590 =CIWO
         */
        
    }
    
    @IBAction func chufangdeng_btn(sender: AnyObject) {
        isSended = true
        isRunningAi = true
        sendpost("CHUFANG_ID",action1:3,action2:3)
        /*
         0xFAF8 =XIAOMIKAIGUAN1-zhuwo
         0x1AD6 =XIAOMIKAIGUAN2-ciwo
         0xFC44 =XIAOMIMENCI
         
         0x4E8A =KETING
         0xB358 =CANTING
         0xBE8A =CHUFANG
         0xE6B0 =MENTING
         0x5680 =GUODAO
         0x7710 =ZHUWO
         0x9590 =CIWO
         */
        
        
    }
    
    @IBAction func ketingchuanglian_btn(sender: AnyObject) {
        
        if recieve[3] < 50 {
            sendpost("KETINGCHUANGLIAN_ID",action1:100)

        } else {
            sendpost("KETINGCHUANGLIAN_ID",action1:0)
        }
        
        
        
        isSended = true
        isRunningAi = true
        
    }
    
    @IBAction func zhuwochuanglian_btn(sender: AnyObject) {
        
        if recieve[4] < 50 {
            sendpost("ZHUWOCHUANGLIAN_ID",action1:100)
            
        } else {
            sendpost("ZHUWOCHUANGLIAN_ID",action1:0)
        }
        
        //        print(str)
        
        isSended = true
        isRunningAi = true
        
    }
    
    @IBAction func ciwochuanglian_btn(sender: AnyObject) {
        
        if recieve[5] < 50 {
            sendpost("CIWOCHUANGLIAN_ID",action1:100)
            
        } else {
            sendpost("CIWOCHUANGLIAN_ID",action1:0)
        }
        
        //        print(str)

        isSended = true
        isRunningAi = true
        
    }
    
}

