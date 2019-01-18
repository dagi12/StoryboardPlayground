//
//  ProcessSpec.swift
//  StoryboardPlaygroundTests
//
//  Created by Eryk Mariankowski on 18.01.2019.
//  Copyright © 2019 Eryk Mariankowski. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import StoryboardPlayground
@testable import RxSwift

class ProcessPresentationSpec: QuickSpec {

    let bag = DisposeBag()

    override func spec() {
        it("should dismiss process") {
            let ctrl1 = UIViewController()
            ctrl1.title = "1"
            let ctrl2 = UIViewController()
            ctrl2.title = "2"
            let nav = UINavigationController()
            UIApplication.shared.keyWindow!.rootViewController = nav
            nav.pushViewController(ctrl1, animated: false)
            nav.pushViewController(ctrl2, animated: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Change `2.0` to the desired number of seconds.
                Observable<Int>
                    .timer(2, scheduler: MainScheduler.instance)
                    //            .timer(1, scheduler: MainScheduler.instance)
                    .observeOn(MainScheduler.instance)
                    .do(onSubscribe: {
                        self.showProcess(controller: ctrl2, message: "please_wait")
                    })
                    .subscribe(onCompleted: {
                        ctrl2.dismiss(animated: true) {
                            _ = nav.popToRootViewController(animated: true)
                        }
                        return
                    })
                    .disposed(by: self.bag)
            }
            _ = self.expectation(description: "asd")
            self.waitForExpectations(timeout: 99999, handler: nil)
        }
    }

    public func showProcess(controller: UIViewController, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let frameRect = CGRect(
            x: ProcessIndicatorCoords.xCoord, y: ProcessIndicatorCoords.yCoord,
            width: ProcessIndicatorCoords.width, height: ProcessIndicatorCoords.height)
        let loadingIndicator = UIActivityIndicatorView(frame: frameRect)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        controller.present(alert, animated: true, completion: completion)
    }

    struct ProcessIndicatorCoords {
        static let xCoord = 10
        static let yCoord = 5
        static let width = 50
        static let height = 50
    }

}
