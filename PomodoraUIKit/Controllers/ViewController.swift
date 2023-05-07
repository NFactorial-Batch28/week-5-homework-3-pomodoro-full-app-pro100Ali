//
//  ViewController.swift
//  PomodoraUIKit
//
//  Created by Али  on 06.05.2023.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    let time = Time(minutes: 1, seconds: 0, type: .focusTime)
    var remainingTime = 1500
    var timer = Timer()
    let interval = 1.0
    
    
    lazy private var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "galaxy.png")
        return image
    }()
    
    
    lazy private var timeLabel: UILabel = {
       let label = UILabel()
        label.text = "\(time.minutes):\(time.seconds)"
        label.font = UIFont.systemFont(ofSize: 44, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    lazy private var button: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white

        button.setTitle("Focus Category", for: .normal)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white , for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.backgroundColor = UIColor.white.withAlphaComponent(0.3).cgColor
        button.layer.cornerRadius = 24

        let spacing: CGFloat = 8.0
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: spacing)
        button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: spacing, bottom: 0.0, right: 0.0)
        
       return button
    }()
    
    lazy private var stopButton: UIButton = {
        let button = UIButton()
         button.backgroundColor = .white

         button.setImage(UIImage(systemName: "stop"), for: .normal)
         button.layer.cornerRadius = 28
         button.tintColor = .white

         button.layer.masksToBounds = true
         button.layer.backgroundColor = UIColor.white.withAlphaComponent(0.3).cgColor
         
       return button
    }()
    
    lazy private var playButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white

        button.setImage(UIImage(systemName: "play"), for: .normal)
        button.layer.cornerRadius = 28
        button.tintColor = .white

        button.layer.masksToBounds = true
        button.layer.backgroundColor = UIColor.white.withAlphaComponent(0.3).cgColor
        
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
       return button
    }()
//

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        image.frame = view.bounds
        [image,button, timeLabel, playButton, stopButton].forEach {
            view.addSubview($0)
        }
        setupConstraints()
    }
    

    @objc func startTimer() {
        remainingTime = time.minutes * 60   
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                let minutes = Int(self.remainingTime) / 60
                let seconds = Int(self.remainingTime) % 60
                self.timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
            } else {
                self.timer.invalidate()
                // Perform any necessary actions when the timer is finished
            }
        }
    }
    
    
    
    
    
    func setupConstraints() {
        
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
        }
        
        button.snp.makeConstraints { make in
            make.width.equalTo(170)
            make.height.equalTo(36)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(timeLabel.snp.top).offset(-120)
        }
        
        playButton.snp.makeConstraints { make in
            make.width.equalTo(56)
            make.height.equalTo(56)
            make.top.equalTo(timeLabel.snp.bottom).offset(180)
            make.leading.equalToSuperview().offset(100)

        }
        stopButton.snp.makeConstraints { make in
            make.width.equalTo(56)
            make.height.equalTo(56)
            make.top.equalTo(timeLabel.snp.bottom).offset(180)
            //            make.leading.equalTo(playButton.snp.trailing).offset(30)
            make.trailing.equalToSuperview().inset(100)
            
        }
    }
    
}
