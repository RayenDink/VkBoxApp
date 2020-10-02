//
//  LoadViewController.swift
//  VK Client
//
//  Created by Rayen D on 06.09.2020.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController {

    @IBOutlet weak var firstPointLoad: UILabel!
    @IBOutlet weak var secondPointLoad: UILabel!
    @IBOutlet weak var thirdPointLoad: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animatePointsLoad()
        pathAnimation()
        goToTapBarController()
    }
    
    func animatePointsLoad() {
        
        firstPointLoad.transform = CGAffineTransform(translationX: 1, y: 5)
        secondPointLoad.transform = CGAffineTransform(translationX: 1, y: 5)
        thirdPointLoad.transform = CGAffineTransform(translationX: 1, y: 5)
        
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       options: [.autoreverse, .repeat],
                       animations: {
                        self.firstPointLoad.transform = .identity
                        self.firstPointLoad.alpha = 0.2
        },
                       completion: nil)
        
        UIView.animate(withDuration: 1.5,
                       delay: 0.5,
                       options: [.autoreverse, .repeat],
                       animations: {
                        self.secondPointLoad.transform = .identity
                        self.secondPointLoad.alpha = 0.2
        },
                       completion: nil)
        
        UIView.animate(withDuration: 1.5,
                       delay: 1,
                       options: [.autoreverse, .repeat],
                       animations: {
                        
                        self.thirdPointLoad.transform = .identity
                        self.thirdPointLoad.alpha = 0.2
        },
                       completion: nil)
    }
    
    func pathAnimation(){
        
        let cloudView = UIView()
        
        view.addSubview(cloudView)
        cloudView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cloudView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cloudView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            cloudView.widthAnchor.constraint(equalToConstant: 120),
            cloudView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 60))
        path.addQuadCurve(to: CGPoint(x: 20, y: 40), controlPoint: CGPoint(x: 5, y: 50))
        path.addQuadCurve(to: CGPoint(x: 40, y: 20), controlPoint: CGPoint(x: 20, y: 20))
        path.addQuadCurve(to: CGPoint(x: 70, y: 20), controlPoint: CGPoint(x: 55, y: 0))
        path.addQuadCurve(to: CGPoint(x: 80, y: 30), controlPoint: CGPoint(x: 80, y: 20))
        path.addQuadCurve(to: CGPoint(x: 110, y: 60), controlPoint: CGPoint(x: 110, y: 30))
        path.close()
        
        
        let layerAnimation = CAShapeLayer()
        layerAnimation.path = path.cgPath
        layerAnimation.strokeColor = #colorLiteral(red: 0.15667817, green: 0.443811655, blue: 0.7685350776, alpha: 1)
        layerAnimation.fillColor = UIColor.clear.cgColor
        layerAnimation.lineWidth = 4
        layerAnimation.lineCap = .round
        
        cloudView.layer.addSublayer(layerAnimation)
        
        let pathAnimationEnd = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimationEnd.fromValue = 0
        pathAnimationEnd.toValue = 1
        pathAnimationEnd.duration = 2
        pathAnimationEnd.fillMode = .both
        pathAnimationEnd.isRemovedOnCompletion = false
        layerAnimation.add(pathAnimationEnd, forKey: nil)
        
        let pathAnimationStart = CABasicAnimation(keyPath: "strokeStart")
        pathAnimationStart.fromValue = 0
        pathAnimationStart.toValue = 1
        pathAnimationStart.duration = 2
        pathAnimationStart.fillMode = .both
        pathAnimationStart.isRemovedOnCompletion = false
        pathAnimationStart.beginTime = 1
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 3
        animationGroup.fillMode = CAMediaTimingFillMode.backwards
        animationGroup.animations = [pathAnimationEnd, pathAnimationStart]
        animationGroup.repeatCount = .infinity
        layerAnimation.add(animationGroup, forKey: nil)
    }
    
    
    func goToTapBarController() {
        
// Откладываем на 5 секунд:
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "TapBar") as UIViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
}



