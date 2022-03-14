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
    private var doneBarButton: UIBarButtonItem!
    
    deinit {
        player.view.removeFromSuperview()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchTrailer()
    }

}

extension TrailerPlaybackVC {
    
    func setupUI() {
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        player = Player()
        player.playerDelegate = self
        player.playbackDelegate = self
        player.view.frame = self.view.bounds
        player.view.backgroundColor = Colors.theme
        view.addSubview(player.view)
        addTapGesture()
        addDoneBarButton()
    }
    
    func fetchTrailer() {
        showLoader()
        trailerPlaybackVM.fetchTrailer { [weak self] errorMessage, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.dismissLoader()
                if let error = error {
                    self.presentAlert(Constants.failure, error)
                }
                
                if let errorMessage = errorMessage {
                    self.presentAlert(Constants.failure, nil, errorMessage)
                }
                
                self.playTrailer()
            }
        }
    }
    
    func playTrailer() {
//        player.url = trailerPlaybackVM.trailer.trailerURL
        player.url = Bundle.main.url(forResource: "vikings", withExtension: "mp4")
        player.playFromBeginning()
    }
}

extension TrailerPlaybackVC {
    
    func addTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        player.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTapGestureRecognizer(_ gestureRecognizer: UITapGestureRecognizer) {
        switch self.player.playbackState {
        case .stopped:
            player.playFromBeginning()
        case .paused:
            player.playFromCurrentTime()
        case .playing:
            player.pause()
        case .failed:
            player.pause()
        }
    }
}

extension TrailerPlaybackVC {
    func addDoneBarButton() {
        doneBarButton  = UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(doneBarButtonTapped))
        navigationItem.rightBarButtonItem = doneBarButton
    }
    
    
    @objc func doneBarButtonTapped(bookMarkButton: UIBarButtonItem) {
        player.stop()
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
        self.showLoader()
    }

    public func playerPlaybackDidEnd(_ player: Player) {
        
        print("goint to end")
        navigationController?.popViewController(animated: true)
    }

    public func playerCurrentTimeDidChange(_ player: Player) {
//        let fraction = Double(player.currentTime) / Double(player.maximumDuration)
//        self.player.setProgress(CGFloat(fraction), animated: true)
    }

    public func playerPlaybackWillLoop(_ player: Player) {
//        self.player.reset()
    }
}

extension TrailerPlaybackVC: PlayerDelegate {
    func playerReady(_ player: Player) {
        print("\(#function) player getting readdy")
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        print("\(#function) \(player.playbackState.description)")
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
        print("\(#function) buffering changed")
    }
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }
    
    func player(_ player: Player, didFailWithError error: Error?) {
        print("\(#function)", error.debugDescription )
        self.presentAlert(Constants.failure, error)
    }
}
