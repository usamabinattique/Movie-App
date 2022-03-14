//
//  TrailerPlaybackVC.swift
//  TenTwentyTask
//
//  Created by usama on 14/03/2022.
//

import UIKit
import Player

protocol TrailerPlayBackInjector {
    func inject(viewModel: TrailerPlaybackViewModel)
}

class TrailerPlaybackVC: UIViewController {

    var trailerPlaybackVM: TrailerPlaybackViewModel!
    var player: Player!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


extension TrailerPlaybackVC {
    func setupUI() {
        player = Player()
//        player.playerDelegate = self
        player.playbackDelegate = self
        player.view.frame = self.view.bounds
        
        addChild(self.player)
        view.addSubview(player.view)
        player.didMove(toParent: self)
        
        
        
    }
}

extension TrailerPlaybackVC: TrailerPlayBackInjector {
    func inject(viewModel: TrailerPlaybackViewModel) {
        trailerPlaybackVM = viewModel
    }
}

extension TrailerPlaybackVC: PlayerPlaybackDelegate {
    func playerPlaybackDidLoop(_ player: Player) {
        
    }
    

    public func playerPlaybackWillStartFromBeginning(_ player: Player) {
    }

    public func playerPlaybackDidEnd(_ player: Player) {
        
    }

    public func playerCurrentTimeDidChange(_ player: Player) {
//        let fraction = Double(player.currentTime) / Double(player.maximumDuration)
//        self.player.setProgress(CGFloat(fraction), animated: true)
    }

    public func playerPlaybackWillLoop(_ player: Player) {
//        self.player.reset()
    }
}
