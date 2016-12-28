//
//  ViewController.swift
//  MusicCenter
//
//  Created by sylvain vincent on 13/11/2016.
//  Copyright © 2016 sylvain vincent. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {

    @IBOutlet weak var musicTableView: UITableView!
    
    @IBOutlet weak var musicTabBar: UITabBar!
    
    @IBOutlet weak var playAndStillButton: UITabBarItem!
    private var player: AVAudioPlayer?
    var musicCurrentPosition: Int?
    var musicCurrentlyName: String?
    private var musicList = [Music]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //musicList.append(Music(name: "dramatic", url: "test url"))
        //musicList.append(Music(name: "test", url: "test url"))
        getMusics(musicUrl: "http://localhost:8080/musics")
        self.musicTableView.dataSource = self
        self.musicTableView.delegate = self
        
        self.musicTabBar.delegate = self

        
    }
    
    public class func addition(a: Int, b: Int) -> Int{
        return a+b
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    // construction d'une cellule
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.musicTableView.dequeueReusableCell(withIdentifier: "Cell") as! MusicCell
        
        musicCurrentlyName = "\(musicList[indexPath.row].name)"
        print(musicCurrentlyName!)
        cell.musicLabel?.text = musicCurrentlyName
        cell.playButton?.tag = indexPath.row;
        cell.playButton?.addTarget(self, action: #selector(playMusic), for: .touchUpInside)
        
        return cell
    }
    
    func playMusic(sender:UIButton!) {
   
        if let player = try? AVAudioPlayer(data: musicList[sender.tag].data as! Data , fileTypeHint: AVFileTypeAC3){
            playAndStillButton.image = UIImage(named: "pause")
            playAndStillButton.selectedImage = UIImage(named: "pause")
            player.play()
            // player.numberOfLoops = -1
            // player.currentTime = 0
            musicCurrentPosition = sender.tag
            self.player = player
            

        }else{
            let alert = UIAlertController(title: "Attention", message: "Ce fichier n'existe plus", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func getMusics(musicUrl: String){
        var request = URLRequest(url: URL(string: musicUrl)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {data, response, err in
            if err != nil {
                print(err!)
            } else {
                do {
                
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    if let list = parsedData["list"] as? [[String: AnyObject]] {
                        for obj in list{
                            if let musicName = obj["name"] as? String{
                                if let musicData = obj["data"] as? String{
                                     let audioData = NSData(base64Encoded: musicData , options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
                                    self.musicList.append(Music(name: musicName, url: "url", data:audioData!))
                                }
                                
                            }
                            
                        }
                    
                    }
                
                    // On rafraichi la vue du thread principal
                    DispatchQueue.global(qos: .background).async  {
                        self.musicTableView.reloadData()
                    }
                  
                } catch let error as NSError {
                    print(error)
                }
            }
        }.resume()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 1 {
            if musicCurrentPosition != 0{
                if let player = try? AVAudioPlayer(data: musicList[musicCurrentPosition!-1].data as! Data , fileTypeHint: AVFileTypeAC3){
                    
                    playAndStillButton.image = UIImage(named: "pause")
                    player.play()
                    // player.numberOfLoops = -1
                    // player.currentTime = 0
                    musicCurrentPosition = musicCurrentPosition!-1
                    self.player = player
                    
                }
            }
           
        }
        else if item.tag == 2{
            if player != nil {
                 if(self.player?.isPlaying)!{
                    self.player?.pause()
                    
                    item.image = UIImage(named: "play")
                    item.selectedImage = UIImage(named: "play")
                 }else{
                    self.player?.play()
                    item.image = UIImage(named: "pause")
                    item.selectedImage = UIImage(named: "pause")
                }
            }
        }
        else{
            if musicCurrentPosition! < musicList.count-1{
                if let player = try? AVAudioPlayer(data: musicList[musicCurrentPosition!+1].data as! Data , fileTypeHint: AVFileTypeAC3){
                    playAndStillButton.image = UIImage(named: "pause")
                    player.play()
                    // player.numberOfLoops = -1
                    // player.currentTime = 0
                    musicCurrentPosition = musicCurrentPosition!+1
                    self.player = player
                    
                }
            }

        }
        
    }
    
}

