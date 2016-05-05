//
//  ViewController2.swift
//  idol
//
//  Created by 吴汪洋 on 15/12/15.
//  Copyright © 2015年 吴汪洋. All rights reserved.
//

import UIKit



class ViewController2: UIViewController {
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var zidingye_ai: UIActivityIndicatorView!
    @IBOutlet weak var ketingshalianbtn_ol: UISwitch!
    @IBOutlet weak var ketingbulianbtn_ol: UISwitch!
    @IBOutlet weak var zhuwochuanglianbtn_ol: UISwitch!
    @IBOutlet weak var ciwochuanglianbtn_ol: UISwitch!

    @IBOutlet weak var zhuwodengbtn_ol: UISwitch!
    @IBOutlet weak var ciwodengbtn_ol: UISwitch!
    @IBOutlet weak var cesuodengbtn_ol: UISwitch!
    @IBOutlet weak var ketingdengbtn_ol: UISwitch!
    @IBOutlet weak var cantingdengbtn_ol: UISwitch!
    @IBOutlet weak var mentingdengbtn_ol: UISwitch!
    @IBOutlet weak var chufangdengbtn_ol: UISwitch!
    @IBOutlet weak var guodaodengbtn_ol: UISwitch!
    @IBOutlet weak var ketingshalianslider_ol: UISlider!
    @IBOutlet weak var ketingbulianslider_ol: UISlider!
    @IBOutlet weak var zhuwochuanglianslider_ol: UISlider!
    @IBOutlet weak var ciwochuanglianslider_ol: UISlider!
    @IBOutlet weak var zhuwodengslider_ol: UISlider!
    @IBOutlet weak var ciwodengslider_ol: UISlider!
    @IBOutlet weak var cesuodengslider_ol: UISlider!
    
    
    
    
    func doInBackground(block:()->()){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            block()
        })
    }
    
    var oldWait:Bool = false
    var isRunning:Bool = false
    var timer: NSTimer?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        isNeedRefresh2 = true

        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
        }
        refresh2()
        print("willappeare2")
        oldIsRunningAI = !isRunningAi
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertreconnect = UIAlertController(title: "", message: "网络连接失败！", preferredStyle: UIAlertControllerStyle.Alert)
        alertreconnect?.addAction(reconnect)
        alertreconnect?.addAction(cancel)
        
        alertresend = UIAlertController(title: "", message: "数据发送失败！", preferredStyle: UIAlertControllerStyle.Alert)
        alertresend?.addAction(resend)
        alertresend?.addAction(cancel)
        
        
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
        }
        // Do any additional setup after loading the view.
    }
    func refresh2() {
        //print("refresh2")
        if isNeedRefresh2 {
            isNeedRefresh2 = false
            if recieve[2] < 50 {
                ketingshalianbtn_ol.setOn(false, animated: true)
            }else if recieve[2] >= 50
            {
                ketingshalianbtn_ol.setOn(true,animated: true)
            }
            
            if recieve[3] < 50 {
                ketingbulianbtn_ol.setOn(false, animated: true)
            }else if recieve[3] >= 50
            {
                ketingbulianbtn_ol.setOn(true,animated: true)
            }
            
            if recieve[4] < 50 {
                zhuwochuanglianbtn_ol.setOn(false, animated: true)
            }else if recieve[4] >= 50
            {
                zhuwochuanglianbtn_ol.setOn(true,animated: true)
            }
            
            if recieve[5] < 50 {
                ciwochuanglianbtn_ol.setOn(false, animated: true)
            }else if recieve[5] >= 50
            {
                ciwochuanglianbtn_ol.setOn(true,animated: true)
            }
            
            if recieve[6] == 1 {
                zhuwodengbtn_ol.setOn(true, animated: true)
            }else if recieve[6] == 0
            {
                zhuwodengbtn_ol.setOn(false,animated: true)
            }
            
            if recieve[8] == 1 {
                ciwodengbtn_ol.setOn(true, animated: true)
            }else if recieve[8] == 0
            {
                ciwodengbtn_ol.setOn(false,animated: true)
            }
            
            if recieve[10] == 1 {
                cesuodengbtn_ol.setOn(true, animated: true)
            }else if recieve[10] == 0
            {
                cesuodengbtn_ol.setOn(false,animated: true)
            }
            
            if recieve[12] == 1 {
                ketingdengbtn_ol.setOn(true, animated: true)
            }else if recieve[12] == 0
            {
                ketingdengbtn_ol.setOn(false,animated: true)
            }
            
            if recieve[13] == 1 {
                cantingdengbtn_ol.setOn(true, animated: true)
            }else if recieve[13] == 0
            {
                cantingdengbtn_ol.setOn(false,animated: true)
            }
            
            if recieve[14] == 1 {
                mentingdengbtn_ol.setOn(true, animated: true)
            }else if recieve[14] == 0
            {
                mentingdengbtn_ol.setOn(false,animated: true)
            }
            
            if recieve[15] == 1 {
                chufangdengbtn_ol.setOn(true, animated: true)
            }else if recieve[15] == 0
            {
                chufangdengbtn_ol.setOn(false,animated: true)
            }
            
            if recieve[16] == 1 {
                guodaodengbtn_ol.setOn(true, animated: true)
            }else if recieve[16] == 0
            {
                guodaodengbtn_ol.setOn(false,animated: true)
            }
            
            var i = (Float)(recieve[2])
            ketingshalianslider_ol.setValue((i/100), animated: true)
            
            i = (Float)(recieve[3])
            ketingbulianslider_ol.setValue((i/100), animated: true)
            
            i = (Float)(recieve[4])
            zhuwochuanglianslider_ol.setValue((i/100), animated: true)
            
            i = (Float)(recieve[5])
            ciwochuanglianslider_ol.setValue((i/100), animated: true)
            
            i = (Float)(recieve[7])
            zhuwodengslider_ol.setValue((i/100), animated: true)
            
            i = (Float)(recieve[9])
            ciwodengslider_ol.setValue((i/100), animated: true)
            
            i = (Float)(recieve[11])
            cesuodengslider_ol.setValue((i/100), animated: true)
        }
    }
    var oldIsRunningAI = !isRunningAi
    func updateTimer(timer: NSTimer) {
        
        if oldIsRunningAI != isRunningAi {
            if isRunningAi {
                zidingye_ai.startAnimating()
            } else {
                zidingye_ai.stopAnimating()
            }
            oldIsRunningAI = isRunningAi
        }
        refresh2()
        
        
        //print("updatetimer2")
    }

    func connection(connection: NSURLConnection, didReceiveData data: NSData)
    {
        print("ReceiveData2");
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
        }catch _ {
            dict = nil
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
    
    
    var reconnect = UIAlertAction(title: "重连", style: UIAlertActionStyle.Default){
        (action: UIAlertAction!) -> Void in
        if !isconnected {
         //   isSended = false
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
       // isSended = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //=====slider======
    @IBAction func ketingshalian_slider(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        isSended = true
        isRunningAi = true
        sendpost("KETINGSHALIAN_ID",action1:(slider.value*100))
    }
   

    @IBAction func ketingbulian_slider(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        //        print(str)
        isSended = true
        isRunningAi = true
        sendpost("KETINGCHUANGLIAN_ID",action1:(slider.value*100))
    }

    @IBAction func zhuwochuanglian_slider(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        isSended = true
        isRunningAi = true
        sendpost("ZHUWOCHUANGLIAN_ID",action1:(slider.value*100))
    }
    
    
    @IBAction func ciwochuanglian_slider(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        isSended = true
        isRunningAi = true
        sendpost("CIWOCHUANGLIAN_ID",action1:(slider.value*100))
    }
    
    @IBAction func zhuwodeng_slider(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        isSended = true
        isRunningAi = true
        sendpost("ZHUWODENGLIANGDU",action1:(slider.value*100))
    }
    
    @IBAction func ciwodeng_slider(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        isSended = true
        isRunningAi = true
        sendpost("CIWODENGLIANGDU",action1:(slider.value*100))
    }
    
    @IBAction func cesuodeng_slider(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        isSended = true
        isRunningAi = true
        sendpost("CESUODENGLAINGDU",action1:(slider.value*100))
    }
    
    //=====slider======
    
    //===== btn ======
    @IBAction func ketingshalian_btn(sender: AnyObject) {
        //self.presentViewController(alertresend!, animated: true, completion: nil)
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            isSended = true
            isRunningAi = true
            sendpost("KETINGSHALIAN_ID",action1:100)
        }else{
            isSended = true
            isRunningAi = true
            sendpost("KETINGSHALIAN_ID",action1:0)
        }
    }
    
    @IBAction func ketingbulian_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            isSended = true
            isRunningAi = true
            sendpost("KETINGCHUANGLIAN_ID",action1:100)
        }else{
            isSended = true
            isRunningAi = true
            sendpost("KETINGCHUANGLIAN_ID",action1:0)
        }
    }
    
    @IBAction func zhuwochaunglian_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            isSended = true
            isRunningAi = true
            sendpost("ZHUWOCHUANGLIAN_ID",action1:100)
        }else{
            isSended = true
            isRunningAi = true
            sendpost("ZHUWOCHUANGLIAN_ID",action1:0)
        }
    }
    
    @IBAction func ciwochuanglian_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            isSended = true
            isRunningAi = true
            sendpost("CIWOCHAUNGLIAN_ID",action1:100)
        }else{
            isSended = true
            isRunningAi = true
            sendpost("CIWOCHAUNGLIAN_ID",action1:0)
        }
    }
    
    @IBAction func zhuwodeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            isSended = true
            isRunningAi = true
            sendpost("ZHUWO_ID",action1:1)
        }else{
            isSended = true
            isRunningAi = true
            sendpost("ZHUWO_ID",action1:0)
        }
    }
    
    @IBAction func ciwodeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            isSended = true
            isRunningAi = true
            sendpost("CIWO_ID",action1:1)
        }else{
            isSended = true
            isRunningAi = true
            sendpost("CIWO_ID",action1:0)
        }
    }
    
    @IBAction func cesuodeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            isSended = true
            isRunningAi = true
            sendpost("GUODAO_ID",action1:1,action2:2)
        }else{
            isSended = true
            isRunningAi = true
            sendpost("GUODAO_ID",action1:0,action2:2)
        }
    }
    
    
    @IBAction func ketingdeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            isSended = true
            isRunningAi = true
            sendpost("KETING_ID",action1:1)
        }else{
            isSended = true
            isRunningAi = true
            sendpost("KETING_ID",action1:0)
        }
    }
    
    @IBAction func cantingdeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            isSended = true
            isRunningAi = true
            sendpost("CANTING_ID",action1:1)
        }else{
            isSended = true
            isRunningAi = true
            sendpost("CANTING_ID",action1:0)
        }
    }
    
    @IBAction func mentingdeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            isSended = true
            isRunningAi = true
            sendpost("MENTING_ID",action1:1)
        }else{
            isSended = true
            isRunningAi = true
            sendpost("MENTING_ID",action1:0)
        }
    }
    
    @IBAction func chufangdeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            isSended = true
            isRunningAi = true
            sendpost("CHUFANG_ID",action1:1)
        }else{
            isSended = true
            isRunningAi = true
            sendpost("CHUFANG_ID",action1:0)
        }
    }
    @IBAction func guodaodeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            isSended = true
            isRunningAi = true
            sendpost("GUODAO_ID",action1:2,action2:1)
        }else{
            isSended = true
            isRunningAi = true
            sendpost("GUODAO_ID",action1:2,action2:0)
        }
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
