//
//  ViewController.swift
//  PomodoraUIKit
//
//  Created by Али  on 06.05.2023.
//

import UIKit
import SnapKit
class ViewController: UIViewController, CAAnimationDelegate {
    let time = Time(minutes: 23, seconds: 0)
    var timer = Timer()
    var isTimerOn = false
    var remainingTime = 5
    let interval = 1.0
    var breakTime = 300
    
    
    let foreProgressLayer = CAShapeLayer()
    let backProgressLayer = CAShapeLayer()
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    
    
    var isAnimationStarted = false
    
    
    lazy private var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "galaxy.png")
        return image
    }()
    
    
    lazy private var timeLabel: UILabel = {
       let label = UILabel()
        label.text = formatTime(time: remainingTime)
        
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

         button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
         button.layer.cornerRadius = 28
         button.tintColor = .white

         button.layer.masksToBounds = true
         button.layer.backgroundColor = UIColor.white.withAlphaComponent(0.3).cgColor
        button.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)

       return button
    }()
    
    lazy private var playButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white

        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.layer.cornerRadius = 28
        button.tintColor = .white

        button.layer.masksToBounds = true
        button.layer.backgroundColor = UIColor.white.withAlphaComponent(0.3).cgColor
        
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
       return button
    }()
    
    lazy private var focusLabel: UILabel = {
       let label = UILabel()
        label.text = "Focus on your task"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
//

    override func viewDidLoad() {
        super.viewDidLoad()
        remainingTime = (time.minutes * 60) + time.seconds
        view.backgroundColor = .black
        image.frame = view.bounds
        [image,button, timeLabel, playButton, stopButton, focusLabel].forEach {
            view.addSubview($0)
        }
        setupConstraints()
        
        
        drawBackLayers()
    }
    
    @objc func startButtonTapped() {
        if !isTimerOn {
            drawFrontLayers()
            startTimer()
            startResumeAnimation()
            isTimerOn = true
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            
        }
        else {
            timer.invalidate()
            isTimerOn = false
            pauseAnimation()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)

        }
    }
    
    @objc func stopButtonTapped() {
        timer.invalidate()
        remainingTime = (time.minutes * 60) + time.seconds
        timeLabel.text = formatTime(time: remainingTime)
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        stopAnimatiom()
        isTimerOn = false
    }
    
    @objc func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        remainingTime -= 1
        
        timeLabel.text = formatTime(time: remainingTime)
        if remainingTime == 0 {
            remainingTime = 300
            timeLabel.text = formatTime(time: breakTime)
            focusLabel.text = "Break time"
            drawFrontLayers()
            startAnimation()
            startResumeAnimation()

        }
        
    }
    
    func formatTime(time: Int) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }

 
//    bacground
    
    func drawBackLayers() {
        backProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY-111.5), radius: 124, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        
        backProgressLayer.strokeColor = UIColor.white.withAlphaComponent(0.3).cgColor
        backProgressLayer.fillColor = UIColor.clear.cgColor
        backProgressLayer.lineWidth = 6
        view.layer.addSublayer(backProgressLayer)
    }
    
    
//    front
    
    func drawFrontLayers() {
        foreProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY-70), radius: 124, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        foreProgressLayer.strokeColor = UIColor.white.cgColor
        foreProgressLayer.fillColor = UIColor.clear.cgColor
        foreProgressLayer.lineWidth = 6
        view.layer.addSublayer(foreProgressLayer)
    }
    
    func startResumeAnimation() {
        if !isAnimationStarted {
            startAnimation()
        }
        else {
            resumeAnimation()
        }
    }
    
    func startAnimation() {
        resetAnimation()
        foreProgressLayer.strokeEnd = 0.0
        animation.keyPath = "strokeEnd"
        animation.fromValue = 0
        animation.toValue = 1
        
        animation.delegate = self
        
        animation.duration = CFTimeInterval(remainingTime)
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        foreProgressLayer.add(animation, forKey: "strokeEnd")
        isAnimationStarted = true
    }
    
    func resetAnimation() {
        foreProgressLayer.speed = 1.0
        foreProgressLayer.timeOffset = 0.0
        foreProgressLayer.beginTime = 0.0
        foreProgressLayer.strokeEnd = 0.0
        isAnimationStarted = false
    }
    
    
    func pauseAnimation() {
        let pausedTime = foreProgressLayer.convertTime(CACurrentMediaTime(), from: nil)
        foreProgressLayer.speed = 0.0
        foreProgressLayer.timeOffset = pausedTime
    }
    
    
    
    
    func resumeAnimation() {
        let pausedTime = foreProgressLayer.timeOffset
        foreProgressLayer.speed = 1.0
        foreProgressLayer.timeOffset = 0.0
        foreProgressLayer.beginTime  = 0.0
        let timeSincePaused = foreProgressLayer.convertTime(CACurrentMediaTime(), to: nil) - pausedTime
        foreProgressLayer.beginTime = timeSincePaused
        
    }
    
    func stopAnimatiom() {
        foreProgressLayer.speed = 0
        foreProgressLayer.timeOffset = 0
        foreProgressLayer.beginTime = 0
        foreProgressLayer.strokeEnd = 0
        foreProgressLayer.removeAllAnimations()
        isAnimationStarted = false
    }
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        stopAnimatiom()
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
        focusLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
}



extension Int {
    var degreesToRadians: CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
