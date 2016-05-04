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
        if !isconnected {
            let(a,_) = client.connect(timeout:1)
            if a {
                isconnected = true
            }
        }
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
        let ii:[UInt8] = [0xaa,3,UInt8(slider.value*100)]
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
    }
   

    @IBAction func ketingbulian_slider(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        let ii:[UInt8] = [0xaa,4,UInt8(slider.value*100)]
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
    }

    @IBAction func zhuwochuanglian_slider(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        let ii:[UInt8] = [0xaa,5,UInt8(slider.value*100)]
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
    }
    
    
    @IBAction func ciwochuanglian_slider(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        let ii:[UInt8] = [0xaa,6,UInt8(slider.value*100)]
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
    }
    
    @IBAction func zhuwodeng_slider(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        let ii:[UInt8] = [0xaa,8,UInt8(slider.value*100)]
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
    }
    
    @IBAction func ciwodeng_slider(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        let ii:[UInt8] = [0xaa,10,UInt8(slider.value*100)]
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
    }
    
    @IBAction func cesuodeng_slider(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        let ii:[UInt8] = [0xaa,12,UInt8(slider.value*100)]
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
    }
    
    //=====slider======
    
    //===== btn ======
    @IBAction func ketingshalian_btn(sender: AnyObject) {
        //self.presentViewController(alertresend!, animated: true, completion: nil)
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            let ii:[UInt8] = [0xaa,3,100]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                ketingshalianbtn_ol.setOn(false, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                ketingshalianbtn_ol.setOn(false, animated: true)
            }
            isSending = false
        }else{
            let ii:[UInt8] = [0xaa,3,0]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                ketingshalianbtn_ol.setOn(true, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                ketingshalianbtn_ol.setOn(true, animated: true)
            }
            isSending = false
        }
    }
    
    @IBAction func ketingbulian_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            let ii:[UInt8] = [0xaa,4,100]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                ketingbulianbtn_ol.setOn(false, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                ketingbulianbtn_ol.setOn(false, animated: true)
            }
            isSending = false
        }else{
            let ii:[UInt8] = [0xaa,4,0]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                ketingbulianbtn_ol.setOn(true, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                ketingbulianbtn_ol.setOn(true, animated: true)
            }
            isSending = false
        }
    }
    
    @IBAction func zhuwochaunglian_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            let ii:[UInt8] = [0xaa,5,100]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                zhuwochuanglianbtn_ol.setOn(false, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                zhuwochuanglianbtn_ol.setOn(false, animated: true)
            }
            isSending = false
        }else{
            let ii:[UInt8] = [0xaa,5,0]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                zhuwochuanglianbtn_ol.setOn(true, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                zhuwochuanglianbtn_ol.setOn(true, animated: true)
            }
            isSending = false
        }
    }
    
    @IBAction func ciwochuanglian_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            let ii:[UInt8] = [0xaa,6,100]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                ciwochuanglianbtn_ol.setOn(false, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                ciwochuanglianbtn_ol.setOn(false, animated: true)
            }
            isSending = false
        }else{
            let ii:[UInt8] = [0xaa,6,0]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                ciwochuanglianbtn_ol.setOn(true, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                ciwochuanglianbtn_ol.setOn(true, animated: true)
            }
            isSending = false
        }
    }
    
    @IBAction func zhuwodeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            let ii:[UInt8] = [0xaa,7,1]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                zhuwodengbtn_ol.setOn(false, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                zhuwodengbtn_ol.setOn(false, animated: true)
            }
            isSending = false
        }else{
            let ii:[UInt8] = [0xaa,7,0]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                zhuwodengbtn_ol.setOn(true, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                zhuwodengbtn_ol.setOn(true, animated: true)
            }
            isSending = false
        }
    }
    
    @IBAction func ciwodeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            let ii:[UInt8] = [0xaa,9,1]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                ciwodengbtn_ol.setOn(false, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                ciwodengbtn_ol.setOn(false, animated: true)
            }
            isSending = false
        }else{
            let ii:[UInt8] = [0xaa,9,0]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                ciwodengbtn_ol.setOn(true, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                ciwodengbtn_ol.setOn(true, animated: true)
            }
            isSending = false
        }
    }
    
    @IBAction func cesuodeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            let ii:[UInt8] = [0xaa,11,1]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                cesuodengbtn_ol.setOn(false, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                cesuodengbtn_ol.setOn(false, animated: true)
            }
            isSending = false
        }else{
            let ii:[UInt8] = [0xaa,11,0]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                cesuodengbtn_ol.setOn(true, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                cesuodengbtn_ol.setOn(true, animated: true)
            }
            isSending = false
        }
    }
    
    
    @IBAction func ketingdeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            let ii:[UInt8] = [0xaa,13,1]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                ketingdengbtn_ol.setOn(false, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                ketingdengbtn_ol.setOn(false, animated: true)
            }
            isSending = false
        }else{
            let ii:[UInt8] = [0xaa,13,0]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                ketingdengbtn_ol.setOn(true, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                ketingdengbtn_ol.setOn(true, animated: true)
            }
            isSending = false
        }
    }
    
    @IBAction func cantingdeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            let ii:[UInt8] = [0xaa,14,1]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                cantingdengbtn_ol.setOn(false, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                cantingdengbtn_ol.setOn(false, animated: true)
            }
            isSending = false
        }else{
            let ii:[UInt8] = [0xaa,14,0]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                cantingdengbtn_ol.setOn(true, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                cantingdengbtn_ol.setOn(true, animated: true)
            }
            isSending = false
        }
    }
    
    @IBAction func mentingdeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            let ii:[UInt8] = [0xaa,15,1]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                mentingdengbtn_ol.setOn(false, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                mentingdengbtn_ol.setOn(false, animated: true)
            }
            isSending = false
        }else{
            let ii:[UInt8] = [0xaa,15,0]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                mentingdengbtn_ol.setOn(true, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                mentingdengbtn_ol.setOn(true, animated: true)
            }
            isSending = false
        }
    }
    
    @IBAction func chufangdeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            let ii:[UInt8] = [0xaa,16,1]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                chufangdengbtn_ol.setOn(false, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                chufangdengbtn_ol.setOn(false, animated: true)
            }
            isSending = false
        }else{
            let ii:[UInt8] = [0xaa,16,0]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                chufangdengbtn_ol.setOn(true, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                chufangdengbtn_ol.setOn(true, animated: true)
            }
            isSending = false
        }
    }
    
    @IBAction func guodaodeng_btn(sender: AnyObject) {
        let btn:UISwitch = sender as! UISwitch
        if btn.on {
            let ii:[UInt8] = [0xaa,17,1]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                guodaodengbtn_ol.setOn(false, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                guodaodengbtn_ol.setOn(false, animated: true)
            }
            isSending = false
        }else{
            let ii:[UInt8] = [0xaa,17,0]
            //        print(str)
            isSending = true
            isSended = true
            isRunningAi = true
            let (_,msg)=client.send(data:ii)
            if msg == "socket not open"{
                isconnected = false
                self.presentViewController(alertreconnect!, animated: true, completion: nil)
                guodaodengbtn_ol.setOn(true, animated: true)
            }else if msg == "send error" {
                isconnected = false
                self.presentViewController(alertresend!, animated: true, completion: nil)
                guodaodengbtn_ol.setOn(true, animated: true)
            }
            isSending = false
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
